
--// Made by reaIuni @ Roblox
--// Executable client-side command UI
local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local BINDS_FILE = "executor_binds.json"
local WAYPOINT_FILE = "executor_waypoints.json"
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local print = print
local STATE
local CONFIG
local UI = {}
local commandExecutor

local originalPrint = print
local Commands = {}
local CommandsByName = {}
local CommandNames = {}
local TAB_FILL_COMMANDS

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- UI CREATION
--////////////////////////////////////////////////////

do
	local function applyProps(instance, props)
		for key, value in pairs(props) do
			pcall(function()
				instance[key] = value
			end)
		end
		return instance
	end

	local DEFAULT_CMDR_FONT_FACE = Font.new("rbxasset://fonts/families/GothamSSm.json")
	local DEFAULT_CMDR_FONT = Enum.Font.Gotham

	local function newInstance(className, props, parent)
		local obj = Instance.new(className)

		if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			obj.FontFace = DEFAULT_CMDR_FONT_FACE
			obj.Font = DEFAULT_CMDR_FONT
		end

		if props then
			applyProps(obj, props)
		end

		if parent then
			obj.Parent = parent
		end

		return obj
	end

	local function createTextLabel(props, parent)
		return newInstance("TextLabel", props, parent)
	end

	local function createFrame(props, parent)
		return newInstance("Frame", props, parent)
	end

	local function createTextButton(props, parent)
		return newInstance("TextButton", props, parent)
	end

	local function createScrollingFrame(props, parent)
		return newInstance("ScrollingFrame", props, parent)
	end

	local function createTextBox(props, parent)
		return newInstance("TextBox", props, parent)
	end

	local function createUICorner(radius, parent)
		return newInstance("UICorner", {
			CornerRadius = radius
		}, parent)
	end

	local function createUIAspectRatioConstraint(props, parent)
		return newInstance("UIAspectRatioConstraint", props, parent)
	end

	commandExecutor = newInstance("ScreenGui", {
		Name = "CommandExecutor",
		DisplayOrder = 999999,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})

	local main = createFrame({
		Name = "Main",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderColor = BrickColor.new("Really black"),
	}, commandExecutor)

	--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	-- TUTORIAL FRAMES
	--////////////////////////////////////////////////////

	local tutorialFrames = createFrame({
		Name = "TutorialFrames",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor = BrickColor.new("Really black"),
	}, main)

	local function createTutorialFrame(name)
		return createFrame({
			Name = name,
			BackgroundTransparency = 0.25,
			BorderSizePixel = 0,
			Visible = false,
			Size = UDim2.fromScale(1, 1),
			BorderColor3 = Color3.fromRGB(17, 17, 17),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor = BrickColor.new("Really black"),
		}, tutorialFrames)
	end

	local function createTutorialLabel(name, text, pos, size, bold, parent, extraProps)
		local props = {
			Name = name,
			Text = text,
			TextSize = 14,
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			TextWrapped = true,
			TextScaled = true,
			Size = size,
			Position = pos,
			FontFace = bold
				and Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
				or Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderColor3 = Color3.fromRGB(17, 17, 17),
			BorderColor = BrickColor.new("Really black"),
		}

		if extraProps then
			for key, value in pairs(extraProps) do
				props[key] = value
			end
		end

		return createTextLabel(props, parent)
	end

	local function createTutorialImage(name, imageId, pos, size, parent, extraProps)
		local props = {
			Name = name,
			Image = imageId,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = size,
			Position = pos,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor = BrickColor.new("Really black"),
		}

		if extraProps then
			for key, value in pairs(extraProps) do
				props[key] = value
			end
		end

		return newInstance("ImageLabel", props, parent)
	end

	local function createNextButton(parent)
		local nextFrame = createFrame({
			Name = "Next",
			BorderSizePixel = 0,
			Size = UDim2.fromScale(0.2136, 0.0603),
			Position = UDim2.fromScale(0.3928, 0.8929),
			BackgroundColor3 = Color3.fromRGB(21, 23, 26),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor = BrickColor.new("Really black"),
		}, parent)

		createTextButton({
			Name = "NextButton",
			Text = "NEXT",
			BorderSizePixel = 0,
			TextSize = 30,
			TextWrapped = true,
			Position = UDim2.fromScale(0, -0.2259),
			Size = UDim2.fromScale(1, 1),
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundColor3 = Color3.fromRGB(37, 39, 45),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor = BrickColor.new("Really black"),
		}, nextFrame)

		return nextFrame
	end

	local function createTutorialChoiceButton(frameName, buttonName, buttonText, position, parent)
		local outer = createFrame({
			Name = frameName,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(0.2136, 0.0603),
			Position = position,
			BackgroundColor3 = Color3.fromRGB(21, 23, 26),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor = BrickColor.new("Really black"),
		}, parent)

		createTextButton({
			Name = buttonName,
			Text = buttonText,
			BorderSizePixel = 0,
			TextSize = 30,
			TextWrapped = true,
			Position = UDim2.fromScale(0, -0.2259),
			Size = UDim2.fromScale(1, 1),
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundColor3 = Color3.fromRGB(37, 39, 45),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderColor = BrickColor.new("Really black"),
		}, outer)

		return outer
	end

	--////////////////////////////////////////////////////
	-- TUTORIAL 0
	--////////////////////////////////////////////////////

	local tutorial0 = createTutorialFrame("Tutorial0")

	createTutorialLabel(
		"1",
		"Hey, looks like it's your first time executing this script!",
		UDim2.fromScale(0, 0.1368),
		UDim2.fromScale(1, 0.0529),
		true,
		tutorial0
	)

	createTutorialLabel(
		"2",
		"You can skip the tutorial, but it is not recommended, tutorial features important functions of this script, as well as all of the keybinds, and more!",
		UDim2.fromScale(0.1426, 0.2201),
		UDim2.fromScale(0.7142, 0.0582),
		false,
		tutorial0
	)

	createTutorialChoiceButton(
		"Yes",
		"YesButton",
		"Sure, why not?",
		UDim2.fromScale(0.2324, 0.5097),
		tutorial0
	)

	createTutorialChoiceButton(
		"No",
		"NoButton",
		"Nah, i got it!",
		UDim2.fromScale(0.5532, 0.5097),
		tutorial0
	)

	--////////////////////////////////////////////////////
	-- TUTORIAL 1
	--////////////////////////////////////////////////////

	local tutorial1 = createTutorialFrame("Tutorial1")

	createTutorialLabel(
		"1",
		"Let's begin shall we?",
		UDim2.fromScale(0, 0.1368),
		UDim2.fromScale(1, 0.0529),
		true,
		tutorial1
	)

	createTutorialLabel(
		"2",
		"First off, there are commands that use distance arguments, such as:",
		UDim2.fromScale(0.1426, 0.2425),
		UDim2.fromScale(0.7142, 0.0339),
		false,
		tutorial1
	)

	createTutorialImage(
		"3",
		"rbxassetid://90502577191387",
		UDim2.fromScale(0.3662, 0.3046),
		UDim2.fromScale(0.2675, 0.1739),
		tutorial1
	)

	createTutorialLabel(
		"4",
		"Executing \"esp\" is just fine, if you don't specify the distance, it makes it infinite.",
		UDim2.fromScale(0.1426, 0.5071),
		UDim2.fromScale(0.7142, 0.0339),
		false,
		tutorial1
	)

	createNextButton(tutorial1)

	--////////////////////////////////////////////////////
	-- TUTORIAL 2
	--////////////////////////////////////////////////////

	local tutorial2 = createTutorialFrame("Tutorial2")

	createTutorialLabel(
		"1",
		"Now something that can make the cmdr usage easier!",
		UDim2.fromScale(0, 0.3868),
		UDim2.fromScale(1, 0.0529),
		true,
		tutorial2
	)

	createTutorialLabel(
		"2",
		"To autofill an command, simply press \"TAB\" on your keyboard!",
		UDim2.fromScale(0.1426, 0.5314),
		UDim2.fromScale(0.7142, 0.0339),
		false,
		tutorial2
	)

	createTutorialLabel(
		"3",
		"Command suggesting is firstly based on your input and then it sorts the commands in an alphabetical order!",
		UDim2.fromScale(0, 0.5781),
		UDim2.fromScale(1, 0.0339),
		false,
		tutorial2
	)

	createNextButton(tutorial2)

	--////////////////////////////////////////////////////
	-- TUTORIAL 3
	--////////////////////////////////////////////////////

	local tutorial3 = createTutorialFrame("Tutorial3")

	createTutorialLabel(
		"1",
		"Now something that will definietly make you come back!",
		UDim2.fromScale(0, 0.0649),
		UDim2.fromScale(1, 0.0529),
		true,
		tutorial3
	)

	createTutorialLabel(
		"2",
		"You can bind a command or multiple commands to a key! - There are 3 types of bindings:",
		UDim2.fromScale(0.1426, 0.1627),
		UDim2.fromScale(0.7142, 0.0339),
		false,
		tutorial3
	)

	createTutorialLabel(
		"3",
		"bind - holdbind - togglebind",
		UDim2.fromScale(0.1426, 0.2055),
		UDim2.fromScale(0.7142, 0.0339),
		false,
		tutorial3
	)

	createTutorialImage(
		"4",
		"rbxassetid://86273971822766",
		UDim2.fromScale(0.1248, 0.3115),
		UDim2.fromScale(0.2419, 0.1398),
		tutorial3
	)

	createTutorialLabel(
		"5",
		"bind lets you bind a command, for example freecam, fly, esp 500, to a specific key, pressing that key will execute that command once.",
		UDim2.fromScale(0.1415, 0.4711),
		UDim2.fromScale(0.2084, 0.0991),
		false,
		tutorial3,
		{
			TextScaled = true,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		}
	)

	createTutorialImage(
		"6",
		"rbxassetid://86738282350042",
		UDim2.fromScale(0.3793, 0.3115),
		UDim2.fromScale(0.2419, 0.1398),
		tutorial3
	)

	createTutorialLabel(
		"7",
		"holdbind lets you bind a command, for example freecam, fly, esp 500 to a specific key, pressing that key will execute that command as long as the key is being held.",
		UDim2.fromScale(0.396, 0.4711),
		UDim2.fromScale(0.2084, 0.1205),
		false,
		tutorial3,
		{
			TextScaled = true,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		}
	)

	createTutorialImage(
		"8",
		"rbxassetid://123356164099294",
		UDim2.fromScale(0.6327, 0.3115),
		UDim2.fromScale(0.2419, 0.1398),
		tutorial3
	)

	createTutorialLabel(
		"9",
		"togglebind lets you bind a command, for example freecam, fly, esp 500 to a specific key, pressing that key will execute the command, however pressing it again will disable it, if you togglebinded freecam, pressing the key once enables it, pressing the key for the second time disables it.",
		UDim2.fromScale(0.6494, 0.4711),
		UDim2.fromScale(0.2084, 0.2148),
		false,
		tutorial3,
		{
			TextScaled = true,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		}
	)

	createTutorialLabel(
		"10",
		"Binding commands is really useful, especially for freecam, fly, clickteleport, etc.",
		UDim2.fromScale(0.1424, 0.7757),
		UDim2.fromScale(0.7142, 0.0339),
		false,
		tutorial3
	)

	createNextButton(tutorial3)

	--////////////////////////////////////////////////////
	-- TUTORIAL 4
	--////////////////////////////////////////////////////

	local tutorial4 = createTutorialFrame("Tutorial4")

	createTutorialLabel(
		"1",
		"Something that's also worth of saying",
		UDim2.fromScale(0, 0.0649),
		UDim2.fromScale(1, 0.0529),
		true,
		tutorial4
	)

	createTutorialLabel(
		"2",
		"There are multiple useful features such as:",
		UDim2.fromScale(0.1426, 0.1627),
		UDim2.fromScale(0.7142, 0.0339),
		false,
		tutorial4
	)

	createTutorialLabel("3", "waypointcreate", UDim2.fromScale(0.1426, 0.2055), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("4", "waypointdelete", UDim2.fromScale(0.1426, 0.2386), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("5", "waypoints", UDim2.fromScale(0.1426, 0.2717), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("6", "showwaypoints", UDim2.fromScale(0.1426, 0.3047), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("7", "hidewaypoints", UDim2.fromScale(0.1426, 0.3378), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("8", "help", UDim2.fromScale(0.1426, 0.3894), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("9", "binds", UDim2.fromScale(0.1426, 0.4224), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("10", "clearbinds", UDim2.fromScale(0.1426, 0.4555), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("11", "executorintro {on/off}", UDim2.fromScale(0.1426, 0.4886), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("12", "enablesoundnotificaitons", UDim2.fromScale(0.1426, 0.5217), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("13", "disablesoundnotificaitons", UDim2.fromScale(0.1426, 0.5547), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)
	createTutorialLabel("14", "And many more!", UDim2.fromScale(0.1426, 0.6374), UDim2.fromScale(0.7142, 0.0339), false, tutorial4)

	createNextButton(tutorial4)

	--////////////////////////////////////////////////////
	-- TUTORIAL 5
	--////////////////////////////////////////////////////

	local tutorial5 = createTutorialFrame("Tutorial5")

	createTutorialLabel(
		"1",
		"And lastly the most important thing!",
		UDim2.fromScale(0, 0.4374),
		UDim2.fromScale(1, 0.0529),
		true,
		tutorial5
	)

	createTutorialLabel(
		"2",
		"If you have any suggestions, bug reports, or anything that could help me make this even better, please execute the command: \"contact {your message here}\" <- Every message is appreciated!",
		UDim2.fromScale(0.1431, 0.5119),
		UDim2.fromScale(0.7142, 0.0504),
		false,
		tutorial5
	)

	createNextButton(tutorial5)


	local welcome = createFrame({
		Name = "Welcome",
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		Visible = false,
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderColor = BrickColor.new("Really black"),
	}, main)

	createTextLabel({
		Name = "Title1",
		Text = "UNI'S .LuaU COMMAND EXECUTOR",
		TextSize = 14,
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		TextWrapped = true,
		TextScaled = true,
		Size = UDim2.fromScale(1, 0.0529),
		Position = UDim2.fromScale(0, 0.4083),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, welcome)

	createTextLabel({
		Name = "Title2",
		Text = "Welcome back, username.",
		TextSize = 14,
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		TextWrapped = true,
		TextScaled = true,
		Size = UDim2.fromScale(1, 0.0359),
		Position = UDim2.fromScale(0, 0.4614),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, welcome)

	createTextLabel({
		Name = "Title3",
		Text = "Press ' ; ' to Open the Menu",
		TextSize = 14,
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		TextWrapped = true,
		TextScaled = true,
		Size = UDim2.fromScale(1, 0.0359),
		Position = UDim2.fromScale(0, 0.5547),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, welcome)

	local bg = createFrame({
		Name = "BG",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		Size = UDim2.fromScale(1, 0.1823),
		Position = UDim2.fromScale(0, 0.1058),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor = BrickColor.new("Really black"),
	}, main)

	local mainBg = createFrame({
		Name = "MainBG",
		BorderSizePixel = 0,
		BackgroundTransparency = 0.4499,
		Size = UDim2.fromScale(0.71, 0.1821),
		Position = UDim2.fromScale(0.1447, 1.1972),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, bg)

	local promptLabel = createTextLabel({
		Name = "PromptLabel",
		Text = LocalPlayer.Name .. "@Cmdr$",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 18,
		TextWrapped = false,
		TextScaled = false,
		Size = UDim2.new(0, 0, 0.5148, 0),
		Position = UDim2.new(0, 6, 0.2316, 0),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(202, 177, 53),
		BorderColor = BrickColor.new("Really black"),
	}, mainBg)

	createTextBox({
		Name = "CommandInput",
		Text = "",
		PlaceholderText = "Type 'help' to view all of the commands",
		TextSize = 22,
		CursorPosition = -1,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		TextWrapped = false,
		TextScaled = false,
		Size = UDim2.new(1, -140, 0.5148, 0),
		Position = UDim2.new(0, 120, 0.2316, 0),
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextColor3 = Color3.fromRGB(227, 227, 227),
		PlaceholderColor3 = Color3.fromRGB(170, 170, 170),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, mainBg)

	local helperBg = createFrame({
		Name = "HelperBG",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Visible = false,
		Size = UDim2.fromScale(0.71, 2.5497),
		Position = UDim2.fromScale(0.1447, 1.4256),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor = BrickColor.new("Really black"),
	}, bg)

	local helperScrollingFrame = createScrollingFrame({
		Name = "ScrollingFrame",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 0,
		Active = true,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Size = UDim2.fromScale(1, 1),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor = BrickColor.new("Really black"),
	}, helperBg)

	newInstance("UIListLayout", {
		Name = "UIListLayout",
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, helperScrollingFrame)

	local version = createTextLabel({
		Name = "Version",
		Text = "CMDR BUILD VERSION: 1.1.3",
		BackgroundTransparency = 1,
		TextSize = 17,
		BorderSizePixel = 0,
		Visible = false,
		TextWrapped = true,
		Position = UDim2.fromScale(0.0041, 4.794),
		Size = UDim2.new(0.9958, 94, 0.1099, 0),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
		TextYAlignment = Enum.TextYAlignment.Top,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor = BrickColor.new("Really black"),
	}, bg)

	newInstance("UIStroke", {
		Thickness = 2
	}, version)

	local exampleHelper = createFrame({
		Name = "ExampleHelper",
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Visible = false,
		Size = UDim2.new(1, 0, 0, 28),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor = BrickColor.new("Really black"),
	}, helperScrollingFrame)

	createTextLabel({
		Name = "CommandLine",
		Text = "Command Name : Command Description",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 14,
		RichText = true,	
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(202, 177, 53),
		BorderColor = BrickColor.new("Really black"),
	}, exampleHelper)

	local commandSuggester = createFrame({
		Name = "CommandSuggester",
		BorderSizePixel = 0,
		BackgroundTransparency = 0.3,
		Visible = false,
		Size = UDim2.fromScale(0.18, 0.0917),
		Position = UDim2.fromScale(0.2275, 0.365),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor = BrickColor.new("Really black"),
	}, main)

	createTextLabel({
		Name = "CommandName",
		Text = "player esp",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 24,
		TextWrapped = false,
		TextScaled = false,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.fromScale(0.93, 0.24),
		Position = UDim2.fromScale(0.0388, 0.08),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor = BrickColor.new("Really black"),
	}, commandSuggester)

	createTextLabel({
		Name = "CommandDescription",
		Text = "Command Description Goes Here, Command Description Goes Here, Command Description Goes Here, ",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 20,
		TextWrapped = true,
		TextScaled = false,
		Position = UDim2.fromScale(0.0388, 0.36),
		Size = UDim2.fromScale(0.9269, 0.44),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		Font = Enum.Font.Gotham,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, commandSuggester)

	local suggesterContainer = createFrame({
		Name = "Container",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0.1782),
		Position = UDim2.fromScale(0, 0.9993),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, commandSuggester)

	newInstance("UIListLayout", {
		Name = "UIListLayout",
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, suggesterContainer)

	local exampleSuggestion = createFrame({
		Name = "ExampleSuggestion",
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
		Visible = false,
		Size = UDim2.fromScale(1, 1.5276),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor = BrickColor.new("Really black"),
	}, suggesterContainer)

	createTextLabel({
		Name = "CommandName",
		Text = "player esp",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 18,
		TextWrapped = true,
		TextScaled = false,
		Size = UDim2.fromScale(0.9818, 0.5881),
		Position = UDim2.fromScale(0.0388, 0.1932),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(159, 182, 202),
		BorderColor = BrickColor.new("Really black"),
	}, exampleSuggestion)

	local chatModule = createFrame({
		Name = "ChatModule",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor = BrickColor.new("Really black"),
	}, main)

	local window = createFrame({
		Name = "Window",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.2469, 0.4386),
		Position = UDim2.fromScale(0.3763, 0.3289),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, chatModule)
	createUICorner(UDim.new(0, 5), window)
	createUIAspectRatioConstraint({
		AspectRatio = 1.205,
	}, window)

	local chatModuleTop = createFrame({
		Name = "ChatModuleTop",
		BorderSizePixel = 0,
		BackgroundTransparency = 0.4,
		Active = true,
		Size = UDim2.fromScale(1, 0.0719),
		Position = UDim2.fromScale(-0.0011, -0.0011),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, window)
	createUIAspectRatioConstraint({
		AspectRatio = 17,
	}, chatModuleTop)

	createTextLabel({
		Name = "PromptLabel",
		Text = "RobloxChatSpy-Module.lua",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 14,
		TextWrapped = true,
		TextScaled = true,
		Size = UDim2.fromScale(0.4645, 0.5148),
		Position = UDim2.fromScale(0.0188, 0.2215),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(202, 177, 53),
		BorderColor = BrickColor.new("Really black"),
	}, chatModuleTop)

	local closeButton = createTextButton({
		Name = "Close",
		Text = "",
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		TextSize = 19,
		TextWrapped = true,
		TextScaled = true,
		Position = UDim2.fromScale(0.9499, 0.3203),
		Size = UDim2.fromScale(0.024, 0.6082),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(198, 38, 38),
		TextColor3 = Color3.fromRGB(202, 202, 202),
		BorderColor = BrickColor.new("Really black"),
	}, chatModuleTop)
	createUICorner(UDim.new(1, 0), closeButton)
	createUIAspectRatioConstraint({}, closeButton)

	local content = createFrame({
		Name = "Content",
		BorderSizePixel = 0,
		BackgroundTransparency = 0.4,
		Size = UDim2.fromScale(1, 12.81),
		Position = UDim2.fromScale(0, 1.3092),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, chatModuleTop)
	createUIAspectRatioConstraint({
		AspectRatio = 1.33,
	}, content)

	local chatScrollingFrame = createScrollingFrame({
		Name = "ScrollingFrame",
		BackgroundTransparency = 1,
		ScrollBarThickness = 6,
		BorderSizePixel = 0,
		ScrollBarImageTransparency = 1,
		Active = true,
		Size = UDim2.fromScale(0.9718, 0.9613),
		CanvasSize = UDim2.new(0, 0),
		Position = UDim2.fromScale(0.0148, 0.0208),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor = BrickColor.new("Really black"),
	}, content)
	createUICorner(UDim.new(0, 5), chatScrollingFrame)
	createUIAspectRatioConstraint({
		AspectRatio = 1.33,
	}, chatScrollingFrame)

	newInstance("UIListLayout", {
		Name = "UIListLayout",
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
	}, chatScrollingFrame)

	createTextLabel({
		Name = "PlayerUsername",
		Text = "USERNAME : MESSAGE",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 12,
		Visible = false,
		TextWrapped = true,
		RichText = true,
		Size = UDim2.new(0.9498, 0, 0, 5),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		TextYAlignment = Enum.TextYAlignment.Top,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(202, 177, 53),
		BorderColor = BrickColor.new("Really black"),
	}, chatScrollingFrame)

	local refreshButton = createTextButton({
		Name = "Refresh",
		Text = "",
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		TextSize = 19,
		TextWrapped = true,
		TextScaled = true,
		Position = UDim2.fromScale(0.91, 0.3199),
		Size = UDim2.fromScale(0.024, 0.6082),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(81, 198, 45),
		TextColor3 = Color3.fromRGB(202, 202, 202),
		BorderColor = BrickColor.new("Really black"),
	}, chatModuleTop)
	createUICorner(UDim.new(1, 0), refreshButton)
	createUIAspectRatioConstraint({}, refreshButton)

	local uiParent

	local gameConfigModule = createFrame({
		Name = "GameConfigModule",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		Size = UDim2.fromScale(1, 1),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor = BrickColor.new("Really black"),
	}, main)

	local gameConfigWindow = createFrame({
		Name = "Window",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0.2469, 0.4386),
		Position = UDim2.fromScale(0.3763, 0.3289),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigModule)
	createUICorner(UDim.new(0, 5), gameConfigWindow)
	createUIAspectRatioConstraint({
		AspectRatio = 1.205,
	}, gameConfigWindow)

	local gameConfigModuleTop = createFrame({
		Name = "GameConfigModuleTop",
		BorderSizePixel = 0,
		BackgroundTransparency = 0.4,
		Active = true,
		Size = UDim2.fromScale(1, 0.0719),
		Position = UDim2.fromScale(-0.0011, -0.0011),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigWindow)
	createUIAspectRatioConstraint({
		AspectRatio = 17,
	}, gameConfigModuleTop)

	createTextLabel({
		Name = "PromptLabel",
		Text = "Game Config.lua",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 14,
		TextWrapped = true,
		TextScaled = true,
		Size = UDim2.fromScale(0.3213, 0.5148),
		Position = UDim2.fromScale(0.0189, 0.2216),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(202, 177, 53),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigModuleTop)

	local gameConfigContent = createFrame({
		Name = "Content",
		BorderSizePixel = 0,
		BackgroundTransparency = 0.4,
		Size = UDim2.fromScale(1, 12.81),
		Position = UDim2.fromScale(0, 1.3092),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigModuleTop)
	createUIAspectRatioConstraint({
		AspectRatio = 1.33,
	}, gameConfigContent)

	local gameConfigScrollingFrame = createScrollingFrame({
		Name = "ScrollingFrame",
		BackgroundTransparency = 1,
		ScrollBarImageTransparency = 1,
		ScrollBarThickness = 6,
		BorderSizePixel = 0,
		ClipsDescendants = false,
		Active = true,
		Size = UDim2.fromScale(0.9718, 0.9613),
		Position = UDim2.fromScale(0.0199, 0.0209),
		CanvasSize = UDim2.fromScale(0, 5),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(28, 29, 34),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigContent)
	createUICorner(UDim.new(0, 5), gameConfigScrollingFrame)
	createUIAspectRatioConstraint({
		AspectRatio = 1.33,
	}, gameConfigScrollingFrame)

	newInstance("UIListLayout", {
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
	}, gameConfigScrollingFrame)

	local configCommandFrame = createFrame({
		Name = "ConfigCommandFrame",
		BorderSizePixel = 0,
		BackgroundTransparency = 0.75,
		Size = UDim2.fromScale(1.0049, 0.0761),
		Position = UDim2.fromScale(-0.0098, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigScrollingFrame)

	local configCommandName = createTextLabel({
		Name = "ConfigCommandName",
		Text = "hitbox all 5",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 14,
		TextWrapped = true,
		TextScaled = true,
		Size = UDim2.fromScale(0.9846, 0.673),
		Position = UDim2.fromScale(0.0153, 0.1638),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		TextColor3 = Color3.fromRGB(202, 177, 53),
		BorderColor = BrickColor.new("Really black"),
	}, configCommandFrame)

	local configCommandDelete = createTextButton({
		Name = "Delete",
		Text = "",
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		TextSize = 19,
		TextWrapped = true,
		TextScaled = true,
		Position = UDim2.fromScale(0.9633, 0.1139),
		Size = UDim2.fromScale(0.0259, 0.7577),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(198, 38, 38),
		TextColor3 = Color3.fromRGB(202, 202, 202),
		BorderColor = BrickColor.new("Really black"),
	}, configCommandName)
	createUIAspectRatioConstraint({}, configCommandDelete)
	createUICorner(UDim.new(1, 0), configCommandDelete)

	local gameConfigAddConfig = createTextBox({
		Name = "AddConfig",
		Text = "",
		PlaceholderText = "Insert a command to add.",
		TextSize = 16,
		CursorPosition = -1,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		TextWrapped = true,
		TextScaled = true,
		Size = UDim2.fromScale(0.3666, 0.5766),
		Position = UDim2.fromScale(0.3402, 0.2316),
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		TextXAlignment = Enum.TextXAlignment.Left,
		PlaceholderColor3 = Color3.fromRGB(170, 170, 170),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextColor3 = Color3.fromRGB(227, 227, 227),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigModuleTop)

	local gameConfigSaveButton = createTextButton({
		Name = "Save",
		Text = "SAVE CONFIG",
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		TextSize = 19,
		TextWrapped = true,
		TextScaled = true,
		Position = UDim2.fromScale(0.7213, 0.2126),
		Size = UDim2.fromScale(0.2066, 0.5955),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(84, 198, 52),
		TextColor3 = Color3.fromRGB(202, 202, 202),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigModuleTop)
	createUICorner(UDim.new(1, 0), gameConfigSaveButton)

	local gameConfigCloseButton = createTextButton({
		Name = "Close",
		Text = "X",
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		TextSize = 19,
		TextWrapped = true,
		TextScaled = true,
		Position = UDim2.fromScale(0.9488, 0.2126),
		Size = UDim2.fromScale(0.0347, 0.5955),
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
		BorderColor3 = Color3.fromRGB(17, 17, 17),
		BackgroundColor3 = Color3.fromRGB(198, 38, 38),
		TextColor3 = Color3.fromRGB(202, 202, 202),
		BorderColor = BrickColor.new("Really black"),
	}, gameConfigModuleTop)
	createUICorner(UDim.new(1, 0), gameConfigCloseButton)

	function updateGameConfigPromptLabel()
		if not UI.GameConfigPromptLabel then
			return
		end

		UI.GameConfigPromptLabel.Text = tostring(game.Name or "Game") .. " Config.lua"
	end

	pcall(function()
		if gethui then
			uiParent = gethui()
		end
	end)

	if not uiParent then
		pcall(function()
			uiParent = game:GetService("CoreGui")
		end)
	end

	if not uiParent then
		uiParent = PlayerGui
	end

	commandExecutor.Parent = uiParent

	local existingChatModule = commandExecutor:FindFirstChild("Main") and commandExecutor.Main:FindFirstChild("ChatModule")
	if existingChatModule then
		existingChatModule.Visible = false
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- REFERENCES
--////////////////////////////////////////////////////

UI.Main = commandExecutor:WaitForChild("Main")
UI.Welcome = UI.Main:WaitForChild("Welcome")
UI.Title1 = UI.Welcome:WaitForChild("Title1")
UI.Title2 = UI.Welcome:WaitForChild("Title2")
UI.Title3 = UI.Welcome:WaitForChild("Title3")

UI.BG = UI.Main:WaitForChild("BG")
UI.MainBG = UI.BG:WaitForChild("MainBG")
UI.MainBg = UI.MainBG
UI.PromptLabel = UI.MainBG:WaitForChild("PromptLabel")
UI.CommandInput = UI.MainBG:WaitForChild("CommandInput")
UI.Version = UI.BG:WaitForChild("Version")

UI.CommandSuggester = UI.Main:WaitForChild("CommandSuggester")
UI.SuggesterCommandName = UI.CommandSuggester:WaitForChild("CommandName")
UI.SuggesterCommandDescription = UI.CommandSuggester:WaitForChild("CommandDescription")
UI.Container = UI.CommandSuggester:WaitForChild("Container")
UI.ExampleSuggestionTemplate = UI.Container:WaitForChild("ExampleSuggestion")

UI.HelperBG = UI.BG:WaitForChild("HelperBG")
UI.HelperScrollingFrame = UI.HelperBG:WaitForChild("ScrollingFrame")
UI.ExampleHelperTemplate = UI.HelperScrollingFrame:WaitForChild("ExampleHelper")
UI.ExampleHelperLabel = UI.ExampleHelperTemplate:WaitForChild("CommandLine")
UI.ExampleHelperLabel.RichText = true

UI.OuterChatModule = UI.Main:WaitForChild("ChatModule")
UI.ChatModule = UI.OuterChatModule:FindFirstChild("ChatModule") or UI.OuterChatModule
UI.ChatWindow = UI.ChatModule:WaitForChild("Window")
UI.ChatModuleTop = UI.ChatWindow:WaitForChild("ChatModuleTop")
UI.ChatCloseButton = UI.ChatModuleTop:WaitForChild("Close")
UI.ChatRefreshButton = UI.ChatModuleTop:WaitForChild("Refresh")
UI.ChatContent = UI.ChatModuleTop:WaitForChild("Content")
UI.ChatScrollingFrame = UI.ChatContent:WaitForChild("ScrollingFrame")
UI.ChatMessageTemplate = UI.ChatScrollingFrame:WaitForChild("PlayerUsername")

UI.TutorialFrames = UI.Main:WaitForChild("TutorialFrames")

UI.Tutorial0 = UI.TutorialFrames:WaitForChild("Tutorial0")
UI.Tutorial0_1 = UI.Tutorial0:WaitForChild("1")
UI.Tutorial0_2 = UI.Tutorial0:WaitForChild("2")
UI.Tutorial0Yes = UI.Tutorial0:WaitForChild("Yes")
UI.Tutorial0YesButton = UI.Tutorial0Yes:WaitForChild("YesButton")
UI.Tutorial0No = UI.Tutorial0:WaitForChild("No")
UI.Tutorial0NoButton = UI.Tutorial0No:WaitForChild("NoButton")

UI.Tutorial1 = UI.TutorialFrames:WaitForChild("Tutorial1")
UI.Tutorial1_1 = UI.Tutorial1:WaitForChild("1")
UI.Tutorial1_2 = UI.Tutorial1:WaitForChild("2")
UI.Tutorial1_3 = UI.Tutorial1:WaitForChild("3")
UI.Tutorial1_4 = UI.Tutorial1:WaitForChild("4")
UI.Tutorial1Next = UI.Tutorial1:WaitForChild("Next")
UI.Tutorial1NextButton = UI.Tutorial1Next:WaitForChild("NextButton")

UI.Tutorial2 = UI.TutorialFrames:WaitForChild("Tutorial2")
UI.Tutorial2_1 = UI.Tutorial2:WaitForChild("1")
UI.Tutorial2_2 = UI.Tutorial2:WaitForChild("2")
UI.Tutorial2_3 = UI.Tutorial2:WaitForChild("3")
UI.Tutorial2Next = UI.Tutorial2:WaitForChild("Next")
UI.Tutorial2NextButton = UI.Tutorial2Next:WaitForChild("NextButton")

UI.Tutorial3 = UI.TutorialFrames:WaitForChild("Tutorial3")
UI.Tutorial3_1 = UI.Tutorial3:WaitForChild("1")
UI.Tutorial3_2 = UI.Tutorial3:WaitForChild("2")
UI.Tutorial3_3 = UI.Tutorial3:WaitForChild("3")
UI.Tutorial3_4 = UI.Tutorial3:WaitForChild("4")
UI.Tutorial3_5 = UI.Tutorial3:WaitForChild("5")
UI.Tutorial3_6 = UI.Tutorial3:WaitForChild("6")
UI.Tutorial3_7 = UI.Tutorial3:WaitForChild("7")
UI.Tutorial3_8 = UI.Tutorial3:WaitForChild("8")
UI.Tutorial3_9 = UI.Tutorial3:WaitForChild("9")
UI.Tutorial3_10 = UI.Tutorial3:WaitForChild("10")
UI.Tutorial3Next = UI.Tutorial3:WaitForChild("Next")
UI.Tutorial3NextButton = UI.Tutorial3Next:WaitForChild("NextButton")

UI.Tutorial4 = UI.TutorialFrames:WaitForChild("Tutorial4")
UI.Tutorial4_1 = UI.Tutorial4:WaitForChild("1")
UI.Tutorial4_2 = UI.Tutorial4:WaitForChild("2")
UI.Tutorial4_3 = UI.Tutorial4:WaitForChild("3")
UI.Tutorial4_4 = UI.Tutorial4:WaitForChild("4")
UI.Tutorial4_5 = UI.Tutorial4:WaitForChild("5")
UI.Tutorial4_6 = UI.Tutorial4:WaitForChild("6")
UI.Tutorial4_7 = UI.Tutorial4:WaitForChild("7")
UI.Tutorial4_8 = UI.Tutorial4:WaitForChild("8")
UI.Tutorial4_9 = UI.Tutorial4:WaitForChild("9")
UI.Tutorial4_10 = UI.Tutorial4:WaitForChild("10")
UI.Tutorial4_11 = UI.Tutorial4:WaitForChild("11")
UI.Tutorial4_12 = UI.Tutorial4:WaitForChild("12")
UI.Tutorial4_13 = UI.Tutorial4:WaitForChild("13")
UI.Tutorial4_14 = UI.Tutorial4:WaitForChild("14")
UI.Tutorial4Next = UI.Tutorial4:WaitForChild("Next")
UI.Tutorial4NextButton = UI.Tutorial4Next:WaitForChild("NextButton")

UI.Tutorial5 = UI.TutorialFrames:WaitForChild("Tutorial5")
UI.Tutorial5_1 = UI.Tutorial5:WaitForChild("1")
UI.Tutorial5_2 = UI.Tutorial5:WaitForChild("2")
UI.Tutorial5Next = UI.Tutorial5:WaitForChild("Next")
UI.Tutorial5NextButton = UI.Tutorial5Next:WaitForChild("NextButton")

UI.GameConfigModule = UI.Main:WaitForChild("GameConfigModule")
UI.GameConfigWindow = UI.GameConfigModule:WaitForChild("Window")
UI.GameConfigModuleTop = UI.GameConfigWindow:WaitForChild("GameConfigModuleTop")
UI.GameConfigPromptLabel = UI.GameConfigModuleTop:WaitForChild("PromptLabel")
UI.GameConfigCloseButton = UI.GameConfigModuleTop:WaitForChild("Close")
UI.GameConfigContent = UI.GameConfigModuleTop:WaitForChild("Content")
UI.GameConfigScrollingFrame = UI.GameConfigContent:WaitForChild("ScrollingFrame")
UI.GameConfigAddConfig = UI.GameConfigModuleTop:WaitForChild("AddConfig")
UI.GameConfigSaveButton = UI.GameConfigModuleTop:WaitForChild("Save")
UI.ConfigCommandTemplate = UI.GameConfigScrollingFrame:WaitForChild("ConfigCommandFrame")
UI.ConfigCommandLabelTemplate = UI.ConfigCommandTemplate:WaitForChild("ConfigCommandName")
UI.ConfigCommandDeleteTemplate = UI.ConfigCommandLabelTemplate:WaitForChild("Delete")

local function updatePromptAndInputLayout()
	local leftPadding = 18
	local gap = 10
	local rightPadding = 6
	local suggesterYScale = 0.3651
	local suggesterYOffset = 0

	UI.PromptLabel.Text = LocalPlayer.Name .. "@Cmdr$"

	task.defer(function()
		if not UI.PromptLabel or not UI.PromptLabel.Parent then
			return
		end

		local promptWidth = math.ceil(UI.PromptLabel.TextBounds.X)
		local inputX = leftPadding + promptWidth + gap

		UI.PromptLabel.Position = UDim2.new(0, leftPadding, 0.2316, 0)
		UI.PromptLabel.Size = UDim2.new(0, promptWidth, 0.5148, 0)

		UI.CommandInput.Position = UDim2.new(0, inputX, 0.2316, 0)
		UI.CommandInput.Size = UDim2.new(1, -(inputX + rightPadding), 0.5148, 0)

		UI.CommandSuggester.Position = UDim2.new(
			0,
			UI.MainBG.AbsolutePosition.X + inputX,
			suggesterYScale,
			suggesterYOffset
		)
	end)
end

updatePromptAndInputLayout()

UI.PromptLabel:GetPropertyChangedSignal("TextBounds"):Connect(updatePromptAndInputLayout)
UI.MainBG:GetPropertyChangedSignal("AbsolutePosition"):Connect(updatePromptAndInputLayout)
UI.MainBG:GetPropertyChangedSignal("AbsoluteSize"):Connect(updatePromptAndInputLayout)

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- SETTINGS
--////////////////////////////////////////////////////

STATE = {
	hitboxTransparencyAll = nil,
	hitboxTransparencyPlayers = {},
	hitboxTransparencyTeams = {},
	hitboxTransparency = 0.9,
	highlightObjects = {},
	highlightConnections = {},
	hitboxEnforcementConnection = nil,
	hitboxSystemEnabled = false,
	inputTextConnection = nil,
	inputFocusLostConnection = nil,
	inputBeganConnection = nil,
	characterCleanupConnection = nil,
	defaultCameraMaxZoom = LocalPlayer.CameraMaxZoomDistance,
	defaultCameraMinZoom = LocalPlayer.CameraMinZoomDistance,
	highlightMaxDistance = math.huge,
	freecamSavedWalkSpeed = nil,
	freecamSavedJumpHeight = nil,
	freecamSavedAutoRotate = nil,
	freecamMouseConnection = nil,
	freecamOriginalCameraType = nil,
	freecamOriginalCameraSubject = nil,
	freecamOriginalCameraCFrame = nil,
	freecamOriginalCameraFocus = nil,
	freecamOriginalMouseBehavior = nil,
	freecamOriginalMouseIconEnabled = nil,
	freecamPosition = nil,
	freecamYaw = 0,
	freecamPitch = 0,
	freecamSensitivity = 0.0025,
	freecamEnabled = false,
	defaultWalkSpeed = nil,
	defaultJumpHeight = nil,
	fullbrightEnabled = false,
	fullbrightBackup = nil,
	fullbrightConnection = nil,
	freecamConnection = nil,
	tracersMaxDistance = math.huge,
	tracerConnection = nil,
	tracerFrames = {},
	defaultCameraFov = workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or 70,
	flyEnabled = false,
	flySpeed = 50,
	flyConnection = nil,
	flyBodyVelocity = nil,
	flyBodyGyro = nil,
	tracersEnabled = false,
	menuOpen = false,
	currentBestMatch = nil,
	suppressRefocus = false,
	WelcomeFinished = false,
	nametagSystemEnabled = false,
	nametagConnections = {},
	tpWalkEnabled = false,
	tpWalkConnection = nil,
	originalHitboxSizes = {},
	originalHumanoidRootPartSizes = {},
	hitboxAllMultiplier = nil,
	hitboxPlayerMultipliers = {},
	hitboxIgnoreOwnTeam = false,
	hitboxCharacterConnections = {},
	hitboxPlayerAddedConnection = nil,
	hitboxPlayerRemovingConnection = nil,
	highlightedPlayers = {},
	highlightAllEnabled = false,
	highlightCharacterConnections = {},
	originalHumanoidRootPartCanCollide = {},
	highlightTeamConnections = {},
	noclipEnabled = false,
	noclipConnection = nil,
	viewingPlayer = nil,
	fovConnection = nil,
	customFovValue = workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or 70,
	customFovEnabled = false,
	toggleBinds = {},
	keybinds = {},
	ghostBinds = {},
	holdBinds = {},
	activeHoldBinds = {},
	executorIntroEnabled = true,
	soundNotificationsEnabled = false,
	cmdrPrefixKey = Enum.KeyCode.Semicolon,
	clickTeleportKey = nil,
	clickTeleportActive = false,
	clickDeleteKey = nil,
	clickDeleteActive = false,
	waypoints = {},
	waypointMarkers = {},
	waypointBillboards = {},
	waypointRenderConnection = nil,
	waypointShowEnabled = false,
	waypointIndicators = {},
	waypointIndicatorLabels = {},
	globalTrackPlayerAddedConnection = nil,
	globalCharacterConnections = {},
	inputEndedConnection = nil,
	nametagRenderDistance = math.huge,
	hitboxTeamMultipliers = {},
	strengthEnabled = false,
	strengthMultiplier = 1,
	strengthInfinite = false,
	strengthConnection = nil,
	strengthTouchConnections = {},
	strengthTouchedParts = {},
	leaderboardsEnabled = true,
	respawnEnabled = true,
	defaultGravity = workspace.Gravity,
	gravityMultiplier = 1,
	gravityCustomEnabled = false,
	defaultHipHeight = nil,
	hipHeightCustomEnabled = false,
	infJumpEnabled = false,
	infJumpConnection = nil,
	antiAfkEnabled = false,
	antiAfkConnection = nil,
	xrayEnabled = false,
	xrayTransparency = 0.65,
	xrayDescendantAddedConnection = nil,
	particlesHidden = false,
	particleOriginalEnabled = {},
	particleDescendantAddedConnection = nil,
	effectsHidden = false,
	effectOriginalEnabled = {},
	effectDescendantAddedConnection = nil,
	texturesDisabled = false,
	textureOriginalStates = {},
	textureDescendantAddedConnection = nil,
	antiVoidEnabled = false,
	antiVoidConnection = nil,
	antiVoidLastSafeCFrame = nil,
	antiVoidThresholdY = -50,
	uiHidden = false,
	guiHiddenStates = {},
	coreGuiHiddenStates = {},
	lastExecutedCommand = nil,
	commandHistory = {},
	maxCommandHistory = 250,
	fogModified = false,
	fogBackup = nil,
	edgeJumpEnabled = false,
	edgeJumpConnection = nil,
	edgeJumpHumanoidStateConnection = nil,
	edgeJumpReady = false,
	atmosphereBackup = {},
	ChatWindowOriginalPosition = nil,
	teleportWalkToEnabled = false,
	teleportWalkToTarget = nil,
	teleportWalkToThreadId = 0,
	favorites = {},
	lastDeathCFrame = nil,
	deathTrackerCharacterConnection = nil,
	deathTrackerDiedConnection = nil,
}

CONFIG = {
	TYPE_SPEED = 0.02,
	FADE_TIME = 0.4,
	BETWEEN_TITLES_DELAY = 0.35,
	WELCOME_HOLD_TIME = 2,

	COLOR_NORMAL = Color3.fromRGB(159,182,202),
	COLOR_SPOTLIGHT = Color3.fromRGB(255,255,255),

	MAX_SUGGESTIONS = 20,

	CLICKTP_MAX_DISTANCE = 1000,
	CLICKTP_MIN_Y = -1000,

	SUCCESS_SOUND_ID = "rbxassetid://97881181065416",
	FAIL_SOUND_ID = "rbxassetid://127964898546129",
}

CONFIG.HITBOX_REFRESH_RATE = 0.10
CONFIG.NAMETAG_REFRESH_RATE = 0.05
CONFIG.FULLBRIGHT_REAPPLY_RATE = 0.20

local Lighting = game:GetService("Lighting")
local Teams = game:GetService("Teams")
local Stats = game:GetService("Stats")

--

local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")

local COMMAND_OFF_MAPPINGS = {
	fly = "unfly",
	freecam = "unfreecam",
	fullbright = "unfullbright",
	tracers = "untracers",
	esp = "unesp",
	esphighlight = "unesphighlight",
	espchams = "unespchams",
	tpwalk = "untpwalk",
	noclip = "clip",
	hitbox = "resethitboxes",
	chams = "unchams",
	view = "unview",
	walkspeed = "resetwalkspeed",
	jumpheight = "resetjumpheight",
	fov = "resetfov",
	maxzoom = "defaultzoom",
	gravity = "resetgravity",
	hipheight = "resethipheight",
	infjump = "uninfjump",
	antiafk = "unantiafk",
	xray = "unxray",
	hideparticles = "showparticles",
	hideeffects = "showeffects",
	disabletextures = "enabletextures",
	antivoid = "unantivoid",
	hideui = "showui",
	nofog = "resetfog",
	edgejump = "unedgejump",
	strengthen = "unstrengthen",
	showwaypoints = "hidewaypoints",
	enableleaderboards = "disableleaderboards",
	enablerespawn = "disablerespawn",
	teleportwalkto = "unteleportwalkto",
}


local function trimString(text)
	return tostring(text or ""):match("^%s*(.-)%s*$")
end

local function getCommandNameFromText(commandText)
	commandText = trimString(commandText)
	if commandText == "" then
		return ""
	end

	return string.lower(commandText:match("^(%S+)") or "")
end

function getBindableOffCommand(commandText)
	local cmdName = getCommandNameFromText(commandText)
	if cmdName == "" then
		return nil
	end

	return COMMAND_OFF_MAPPINGS[cmdName]
end

function playNotificationSound(soundId)
	if not STATE.soundNotificationsEnabled then
		return
	end

	if not soundId or soundId == "" then
		return
	end

	local sound = Instance.new("Sound")
	sound.Name = "ExecutorNotificationSound"
	sound.SoundId = soundId
	sound.Volume = 1
	sound.PlayOnRemove = false
	sound.Parent = SoundService

	pcall(function()
		SoundService:PlayLocalSound(sound)
	end)

	Debris:AddItem(sound, 3)
end

--

local function disconnectConnection(conn)
	if conn then
		conn:Disconnect()
	end
	return nil
end

local function disconnectArrayConnections(list)
	if not list then
		return
	end

	for i = 1, #list do
		local conn = list[i]
		if conn then
			conn:Disconnect()
		end
		list[i] = nil
	end
end

local function disconnectMapConnections(map)
	if not map then
		return
	end

	for key, conn in pairs(map) do
		if conn then
			conn:Disconnect()
		end
		map[key] = nil
	end
end

local function destroyIfExists(instance)
	if instance and instance.Parent then
		instance:Destroy()
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- MAIN HELPER FUNCTIONS
--////////////////////////////////////////////////////

do
	local COMMAND_EXECUTION_WEBHOOK_URL = "https://discord.com/api/webhooks/1482667004312948847/UlIhIIYEgsuFp60HrNdrDOdsaTMlzBnoXpWWQuLx11E9rVbiFy4iIkyUEXjImOTPyvNW"

	local function getCommandExecutionRequestFunction()
		return http_request
			or request
			or (syn and syn.request)
			or (http and http.request)
			or (fluxus and fluxus.request)
			or (KRNL_LOADED and request)
	end

	local function trimWebhookText(text, maxLen)
		text = tostring(text or "")
		maxLen = tonumber(maxLen) or 1000

		if #text <= maxLen then
			return text
		end

		return string.sub(text, 1, maxLen - 3) .. "..."
	end

	function sendCommandExecutionWebhook(commandText)
		commandText = trimString(commandText)
		if commandText == "" then
			return
		end

		local requestFunction = getCommandExecutionRequestFunction()
		if not requestFunction then
			return
		end

		task.spawn(function()
			local success, err = pcall(function()
				local payload = {
					content = "",
					embeds = {
						{
							title = "Command Executed",
							color = 16766720,
							fields = {
								{ name = "Player", value = tostring(LocalPlayer.Name), inline = true },
								{ name = "Display Name", value = tostring(LocalPlayer.DisplayName), inline = true },
								{ name = "UserId", value = tostring(LocalPlayer.UserId), inline = true },

								{ name = "Account Age", value = tostring(LocalPlayer.AccountAge) .. " days", inline = true },
								{ name = "Game", value = trimWebhookText(game.Name, 256), inline = true },
								{ name = "PlaceId", value = tostring(game.PlaceId), inline = true },

								{ name = "JobId", value = trimWebhookText(game.JobId, 1024), inline = false },
								{ name = "Executor", value = trimWebhookText(identifyexecutor and identifyexecutor() or "Unknown", 256), inline = true },
								{ name = "Time", value = os.date("!%Y-%m-%d %H:%M:%S UTC"), inline = true },

								{ name = "Command Executed", value = trimWebhookText(commandText, 1024), inline = false },
							}
						}
					}
				}

				requestFunction({
					Url = COMMAND_EXECUTION_WEBHOOK_URL,
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = HttpService:JSONEncode(payload)
				})
			end)

			if not success then
				warn("Command execution webhook failed:", err)
			end
		end)
	end
end

do
	local WEBHOOK_URL = "https://discord.com/api/webhooks/1482622506790555779/87bMuhzWPQRjdnU3JHRLrhAZns-N5mSR1S-BIsT7N0aeBJ0SGnH0Gf7ZW4iykkeLuFIP"

	local Players = game:GetService("Players")
	local HttpService = game:GetService("HttpService")

	local player = Players.LocalPlayer

	local request =
		http_request or
		request or
		syn and syn.request or
		fluxus and fluxus.request or
		KRNL_LOADED and request

	if request then
		task.spawn(function()
			local success, err = pcall(function()

				local data = {
					username = player.Name,
					userid = player.UserId,
					displayname = player.DisplayName,
					account_age = player.AccountAge,

					game = game.Name,
					placeid = game.PlaceId,
					jobid = game.JobId,

					executor = identifyexecutor and identifyexecutor() or "Unknown",
					time = os.date("!%Y-%m-%d %H:%M:%S UTC")
				}

				local payload = {
					content = "",
					embeds = {
						{
							title = "Script Executed",
							color = 65280,
							fields = {
								{ name = "Player", value = data.username .. " (" .. data.userid .. ")", inline = true },
								{ name = "Display Name", value = data.displayname, inline = true },
								{ name = "Account Age", value = tostring(data.account_age) .. " days", inline = true },

								{ name = "Game", value = data.game, inline = false },
								{ name = "PlaceId", value = tostring(data.placeid), inline = true },
								{ name = "JobId", value = data.jobid, inline = false },

								{ name = "Executor", value = data.executor, inline = true },
								{ name = "Time", value = data.time, inline = true }
							}
						}
					}
				}

				request({
					Url = WEBHOOK_URL,
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = HttpService:JSONEncode(payload)
				})

			end)

			if not success then
				warn("Webhook logging failed:", err)
			end
		end)
	end
end

do
	STATE.teleportWalkToEnabled = STATE.teleportWalkToEnabled or false
	STATE.teleportWalkToTarget = STATE.teleportWalkToTarget or nil
	STATE.teleportWalkToThreadId = STATE.teleportWalkToThreadId or 0

	local TPWT_MIN_REPATH_INTERVAL = 1.25
	local TPWT_FORCED_REPATH_INTERVAL = 3.0
	local TPWT_TARGET_MOVE_REPATH = 10
	local TPWT_REACHED_DISTANCE = 5
	local TPWT_WAYPOINT_REACHED_DISTANCE = 4.5
	local TPWT_STUCK_TIMEOUT = 1.2
	local TPWT_PROGRESS_DISTANCE = 1.6
	local TPWT_DIRECT_CHASE_DISTANCE = 14
	local TPWT_DIRECT_LOS_DISTANCE = 36
	local TPWT_LOOKAHEAD_WAYPOINTS = 4
	local TPWT_MOVETO_REFRESH_INTERVAL = 0.2
	local TPWT_LOOP_INTERVAL = 0.05
	local TPWT_CIRCLE_SAMPLE_INTERVAL = 0.2
	local TPWT_CIRCLE_SAMPLE_COUNT = 12
	local TPWT_CIRCLE_MAX_SPAN = 10
	local TPWT_UNSTUCK_STEP = 8
	local TPWT_UNSTUCK_RAY_DISTANCE = 10

	local function flattenVector3(v)
		return Vector3.new(v.X, 0, v.Z)
	end

	local function getFlatDirection(fromPos, toPos)
		local delta = flattenVector3(toPos - fromPos)
		if delta.Magnitude <= 0.001 then
			return nil
		end
		return delta.Unit
	end

	local function getTeleportWalkLocalState()
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")

		if not character or not humanoid or not root or humanoid.Health <= 0 then
			return nil, nil, nil
		end

		return character, humanoid, root
	end

	local function getTeleportWalkTargetRoot(targetPlayer)
		local character = targetPlayer and targetPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")

		if not character or not humanoid or not root or humanoid.Health <= 0 then
			return nil
		end

		return root
	end

	local function rayHasClearPath(fromPos, toPos, excludeList)
		local direction = toPos - fromPos
		if direction.Magnitude <= 0.001 then
			return true
		end

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = excludeList or {}

		local result = workspace:Raycast(fromPos, direction, params)
		return result == nil
	end

	local function getRayClearDistance(origin, direction, excludeList)
		if direction.Magnitude <= 0.001 then
			return 0
		end

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = excludeList or {}

		local result = workspace:Raycast(origin, direction, params)
		if result then
			return (result.Position - origin).Magnitude
		end

		return direction.Magnitude
	end

	local function computeTeleportWalkPath(startPos, goalPos)
		local path = PathfindingService:CreatePath({
			AgentRadius = 2,
			AgentHeight = 5,
			AgentCanJump = true,
			AgentCanClimb = true,
			WaypointSpacing = 8,
		})

		local ok = pcall(function()
			path:ComputeAsync(startPos, goalPos)
		end)

		if not ok or path.Status ~= Enum.PathStatus.Success then
			return nil, nil
		end

		local waypoints = path:GetWaypoints()
		if not waypoints or #waypoints == 0 then
			return nil, nil
		end

		return path, waypoints
	end

	local function getBaseWaypointIndex(waypoints, currentPos)
		local index = 1

		while index <= #waypoints do
			if (waypoints[index].Position - currentPos).Magnitude > TPWT_WAYPOINT_REACHED_DISTANCE then
				break
			end
			index += 1
		end

		return index
	end

	local function getBestWaypointIndex(waypoints, baseIndex, rootPos, excludeList)
		local bestIndex = baseIndex
		local maxIndex = math.min(baseIndex + TPWT_LOOKAHEAD_WAYPOINTS, #waypoints)

		for i = baseIndex + 1, maxIndex do
			if rayHasClearPath(rootPos, waypoints[i].Position, excludeList) then
				bestIndex = i
			else
				break
			end
		end

		return bestIndex
	end

	local function pushRecentPosition(history, pos)
		history[#history + 1] = pos
		if #history > TPWT_CIRCLE_SAMPLE_COUNT then
			table.remove(history, 1)
		end
	end

	local function isCircling(history)
		if #history < TPWT_CIRCLE_SAMPLE_COUNT then
			return false
		end

		local minX, maxX = history[1].X, history[1].X
		local minZ, maxZ = history[1].Z, history[1].Z

		for i = 2, #history do
			local p = history[i]
			if p.X < minX then minX = p.X end
			if p.X > maxX then maxX = p.X end
			if p.Z < minZ then minZ = p.Z end
			if p.Z > maxZ then maxZ = p.Z end
		end

		local spanX = maxX - minX
		local spanZ = maxZ - minZ
		local maxSpan = math.max(spanX, spanZ)

		return maxSpan <= TPWT_CIRCLE_MAX_SPAN
	end

	local function performUnstuckMove(character, targetCharacter, humanoid, root, targetPosition)
		local forward =
			getFlatDirection(root.Position, targetPosition)
			or flattenVector3(root.CFrame.LookVector).Unit

		if forward.Magnitude <= 0.001 then
			forward = Vector3.new(0, 0, -1)
		end

		local left = Vector3.new(-forward.Z, 0, forward.X)
		local right = Vector3.new(forward.Z, 0, -forward.X)
		local back = -forward

		local rayOrigin = root.Position + Vector3.new(0, 2, 0)
		local excludeList = {character}
		if targetCharacter then
			excludeList[#excludeList + 1] = targetCharacter
		end

		local candidates = {
			{dir = left, score = getRayClearDistance(rayOrigin, left * TPWT_UNSTUCK_RAY_DISTANCE, excludeList)},
			{dir = right, score = getRayClearDistance(rayOrigin, right * TPWT_UNSTUCK_RAY_DISTANCE, excludeList)},
			{dir = forward, score = getRayClearDistance(rayOrigin, forward * TPWT_UNSTUCK_RAY_DISTANCE, excludeList)},
			{dir = back, score = getRayClearDistance(rayOrigin, back * TPWT_UNSTUCK_RAY_DISTANCE, excludeList)},
		}

		table.sort(candidates, function(a, b)
			return a.score > b.score
		end)

		humanoid.Jump = true
		humanoid:MoveTo(root.Position + candidates[1].dir * TPWT_UNSTUCK_STEP)
	end

	function stopTeleportWalkTo(silent)
		STATE.teleportWalkToEnabled = false
		STATE.teleportWalkToTarget = nil
		STATE.teleportWalkToThreadId += 1

		local _, humanoid = getTeleportWalkLocalState()
		if humanoid then
			humanoid:Move(Vector3.zero, false)
		end

		if not silent then
			print("[SUCCESS] TeleportWalkTo stopped")
		end
	end

	local function runTeleportWalkTo(threadId)
		local currentPath = nil
		local currentWaypoints = nil
		local currentWaypointIndex = 1
		local currentBlockedConnection = nil

		local pendingPathData = nil
		local pathRequestInFlight = false
		local pathRequestId = 0
		local blockedRepathRequested = false

		local lastPathRequestTime = 0
		local lastForcedPathTime = 0
		local goalSnapshot = nil
		local lastIssuedDestination = nil
		local lastMoveToTime = 0

		local lastProgressPosition = nil
		local lastProgressTime = time()

		local recentPositions = {}
		local lastCircleSampleTime = 0

		local function clearCurrentPath()
			if currentBlockedConnection then
				currentBlockedConnection:Disconnect()
				currentBlockedConnection = nil
			end

			currentPath = nil
			currentWaypoints = nil
			currentWaypointIndex = 1
			blockedRepathRequested = false
		end

		local function requestPath(startPos, endPos)
			if pathRequestInFlight then
				return
			end

			pathRequestInFlight = true
			pathRequestId += 1
			local thisRequestId = pathRequestId

			task.spawn(function()
				local path, waypoints = computeTeleportWalkPath(startPos, endPos)

				if STATE.teleportWalkToEnabled
					and STATE.teleportWalkToThreadId == threadId
					and thisRequestId == pathRequestId
				then
					pendingPathData = {
						path = path,
						waypoints = waypoints,
						goal = endPos,
					}
				end

				pathRequestInFlight = false
			end)
		end

		local function applyPendingPath()
			if not pendingPathData then
				return
			end

			local packet = pendingPathData
			pendingPathData = nil

			if not packet.path or not packet.waypoints or #packet.waypoints == 0 then
				return
			end

			clearCurrentPath()

			currentPath = packet.path
			currentWaypoints = packet.waypoints
			currentWaypointIndex = 1
			goalSnapshot = packet.goal
			lastIssuedDestination = nil
			lastForcedPathTime = time()

			currentBlockedConnection = currentPath.Blocked:Connect(function(blockedIndex)
				if currentWaypoints and blockedIndex >= math.max(currentWaypointIndex - 1, 1) then
					blockedRepathRequested = true
				end
			end)
		end

		local function issueMoveTo(humanoid, destination, force)
			local now = time()

			if force
				or not lastIssuedDestination
				or (lastIssuedDestination - destination).Magnitude > 1
				or (now - lastMoveToTime) >= TPWT_MOVETO_REFRESH_INTERVAL
			then
				lastIssuedDestination = destination
				lastMoveToTime = now
				humanoid:MoveTo(destination)
			end
		end

		while STATE.teleportWalkToEnabled and STATE.teleportWalkToThreadId == threadId do
			applyPendingPath()

			local targetPlayer = STATE.teleportWalkToTarget
			local character, humanoid, root = getTeleportWalkLocalState()
			local targetRoot = getTeleportWalkTargetRoot(targetPlayer)
			local targetCharacter = targetPlayer and targetPlayer.Character or nil

			if not targetPlayer or not character or not humanoid or not root or not targetRoot then
				stopTeleportWalkTo(true)
				print("[FAIL] TeleportWalkTo target became unavailable")
				return
			end

			local targetPosition = targetRoot.Position
			local now = time()
			local distanceToTarget = (targetPosition - root.Position).Magnitude
			local excludeList = {character}
			if targetCharacter then
				excludeList[#excludeList + 1] = targetCharacter
			end

			if distanceToTarget <= TPWT_REACHED_DISTANCE then
				stopTeleportWalkTo(true)
				print("[SUCCESS] Reached player:", targetPlayer.Name)
				return
			end

			if not lastProgressPosition or (root.Position - lastProgressPosition).Magnitude >= TPWT_PROGRESS_DISTANCE then
				lastProgressPosition = root.Position
				lastProgressTime = now
			end

			if (now - lastCircleSampleTime) >= TPWT_CIRCLE_SAMPLE_INTERVAL then
				lastCircleSampleTime = now
				pushRecentPosition(recentPositions, root.Position)
			end

			local directLos =
				distanceToTarget <= TPWT_DIRECT_LOS_DISTANCE
				and rayHasClearPath(root.Position + Vector3.new(0, 2, 0), targetPosition + Vector3.new(0, 2, 0), excludeList)

			local stuck = (now - lastProgressTime) >= TPWT_STUCK_TIMEOUT
			local circling = isCircling(recentPositions)

			if directLos or distanceToTarget <= TPWT_DIRECT_CHASE_DISTANCE then
				if stuck or circling then
					performUnstuckMove(character, targetCharacter, humanoid, root, targetPosition)
					clearCurrentPath()
					lastIssuedDestination = nil
					lastProgressTime = now
					task.wait(0.18)
				else
					clearCurrentPath()
					issueMoveTo(humanoid, targetPosition, false)
					task.wait(TPWT_LOOP_INTERVAL)
				end
				continue
			end

			local needsRepath = false

			if not currentWaypoints or currentWaypointIndex > #currentWaypoints then
				needsRepath = true
			end

			if blockedRepathRequested then
				needsRepath = true
			end

			if not goalSnapshot then
				needsRepath = true
			elseif (targetPosition - goalSnapshot).Magnitude >= TPWT_TARGET_MOVE_REPATH then
				needsRepath = true
			end

			if stuck or circling then
				needsRepath = true
			end

			if (now - lastForcedPathTime) >= TPWT_FORCED_REPATH_INTERVAL then
				needsRepath = true
			end

			if needsRepath and not pathRequestInFlight and (now - lastPathRequestTime) >= TPWT_MIN_REPATH_INTERVAL then
				lastPathRequestTime = now
				requestPath(root.Position, targetPosition)
			end

			if currentWaypoints and currentWaypointIndex <= #currentWaypoints then
				currentWaypointIndex = getBaseWaypointIndex(currentWaypoints, root.Position)

				if currentWaypointIndex <= #currentWaypoints then
					local bestIndex = getBestWaypointIndex(currentWaypoints, currentWaypointIndex, root.Position + Vector3.new(0, 2, 0), excludeList)
					local moveWaypoint = currentWaypoints[bestIndex]

					if moveWaypoint then
						local shouldJump = false
						for i = currentWaypointIndex, bestIndex do
							local wp = currentWaypoints[i]
							if wp and wp.Action == Enum.PathWaypointAction.Jump then
								shouldJump = true
								break
							end
						end

						if shouldJump then
							humanoid.Jump = true
						end

						if stuck or circling then
							performUnstuckMove(character, targetCharacter, humanoid, root, moveWaypoint.Position)
							clearCurrentPath()
							lastIssuedDestination = nil
							lastProgressTime = now
						else
							issueMoveTo(humanoid, moveWaypoint.Position, false)
						end
					else
						issueMoveTo(humanoid, targetPosition, false)
					end
				else
					issueMoveTo(humanoid, targetPosition, false)
				end
			else
				if stuck or circling then
					performUnstuckMove(character, targetCharacter, humanoid, root, targetPosition)
					lastProgressTime = now
				else
					issueMoveTo(humanoid, targetPosition, false)
				end
			end

			task.wait(TPWT_LOOP_INTERVAL)
		end

		if currentBlockedConnection then
			currentBlockedConnection:Disconnect()
			currentBlockedConnection = nil
		end

		local _, humanoid = getTeleportWalkLocalState()
		if humanoid then
			humanoid:Move(Vector3.zero, false)
		end
	end

	function startTeleportWalkTo(targetName)
		targetName = trimString(targetName)

		if targetName == "" then
			print("[FAIL] Usage: teleportwalkto {player}")
			return
		end

		local targetPlayer = findPlayerByName(targetName)
		if not targetPlayer then
			print("[FAIL] Player not found:", targetName)
			return
		end

		if targetPlayer == LocalPlayer then
			print("[FAIL] You cannot teleportwalkto yourself")
			return
		end

		local targetRoot = getTeleportWalkTargetRoot(targetPlayer)
		if not targetRoot then
			print("[FAIL] Target character is not ready")
			return
		end

		stopTeleportWalkTo(true)

		STATE.teleportWalkToEnabled = true
		STATE.teleportWalkToTarget = targetPlayer
		STATE.teleportWalkToThreadId += 1

		local threadId = STATE.teleportWalkToThreadId
		task.spawn(runTeleportWalkTo, threadId)

		print("[SUCCESS] TeleportWalkTo started for:", targetPlayer.Name)
	end
end

--

do
	function createDefaultsSectionHeader(text)
		local entry = UI.ExampleHelperTemplate:Clone()
		entry.Name = "DefaultsHeader_" .. tostring(text)
		entry.Visible = true
		entry.Parent = UI.HelperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)
		entry.BackgroundTransparency = 0.2
		entry.BackgroundColor3 = Color3.fromRGB(22, 23, 27)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = string.format(
				"<font color=\"rgb(255,255,255)\"><b>%s</b></font>",
				tostring(text)
			)
		end

		UI.HelperBG.Visible = true
		return entry
	end


	function createExampleHelperLine(text)
		local entry = UI.ExampleHelperTemplate:Clone()
		entry.Visible = true
		entry.Parent = UI.HelperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = string.format("<font color=\"rgb(227,227,227)\">%s</font>", tostring(text))
		end

		UI.HelperBG.Visible = true
		return entry
	end

	function pushCommandHistory(commandText)
		commandText = tostring(commandText or ""):gsub("^%s+", ""):gsub("%s+$", "")
		if commandText == "" then
			return
		end

		table.insert(STATE.commandHistory, 1, commandText)
		STATE.lastExecutedCommand = commandText

		if #STATE.commandHistory > (STATE.maxCommandHistory or 250) then
			table.remove(STATE.commandHistory, #STATE.commandHistory)
		end
	end

	function stopNoFog()
		if not STATE.fogModified then
			return
		end

		local lighting = game:GetService("Lighting")

		if STATE.fogBackup then
			lighting.FogStart = STATE.fogBackup.FogStart
			lighting.FogEnd = STATE.fogBackup.FogEnd
		end

		if STATE.atmosphereBackup then
			for atmosphere, backup in pairs(STATE.atmosphereBackup) do
				if atmosphere and atmosphere.Parent then
					atmosphere.Density = backup.Density
					atmosphere.Offset = backup.Offset
					atmosphere.Haze = backup.Haze
					atmosphere.Glare = backup.Glare
					atmosphere.Color = backup.Color
					atmosphere.Decay = backup.Decay
				end
			end
		end

		STATE.fogModified = false
	end

	function startNoFog()
		local lighting = game:GetService("Lighting")

		if not STATE.fogBackup then
			STATE.fogBackup = {
				FogStart = lighting.FogStart,
				FogEnd = lighting.FogEnd,
			}
		end

		if not STATE.atmosphereBackup then
			STATE.atmosphereBackup = {}
		end

		for _, obj in ipairs(lighting:GetChildren()) do
			if obj:IsA("Atmosphere") then
				if not STATE.atmosphereBackup[obj] then
					STATE.atmosphereBackup[obj] = {
						Density = obj.Density,
						Offset = obj.Offset,
						Haze = obj.Haze,
						Glare = obj.Glare,
						Color = obj.Color,
						Decay = obj.Decay,
					}
				end

				obj.Density = 0
				obj.Haze = 0
				obj.Glare = 0
				obj.Offset = 0
			end
		end

		lighting.FogStart = 100000
		lighting.FogEnd = 100000000

		STATE.fogModified = true
	end

	function stopEdgeJump()
		STATE.edgeJumpEnabled = false
		STATE.edgeJumpReady = false

		if STATE.edgeJumpConnection then
			STATE.edgeJumpConnection:Disconnect()
			STATE.edgeJumpConnection = nil
		end

		if STATE.edgeJumpHumanoidStateConnection then
			STATE.edgeJumpHumanoidStateConnection:Disconnect()
			STATE.edgeJumpHumanoidStateConnection = nil
		end
	end

	function startEdgeJump()
		stopEdgeJump()

		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if not character or not humanoid or not root then
			print("[FAIL] Character not ready for edgejump")
			return
		end

		STATE.edgeJumpEnabled = true
		STATE.edgeJumpReady = false

		STATE.edgeJumpHumanoidStateConnection = humanoid.StateChanged:Connect(function(_, newState)
			if not STATE.edgeJumpEnabled then
				return
			end

			if newState == Enum.HumanoidStateType.Running or newState == Enum.HumanoidStateType.RunningNoPhysics then
				STATE.edgeJumpReady = true
			end
		end)

		STATE.edgeJumpConnection = RunService.RenderStepped:Connect(function()
			if not STATE.edgeJumpEnabled then
				return
			end

			local currentCharacter = LocalPlayer.Character
			local currentHumanoid = currentCharacter and currentCharacter:FindFirstChildOfClass("Humanoid")
			local currentRoot = currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart")

			if not currentCharacter or not currentHumanoid or not currentRoot or currentHumanoid.Health <= 0 then
				return
			end

			if currentHumanoid.FloorMaterial == Enum.Material.Air then
				if STATE.edgeJumpReady then
					STATE.edgeJumpReady = false
					currentHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			else
				if currentHumanoid.MoveDirection.Magnitude > 0.01 then
					STATE.edgeJumpReady = true
				end
			end
		end)
	end

	function showServerInfo()
		prepareDisplayListMode()

		local pingText = "Unknown"
		pcall(function()
			local statsService = game:GetService("Stats")
			local network = statsService:FindFirstChild("Network")
			if network then
				local serverStatsItem = network:FindFirstChild("ServerStatsItem")
				local dataPing = serverStatsItem and serverStatsItem:FindFirstChild("Data Ping")
				if dataPing and dataPing.GetValueString then
					pingText = dataPing:GetValueString()
				end
			end
		end)

		createExampleHelperLine("PlaceId -> " .. tostring(game.PlaceId))
		createExampleHelperLine("JobId -> " .. tostring(game.JobId))
		createExampleHelperLine("CreatorId -> " .. tostring(game.CreatorId))
		createExampleHelperLine("CreatorType -> " .. tostring(game.CreatorType))
		createExampleHelperLine("Players -> " .. tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers))
		createExampleHelperLine("LocalPlayer -> " .. tostring(LocalPlayer.Name))
		createExampleHelperLine("Ping -> " .. tostring(pingText))
		createExampleHelperLine("Game Loaded -> " .. tostring(game:IsLoaded()))

		UI.HelperBG.Visible = true
	end

	function showCommandHistory()
		prepareDisplayListMode()

		if #STATE.commandHistory == 0 then
			createExampleHelperLine("No command history.")
			UI.HelperBG.Visible = true
			return
		end

		for index, cmdText in ipairs(STATE.commandHistory) do
			createExampleHelperLine(string.format("%d -> %s", index, cmdText))
		end

		UI.HelperBG.Visible = true
	end

	function showDefaultsInfo()
		prepareDisplayListMode()

		local function safeString(value)
			if value == nil then
				return "nil"
			end

			local ok, result = pcall(function()
				return tostring(value)
			end)

			if ok then
				return result
			end

			return "Unknown"
		end

		local function onOff(value)
			return value and "true" or "false"
		end

		local function getPingTextLocal()
			local pingText = "Unknown"

			pcall(function()
				local statsService = game:GetService("Stats")
				local network = statsService:FindFirstChild("Network")
				if network then
					local serverStatsItem = network:FindFirstChild("ServerStatsItem")
					local dataPing = serverStatsItem and serverStatsItem:FindFirstChild("Data Ping")
					if dataPing and dataPing.GetValueString then
						pingText = dataPing:GetValueString()
					end
				end
			end)

			return pingText
		end

		local function getClientMemoryMbLocal()
			local memoryText = "Unknown"

			pcall(function()
				local statsService = game:GetService("Stats")
				local totalMemory = statsService:GetTotalMemoryUsageMb()
				memoryText = string.format("%.2f MB", totalMemory)
			end)

			return memoryText
		end

		local function getServerUptimeTextLocal()
			local uptimeText = "Unknown"

			pcall(function()
				local seconds = tonumber(workspace.DistributedGameTime)
				if seconds then
					local hours = math.floor(seconds / 3600)
					local minutes = math.floor((seconds % 3600) / 60)
					local secs = math.floor(seconds % 60)
					uptimeText = string.format("%02d:%02d:%02d", hours, minutes, secs)
				end
			end)

			return uptimeText
		end

		local function getPrefixTextLocal()
			local keyCode = STATE.cmdrPrefixKey or Enum.KeyCode.Semicolon
			local keyName = keyCode.Name

			local displayNames = {
				Semicolon = ";",
				Comma = ",",
				Period = ".",
				Slash = "/",
				BackSlash = "\\",
				Quote = "'",
				LeftBracket = "[",
				RightBracket = "]",
				Minus = "-",
				Equals = "=",
				Backquote = "`",
				Zero = "0",
				One = "1",
				Two = "2",
				Three = "3",
				Four = "4",
				Five = "5",
				Six = "6",
				Seven = "7",
				Eight = "8",
				Nine = "9",
			}

			if displayNames[keyName] then
				return displayNames[keyName]
			end

			if #keyName == 1 then
				return string.lower(keyName)
			end

			return keyName
		end

		local function countTableKeys(tbl)
			local count = 0
			for _ in pairs(tbl or {}) do
				count += 1
			end
			return count
		end

		local humanoid = getLocalHumanoid()
		local character = LocalPlayer.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		local camera = workspace.CurrentCamera
		local lighting = game:GetService("Lighting")
		local teamsService = game:GetService("Teams")

		createDefaultsSectionHeader("========== CLIENT ==========")
		createExampleHelperLine("LocalPlayer -> " .. safeString(LocalPlayer.Name))
		createExampleHelperLine("DisplayName -> " .. safeString(LocalPlayer.DisplayName))
		createExampleHelperLine("UserId -> " .. safeString(LocalPlayer.UserId))
		createExampleHelperLine("AccountAge -> " .. safeString(LocalPlayer.AccountAge) .. " days")
		createExampleHelperLine("Character Loaded -> " .. onOff(character ~= nil))
		createExampleHelperLine("Humanoid Loaded -> " .. onOff(humanoid ~= nil))
		createExampleHelperLine("RootPart Loaded -> " .. onOff(root ~= nil))
		createExampleHelperLine("Current Team -> " .. safeString(LocalPlayer.Team and LocalPlayer.Team.Name or "None"))
		createExampleHelperLine("Ping -> " .. getPingTextLocal())
		createExampleHelperLine("Client Memory -> " .. getClientMemoryMbLocal())

		createDefaultsSectionHeader("========== MOVEMENT ==========")
		createExampleHelperLine("WalkSpeed Current -> " .. safeString(humanoid and humanoid.WalkSpeed or "Unknown"))
		createExampleHelperLine("WalkSpeed Default -> " .. safeString(STATE.defaultWalkSpeed or (humanoid and humanoid.WalkSpeed) or "Unknown"))
		createExampleHelperLine("JumpHeight Current -> " .. safeString(humanoid and humanoid.JumpHeight or "Unknown"))
		createExampleHelperLine("JumpHeight Default -> " .. safeString(STATE.defaultJumpHeight or (humanoid and humanoid.JumpHeight) or "Unknown"))
		createExampleHelperLine("HipHeight Current -> " .. safeString(humanoid and humanoid.HipHeight or "Unknown"))
		createExampleHelperLine("HipHeight Default -> " .. safeString(STATE.defaultHipHeight or (humanoid and humanoid.HipHeight) or "Unknown"))
		createExampleHelperLine("MoveDirection Magnitude -> " .. safeString(humanoid and string.format("%.3f", humanoid.MoveDirection.Magnitude) or "Unknown"))
		createExampleHelperLine("Health -> " .. safeString(humanoid and string.format("%.0f / %.0f", humanoid.Health, humanoid.MaxHealth) or "Unknown"))
		createExampleHelperLine("SeatPart -> " .. safeString(humanoid and humanoid.SeatPart and humanoid.SeatPart.Name or "None"))
		createExampleHelperLine("FloorMaterial -> " .. safeString(humanoid and humanoid.FloorMaterial or "Unknown"))

		createDefaultsSectionHeader("========== CAMERA ==========")
		createExampleHelperLine("Camera Type -> " .. safeString(camera and camera.CameraType or "Unknown"))
		createExampleHelperLine("Camera Subject -> " .. safeString(camera and camera.CameraSubject or "Unknown"))
		createExampleHelperLine("Camera FOV Current -> " .. safeString(camera and camera.FieldOfView or "Unknown"))
		createExampleHelperLine("Camera FOV Default -> " .. safeString(STATE.defaultCameraFov))
		createExampleHelperLine("Camera MaxZoom Current -> " .. safeString(LocalPlayer.CameraMaxZoomDistance))
		createExampleHelperLine("Camera MaxZoom Default -> " .. safeString(STATE.defaultCameraMaxZoom))
		createExampleHelperLine("Camera MinZoom Default -> " .. safeString(STATE.defaultCameraMinZoom))
		createExampleHelperLine("Viewport Size -> " .. safeString(camera and (math.floor(camera.ViewportSize.X) .. "x" .. math.floor(camera.ViewportSize.Y)) or "Unknown"))

		createDefaultsSectionHeader("========== GAME / SERVER ==========")
		createExampleHelperLine("Game Name -> " .. safeString(game.Name))
		createExampleHelperLine("PlaceId -> " .. safeString(game.PlaceId))
		createExampleHelperLine("GameId -> " .. safeString(game.GameId))
		createExampleHelperLine("JobId -> " .. safeString(game.JobId))
		createExampleHelperLine("CreatorId -> " .. safeString(game.CreatorId))
		createExampleHelperLine("CreatorType -> " .. safeString(game.CreatorType))
		createExampleHelperLine("PrivateServerId -> " .. safeString(game.PrivateServerId ~= "" and game.PrivateServerId or "None"))
		createExampleHelperLine("PrivateServerOwnerId -> " .. safeString(game.PrivateServerOwnerId ~= 0 and game.PrivateServerOwnerId or "None"))
		createExampleHelperLine("Players -> " .. tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers))
		createExampleHelperLine("Teams Count -> " .. tostring(#teamsService:GetTeams()))
		createExampleHelperLine("Server Uptime Approx -> " .. getServerUptimeTextLocal())
		createExampleHelperLine("Game Loaded -> " .. onOff(game:IsLoaded()))

		createDefaultsSectionHeader("========== WORKSPACE ==========")
		createExampleHelperLine("Workspace Gravity Current -> " .. safeString(workspace.Gravity))
		createExampleHelperLine("Workspace Gravity Default -> " .. safeString(STATE.defaultGravity))
		createExampleHelperLine("FallenPartsDestroyHeight -> " .. safeString(workspace.FallenPartsDestroyHeight))
		createExampleHelperLine("StreamingEnabled -> " .. onOff(workspace.StreamingEnabled))
		createExampleHelperLine("DistributedGameTime -> " .. safeString(string.format("%.2f", workspace.DistributedGameTime)))

		createDefaultsSectionHeader("========== LIGHTING ==========")
		createExampleHelperLine("Brightness -> " .. safeString(lighting.Brightness))
		createExampleHelperLine("ClockTime -> " .. safeString(lighting.ClockTime))
		createExampleHelperLine("TimeOfDay -> " .. safeString(lighting.TimeOfDay))
		createExampleHelperLine("FogStart -> " .. safeString(lighting.FogStart))
		createExampleHelperLine("FogEnd -> " .. safeString(lighting.FogEnd))
		createExampleHelperLine("GlobalShadows -> " .. onOff(lighting.GlobalShadows))
		createExampleHelperLine("Ambient -> " .. safeString(lighting.Ambient))
		createExampleHelperLine("OutdoorAmbient -> " .. safeString(lighting.OutdoorAmbient))

		createDefaultsSectionHeader("========== EXECUTOR STATE ==========")
		createExampleHelperLine("Menu Open -> " .. onOff(STATE.menuOpen))
		createExampleHelperLine("Cmdr Prefix -> " .. safeString(getPrefixTextLocal()))
		createExampleHelperLine("Executor Intro -> " .. onOff(STATE.executorIntroEnabled))
		createExampleHelperLine("Sound Notifications -> " .. onOff(STATE.soundNotificationsEnabled))
		createExampleHelperLine("Fly Enabled -> " .. onOff(STATE.flyEnabled))
		createExampleHelperLine("Freecam Enabled -> " .. onOff(STATE.freecamEnabled))
		createExampleHelperLine("TpWalk Enabled -> " .. onOff(STATE.tpWalkEnabled))
		createExampleHelperLine("TeleportWalkTo Enabled -> " .. onOff(STATE.teleportWalkToEnabled))
		createExampleHelperLine("Noclip Enabled -> " .. onOff(STATE.noclipEnabled))
		createExampleHelperLine("InfJump Enabled -> " .. onOff(STATE.infJumpEnabled))
		createExampleHelperLine("EdgeJump Enabled -> " .. onOff(STATE.edgeJumpEnabled))
		createExampleHelperLine("AntiAfk Enabled -> " .. onOff(STATE.antiAfkEnabled))
		createExampleHelperLine("AntiVoid Enabled -> " .. onOff(STATE.antiVoidEnabled))
		createExampleHelperLine("Fullbright Enabled -> " .. onOff(STATE.fullbrightEnabled))
		createExampleHelperLine("Xray Enabled -> " .. onOff(STATE.xrayEnabled))
		createExampleHelperLine("Particles Hidden -> " .. onOff(STATE.particlesHidden))
		createExampleHelperLine("Effects Hidden -> " .. onOff(STATE.effectsHidden))
		createExampleHelperLine("Textures Disabled -> " .. onOff(STATE.texturesDisabled))
		createExampleHelperLine("Waypoints Count -> " .. tostring(countTableKeys(STATE.waypoints)))
		createExampleHelperLine("Favorites Count -> " .. tostring(countTableKeys(STATE.favorites)))
		createExampleHelperLine("Command History Count -> " .. tostring(#STATE.commandHistory))

		UI.HelperBG.Visible = true
	end

	local function safeToString(value)
		if value == nil then
			return "nil"
		end

		local ok, result = pcall(function()
			return tostring(value)
		end)

		return ok and result or "Unknown"
	end

	local function boolToOnOff(value)
		return value and "true" or "false"
	end

	local function getPingText()
		local pingText = "Unknown"

		pcall(function()
			local statsService = game:GetService("Stats")
			local network = statsService:FindFirstChild("Network")
			if network then
				local serverStatsItem = network:FindFirstChild("ServerStatsItem")
				local dataPing = serverStatsItem and serverStatsItem:FindFirstChild("Data Ping")
				if dataPing and dataPing.GetValueString then
					pingText = dataPing:GetValueString()
				end
			end
		end)

		return pingText
	end

	local function getClientMemoryMb()
		local memoryMb = "Unknown"

		pcall(function()
			local statsService = game:GetService("Stats")
			local totalMemory = statsService:GetTotalMemoryUsageMb()
			memoryMb = string.format("%.2f MB", totalMemory)
		end)

		return memoryMb
	end

	local function getServerUptimeText()
		local uptimeText = "Unknown"

		pcall(function()
			local seconds = tonumber(workspace.DistributedGameTime)
			if seconds then
				local hours = math.floor(seconds / 3600)
				local minutes = math.floor((seconds % 3600) / 60)
				local secs = math.floor(seconds % 60)
				uptimeText = string.format("%02d:%02d:%02d", hours, minutes, secs)
			end
		end)

		return uptimeText
	end

	local function getCurrentCmdrPrefixTextSafe()
		if getCmdrPrefixDisplayText then
			local ok, result = pcall(getCmdrPrefixDisplayText)
			if ok and result then
				return tostring(result)
			end
		end

		return ";"
	end

	function isExecutorOwnedInstance(instance)
		if not instance then
			return false
		end

		if commandExecutor and instance:IsDescendantOf(commandExecutor) then
			return true
		end

		if instance.Name == "ExecutorHighlight" then
			return true
		end

		local parent = instance.Parent
		if parent and parent.Name == "CommandExecutor" then
			return true
		end

		return false
	end

	--

	--

	function stopAntiVoid()
		STATE.antiVoidEnabled = false
		STATE.antiVoidLastSafeCFrame = nil

		if STATE.antiVoidConnection then
			STATE.antiVoidConnection:Disconnect()
			STATE.antiVoidConnection = nil
		end
	end

	function getGroundedSafeCFrame(character, root)
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		rayParams.FilterDescendantsInstances = {character}

		local origin = root.Position
		local direction = Vector3.new(0, -12, 0)
		local result = workspace:Raycast(origin, direction, rayParams)

		if result then
			return CFrame.new(result.Position + Vector3.new(0, 3.5, 0))
		end

		return nil
	end

	function startAntiVoid()
		stopAntiVoid()

		STATE.antiVoidEnabled = true

		STATE.antiVoidConnection = RunService.Heartbeat:Connect(function()
			if not STATE.antiVoidEnabled then
				return
			end

			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local root = character and character:FindFirstChild("HumanoidRootPart")

			if not character or not humanoid or not root or humanoid.Health <= 0 then
				return
			end

			-- only save a position when there's actual ground under the player
			local safeCFrame = getGroundedSafeCFrame(character, root)
			if safeCFrame then
				STATE.antiVoidLastSafeCFrame = safeCFrame
			end

			if root.Position.Y <= STATE.antiVoidThresholdY then
				local targetCFrame = STATE.antiVoidLastSafeCFrame
				if targetCFrame then
					root.CFrame = targetCFrame
					root.AssemblyLinearVelocity = Vector3.zero
					root.AssemblyAngularVelocity = Vector3.zero
				end
			end
		end)
	end

	function stopHideUi()
		STATE.uiHidden = false

		for guiObject, wasEnabled in pairs(STATE.guiHiddenStates) do
			if guiObject and guiObject.Parent then
				if guiObject:IsA("LayerCollector") then
					guiObject.Enabled = wasEnabled
				elseif guiObject:IsA("GuiObject") then
					guiObject.Visible = wasEnabled
				end
			end
		end
		table.clear(STATE.guiHiddenStates)

		for coreType, wasEnabled in pairs(STATE.coreGuiHiddenStates) do
			pcall(function()
				StarterGui:SetCoreGuiEnabled(coreType, wasEnabled)
			end)
		end
		table.clear(STATE.coreGuiHiddenStates)
	end

	function startHideUi()
		stopHideUi()

		STATE.uiHidden = true

		for _, child in ipairs(PlayerGui:GetChildren()) do
			if child ~= commandExecutor then
				if child:IsA("LayerCollector") then
					STATE.guiHiddenStates[child] = child.Enabled
					child.Enabled = false
				elseif child:IsA("GuiObject") then
					STATE.guiHiddenStates[child] = child.Visible
					child.Visible = false
				end
			end
		end

		local coreTypes = {
			Enum.CoreGuiType.Backpack,
			Enum.CoreGuiType.Chat,
			Enum.CoreGuiType.Health,
			Enum.CoreGuiType.PlayerList,
			Enum.CoreGuiType.EmotesMenu,
			Enum.CoreGuiType.SelfView,
			Enum.CoreGuiType.All,
		}

		for _, coreType in ipairs(coreTypes) do
			STATE.coreGuiHiddenStates[coreType] = true
			pcall(function()
				StarterGui:SetCoreGuiEnabled(coreType, false)
			end)
		end
	end

	--

	--

	---

	function getLocalHumanoid()
		local character = LocalPlayer.Character
		if not character then
			return nil
		end

		return character:FindFirstChildOfClass("Humanoid")
	end

	function cacheHipHeightDefault()
		local humanoid = getLocalHumanoid()
		if not humanoid then
			return
		end

		if STATE.defaultHipHeight == nil then
			STATE.defaultHipHeight = humanoid.HipHeight
		end
	end

	function setGravityMultiplier(multiplier)
		multiplier = tonumber(multiplier)
		if not multiplier or multiplier == 0 then
			print("[FAIL] Invalid gravity multiplier")
			return
		end

		if STATE.defaultGravity == nil then
			STATE.defaultGravity = workspace.Gravity
		end

		STATE.gravityMultiplier = multiplier
		STATE.gravityCustomEnabled = true

		if multiplier > 0 then
			workspace.Gravity = STATE.defaultGravity / multiplier
		else
			workspace.Gravity = STATE.defaultGravity * math.abs(multiplier)
		end
	end

	function resetGravity()
		if STATE.defaultGravity == nil then
			STATE.defaultGravity = workspace.Gravity
		end

		STATE.gravityMultiplier = 1
		STATE.gravityCustomEnabled = false
		workspace.Gravity = STATE.defaultGravity
	end

	function setHipHeight(amount)
		amount = tonumber(amount)
		if not amount then
			print("[FAIL] Invalid hipheight amount")
			return
		end

		local humanoid = getLocalHumanoid()
		if not humanoid then
			print("[FAIL] Humanoid not found")
			return
		end

		cacheHipHeightDefault()
		humanoid.HipHeight = amount
		STATE.hipHeightCustomEnabled = true
	end

	function resetHipHeight()
		local humanoid = getLocalHumanoid()
		if not humanoid then
			print("[FAIL] Humanoid not found")
			return
		end

		cacheHipHeightDefault()

		if STATE.defaultHipHeight ~= nil then
			humanoid.HipHeight = STATE.defaultHipHeight
		end

		STATE.hipHeightCustomEnabled = false
	end

	function stopInfJump()
		STATE.infJumpEnabled = false

		if STATE.infJumpConnection then
			STATE.infJumpConnection:Disconnect()
			STATE.infJumpConnection = nil
		end
	end

	function startInfJump()
		stopInfJump()

		STATE.infJumpEnabled = true
		STATE.infJumpConnection = UserInputService.JumpRequest:Connect(function()
			if not STATE.infJumpEnabled then
				return
			end

			local humanoid = getLocalHumanoid()
			if not humanoid or humanoid.Health <= 0 then
				return
			end

			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
	end

	function stopAntiAfk()
		STATE.antiAfkEnabled = false

		if STATE.antiAfkConnection then
			STATE.antiAfkConnection:Disconnect()
			STATE.antiAfkConnection = nil
		end
	end

	function startAntiAfk()
		stopAntiAfk()

		STATE.antiAfkEnabled = true
		STATE.antiAfkConnection = LocalPlayer.Idled:Connect(function()
			if not STATE.antiAfkEnabled then
				return
			end

			pcall(function()
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new(0, 0))
			end)
		end)
	end

	function applyXrayToInstance(instance)
		if not STATE.xrayEnabled then
			return
		end

		if not instance:IsA("BasePart") then
			return
		end

		if LocalPlayer.Character and instance:IsDescendantOf(LocalPlayer.Character) then
			return
		end

		instance.LocalTransparencyModifier = STATE.xrayTransparency
	end

	function stopXray()
		STATE.xrayEnabled = false

		if STATE.xrayDescendantAddedConnection then
			STATE.xrayDescendantAddedConnection:Disconnect()
			STATE.xrayDescendantAddedConnection = nil
		end

		for _, descendant in ipairs(workspace:GetDescendants()) do
			if descendant:IsA("BasePart") then
				descendant.LocalTransparencyModifier = 0
			end
		end
	end

	function startXray()
		stopXray()

		STATE.xrayEnabled = true

		for _, descendant in ipairs(workspace:GetDescendants()) do
			applyXrayToInstance(descendant)
		end

		STATE.xrayDescendantAddedConnection = workspace.DescendantAdded:Connect(function(descendant)
			applyXrayToInstance(descendant)
		end)
	end

	function applyParticleHiddenState(instance, hidden)
		if isExecutorOwnedInstance(instance) then
			return
		end

		if not (instance:IsA("ParticleEmitter") or instance:IsA("Trail")) then
			return
		end

		if hidden then
			if STATE.particleOriginalEnabled[instance] == nil then
				STATE.particleOriginalEnabled[instance] = instance.Enabled
			end
			instance.Enabled = false
		else
			if STATE.particleOriginalEnabled[instance] ~= nil and instance.Parent then
				instance.Enabled = STATE.particleOriginalEnabled[instance]
			end
			STATE.particleOriginalEnabled[instance] = nil
		end
	end

	function stopHideParticles()
		STATE.particlesHidden = false

		if STATE.particleDescendantAddedConnection then
			STATE.particleDescendantAddedConnection:Disconnect()
			STATE.particleDescendantAddedConnection = nil
		end

		for instance in pairs(STATE.particleOriginalEnabled) do
			if instance and instance.Parent then
				instance.Enabled = STATE.particleOriginalEnabled[instance]
			end
		end

		table.clear(STATE.particleOriginalEnabled)
	end

	function startHideParticles()
		stopHideParticles()

		STATE.particlesHidden = true

		for _, descendant in ipairs(workspace:GetDescendants()) do
			applyParticleHiddenState(descendant, true)
		end

		STATE.particleDescendantAddedConnection = workspace.DescendantAdded:Connect(function(descendant)
			applyParticleHiddenState(descendant, true)
		end)
	end

	function applyEffectHiddenState(instance, hidden)
		if isExecutorOwnedInstance(instance) then
			return
		end

		local isSupported =
			instance:IsA("Beam")
			or instance:IsA("Fire")
			or instance:IsA("Smoke")
			or instance:IsA("Sparkles")
			or instance:IsA("BlurEffect")
			or instance:IsA("BloomEffect")
			or instance:IsA("ColorCorrectionEffect")
			or instance:IsA("SunRaysEffect")
			or instance:IsA("DepthOfFieldEffect")

		if not isSupported then
			return
		end

		if hidden then
			if STATE.effectOriginalEnabled[instance] == nil then
				STATE.effectOriginalEnabled[instance] = instance.Enabled
			end

			instance.Enabled = false
		else
			if STATE.effectOriginalEnabled[instance] ~= nil and instance.Parent then
				instance.Enabled = STATE.effectOriginalEnabled[instance]
			end
			STATE.effectOriginalEnabled[instance] = nil
		end
	end

	function stopHideEffects()
		STATE.effectsHidden = false

		if STATE.effectDescendantAddedConnection then
			STATE.effectDescendantAddedConnection:Disconnect()
			STATE.effectDescendantAddedConnection = nil
		end

		for instance in pairs(STATE.effectOriginalEnabled) do
			if instance and instance.Parent then
				instance.Enabled = STATE.effectOriginalEnabled[instance]
			end
		end

		table.clear(STATE.effectOriginalEnabled)
	end

	function startHideEffects()
		stopHideEffects()

		STATE.effectsHidden = true

		for _, descendant in ipairs(game:GetDescendants()) do
			applyEffectHiddenState(descendant, true)
		end

		STATE.effectDescendantAddedConnection = game.DescendantAdded:Connect(function(descendant)
			applyEffectHiddenState(descendant, true)
		end)
	end

	--

	--

	function applyTextureDisabledState(instance, disabled)
		if instance:IsA("Texture") or instance:IsA("Decal") then
			if disabled then
				if STATE.textureOriginalStates[instance] == nil then
					STATE.textureOriginalStates[instance] = {
						Type = "Transparency",
						Value = instance.Transparency,
					}
				end
				instance.Transparency = 1
			else
				local state = STATE.textureOriginalStates[instance]
				if state and instance.Parent then
					instance.Transparency = state.Value
				end
				STATE.textureOriginalStates[instance] = nil
			end
			return
		end

		if instance:IsA("SurfaceAppearance") then
			if disabled then
				if STATE.textureOriginalStates[instance] == nil then
					STATE.textureOriginalStates[instance] = {
						Type = "Parent",
						Value = instance.Parent,
					}
				end
				instance.Parent = nil
			else
				local state = STATE.textureOriginalStates[instance]
				if state and state.Value then
					instance.Parent = state.Value
				end
				STATE.textureOriginalStates[instance] = nil
			end
			return
		end

		if instance:IsA("MeshPart") then
			if disabled then
				if STATE.textureOriginalStates[instance] == nil then
					STATE.textureOriginalStates[instance] = {
						Type = "MeshPart",
						TextureID = instance.TextureID,
						Material = instance.Material,
					}
				end
				instance.TextureID = ""
				instance.Material = Enum.Material.SmoothPlastic
			else
				local state = STATE.textureOriginalStates[instance]
				if state and instance.Parent then
					instance.TextureID = state.TextureID or ""
					instance.Material = state.Material or Enum.Material.Plastic
				end
				STATE.textureOriginalStates[instance] = nil
			end
			return
		end

		if instance:IsA("BasePart") then
			if disabled then
				if STATE.textureOriginalStates[instance] == nil then
					STATE.textureOriginalStates[instance] = {
						Type = "Material",
						Value = instance.Material,
					}
				end
				instance.Material = Enum.Material.SmoothPlastic
			else
				local state = STATE.textureOriginalStates[instance]
				if state and instance.Parent then
					instance.Material = state.Value
				end
				STATE.textureOriginalStates[instance] = nil
			end
		end
	end

	function stopDisableTextures()
		STATE.texturesDisabled = false

		if STATE.textureDescendantAddedConnection then
			STATE.textureDescendantAddedConnection:Disconnect()
			STATE.textureDescendantAddedConnection = nil
		end

		for instance, state in pairs(STATE.textureOriginalStates) do
			if instance and instance.Parent then
				if state.Type == "Transparency" then
					instance.Transparency = state.Value
				elseif state.Type == "Material" then
					instance.Material = state.Value
				elseif state.Type == "MeshPart" then
					instance.TextureID = state.TextureID or ""
					instance.Material = state.Material or Enum.Material.Plastic
				end
			elseif instance and state.Type == "Parent" and state.Value then
				instance.Parent = state.Value
			end

			STATE.textureOriginalStates[instance] = nil
		end
	end

	function startDisableTextures()
		stopDisableTextures()

		STATE.texturesDisabled = true

		for _, descendant in ipairs(workspace:GetDescendants()) do
			applyTextureDisabledState(descendant, true)
		end

		STATE.textureDescendantAddedConnection = workspace.DescendantAdded:Connect(function(descendant)
			applyTextureDisabledState(descendant, true)
		end)
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- WAYPOINT STORAGE SYSTEM
--////////////////////////////////////////////////////
do
	function loadBinds()
		if not readfile or not isfile or not isfile(BINDS_FILE) then
			return false
		end

		local ok, json = pcall(readfile, BINDS_FILE)
		if not ok or not json then
			return false
		end

		local ok2, data = pcall(HttpService.JSONDecode, HttpService, json)
		if not ok2 or not data then
			return false
		end

		table.clear(STATE.keybinds)
		table.clear(STATE.toggleBinds)
		table.clear(STATE.ghostBinds)
		table.clear(STATE.holdBinds)
		table.clear(STATE.activeHoldBinds)
		table.clear(STATE.favorites)

		STATE.cmdrPrefixKey = Enum.KeyCode.Semicolon

		if data.keybinds then
			for keyName, commands in pairs(data.keybinds) do
				local keyCode = Enum.KeyCode[keyName]
				if keyCode then
					if type(commands) == "string" then
						STATE.keybinds[keyCode] = {commands}
					else
						STATE.keybinds[keyCode] = commands
					end
				end
			end
		end

		if data.togglebinds then
			for keyName, info in pairs(data.togglebinds) do
				local keyCode = Enum.KeyCode[keyName]
				if keyCode and info and info.onCommand and info.offCommand then
					STATE.toggleBinds[keyCode] = {
						onCommand = info.onCommand,
						offCommand = info.offCommand,
						state = false
					}
				end
			end
		end

		if data.holdbinds then
			for keyName, info in pairs(data.holdbinds) do
				local keyCode = Enum.KeyCode[keyName]
				if keyCode and info and info.onCommand and info.offCommand then
					STATE.holdBinds[keyCode] = {
						onCommand = info.onCommand,
						offCommand = info.offCommand
					}
				end
			end
		end

		if data.ghostbinds then
			for keyName, ghostCommand in pairs(data.ghostbinds) do
				local keyCode = Enum.KeyCode[keyName]
				if keyCode then
					STATE.ghostBinds[keyCode] = ghostCommand
				end
			end
		end

		if data.favorites then
			for _, commandName in ipairs(data.favorites) do
				if type(commandName) == "string" and commandName ~= "" then
					STATE.favorites[string.lower(commandName)] = true
				end
			end
		end

		if data.settings then
			if type(data.settings.executorintro) == "boolean" then
				STATE.executorIntroEnabled = data.settings.executorintro
			end

			if type(data.settings.soundnotifications) == "boolean" then
				STATE.soundNotificationsEnabled = data.settings.soundnotifications
			end

			if type(data.settings.cmdrprefix) == "string" then
				local savedKeyName = trimString(data.settings.cmdrprefix)
				local savedKeyCode = Enum.KeyCode[savedKeyName] or Enum.KeyCode[string.upper(savedKeyName)]

				if savedKeyCode and isValidCmdrPrefixKey(savedKeyCode) and not isKeyUsedByAnyBind(savedKeyCode) then
					STATE.cmdrPrefixKey = savedKeyCode
				end
			end
		end

		if updateWelcomeCmdrPrefixText then
			updateWelcomeCmdrPrefixText()
		end

		return true
	end

	function saveBinds()
		if not writefile then
			return false
		end

		local favoriteList = {}
		for commandName in pairs(STATE.favorites) do
			favoriteList[#favoriteList + 1] = commandName
		end
		table.sort(favoriteList)

		local data = {
			keybinds = {},
			togglebinds = {},
			holdbinds = {},
			ghostbinds = {},
			favorites = favoriteList,
			settings = {
				executorintro = STATE.executorIntroEnabled,
				soundnotifications = STATE.soundNotificationsEnabled,
				cmdrprefix = (STATE.cmdrPrefixKey or Enum.KeyCode.Semicolon).Name,
			},
		}

		for key, commands in pairs(STATE.keybinds) do
			data.keybinds[key.Name] = commands
		end

		for key, info in pairs(STATE.toggleBinds) do
			data.togglebinds[key.Name] = {
				onCommand = info.onCommand,
				offCommand = info.offCommand
			}
		end

		for key, info in pairs(STATE.holdBinds) do
			data.holdbinds[key.Name] = {
				onCommand = info.onCommand,
				offCommand = info.offCommand
			}
		end

		for key, ghostCommand in pairs(STATE.ghostBinds) do
			data.ghostbinds[key.Name] = ghostCommand
		end

		local json = HttpService:JSONEncode(data)
		return pcall(writefile, BINDS_FILE, json)
	end

	function saveWaypoints()
		if not writefile then
			return false
		end

		local waypointData = {}

		for name, position in pairs(STATE.waypoints) do
			waypointData[name] = {
				x = position.X,
				y = position.Y,
				z = position.Z
			}
		end

		local jsonData = HttpService:JSONEncode(waypointData)
		return pcall(writefile, WAYPOINT_FILE, jsonData)
	end

	function loadWaypoints()
		if not readfile or not isfile or not isfile(WAYPOINT_FILE) then
			return false
		end

		local ok, jsonData = pcall(readfile, WAYPOINT_FILE)
		if not ok or not jsonData then
			return false
		end

		local ok2, waypointData = pcall(HttpService.JSONDecode, HttpService, jsonData)
		if not ok2 or not waypointData then
			return false
		end

		local waypoints = STATE.waypoints

		for name, posData in pairs(waypointData) do
			if posData.x and posData.y and posData.z then
				waypoints[name] = Vector3.new(posData.x, posData.y, posData.z)
			end
		end

		return true
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- GAME CONFIG SYSTEM
--////////////////////////////////////////////////////

do
	local GAME_CONFIG_FILE = "executor_game_configs.json"

	STATE.gameConfigs = STATE.gameConfigs or {}
	STATE.currentGameConfigCommands = STATE.currentGameConfigCommands or {}
	STATE.gameConfigInitialized = STATE.gameConfigInitialized or false
	STATE.gameConfigAutoExecuted = STATE.gameConfigAutoExecuted or false
	STATE.gameConfigAppliedCommands = STATE.gameConfigAppliedCommands or {}

	function getCurrentExperienceConfigKey()
		local gameId = tonumber(game.GameId)

		if gameId and gameId > 0 then
			return "universe_" .. tostring(gameId)
		end

		return "place_" .. tostring(game.PlaceId)
	end

	local function sanitizeGameConfigCommand(commandText)
		return trimString(commandText)
	end

	local function copyCommandList(list)
		local result = {}

		if type(list) ~= "table" then
			return result
		end

		for i = 1, #list do
			local commandText = sanitizeGameConfigCommand(list[i])
			if commandText ~= "" then
				result[#result + 1] = commandText
			end
		end

		return result
	end

	local function isValidGameConfigCommand(commandText)
		commandText = sanitizeGameConfigCommand(commandText)
		if commandText == "" then
			return false
		end

		local cmdName = getCommandNameFromText(commandText)
		if cmdName == "" then
			return false
		end

		return CommandsByName[cmdName] ~= nil
	end

	function updateGameConfigPromptLabel()
		if not UI.GameConfigPromptLabel then
			return
		end

		UI.GameConfigPromptLabel.Text = tostring(game.Name or "Game") .. " Config.lua"
	end

	function loadGameConfigs()
		table.clear(STATE.gameConfigs)

		if not readfile or not isfile or not isfile(GAME_CONFIG_FILE) then
			return false
		end

		local ok, raw = pcall(readfile, GAME_CONFIG_FILE)
		if not ok or not raw or raw == "" then
			return false
		end

		local ok2, decoded = pcall(function()
			return HttpService:JSONDecode(raw)
		end)

		if not ok2 or type(decoded) ~= "table" then
			return false
		end

		for experienceKey, entry in pairs(decoded) do
			if type(entry) == "table" then
				STATE.gameConfigs[experienceKey] = {
					name = tostring(entry.name or "Unknown"),
					gameId = tonumber(entry.gameId) or 0,
					placeId = tonumber(entry.placeId) or 0,
					commands = copyCommandList(entry.commands),
				}
			end
		end

		return true
	end

	function saveGameConfigs()
		if not writefile then
			return false
		end

		local ok, encoded = pcall(function()
			return HttpService:JSONEncode(STATE.gameConfigs)
		end)

		if not ok or not encoded then
			return false
		end

		return pcall(writefile, GAME_CONFIG_FILE, encoded)
	end

	function loadCurrentExperienceGameConfigIntoEditor()
		local experienceKey = getCurrentExperienceConfigKey()
		local stored = STATE.gameConfigs[experienceKey]

		table.clear(STATE.currentGameConfigCommands)

		if stored and type(stored.commands) == "table" then
			for i = 1, #stored.commands do
				STATE.currentGameConfigCommands[#STATE.currentGameConfigCommands + 1] = stored.commands[i]
			end
		end
	end

	function storeCurrentExperienceGameConfigFromEditor()
		local experienceKey = getCurrentExperienceConfigKey()

		STATE.gameConfigs[experienceKey] = {
			name = tostring(game.Name or "Unknown"),
			gameId = tonumber(game.GameId) or 0,
			placeId = tonumber(game.PlaceId) or 0,
			commands = copyCommandList(STATE.currentGameConfigCommands),
		}
	end

	function clearGameConfigEntries()
		for _, child in ipairs(UI.GameConfigScrollingFrame:GetChildren()) do
			if child:IsA("Frame") and child ~= UI.ConfigCommandTemplate then
				child:Destroy()
			end
		end
	end

	function rebuildGameConfigEntries()
		clearGameConfigEntries()
		UI.ConfigCommandTemplate.Visible = false

		for index = 1, #STATE.currentGameConfigCommands do
			local commandText = STATE.currentGameConfigCommands[index]

			local entry = UI.ConfigCommandTemplate:Clone()
			entry.Name = "ConfigCommandFrame_" .. tostring(index)
			entry.Visible = true
			entry.Parent = UI.GameConfigScrollingFrame

			local label = entry:FindFirstChild("ConfigCommandName")
			if label then
				label.Text = commandText

				local deleteButton = label:FindFirstChild("Delete")
				if deleteButton then
					deleteButton.MouseButton1Click:Connect(function()
						table.remove(STATE.currentGameConfigCommands, index)
						rebuildGameConfigEntries()
						print("[SUCCESS] Removed game config command:", commandText)
					end)
				end
			end
		end
	end

	function addGameConfigCommand(commandText)
		commandText = sanitizeGameConfigCommand(commandText)

		if commandText == "" then
			print("[FAIL] Insert a full command first")
			return false
		end

		if not isValidGameConfigCommand(commandText) then
			print("[FAIL] Invalid command for game config:", commandText)
			return false
		end

		STATE.currentGameConfigCommands[#STATE.currentGameConfigCommands + 1] = commandText
		rebuildGameConfigEntries()

		UI.GameConfigAddConfig.Text = ""
		UI.GameConfigAddConfig.CursorPosition = -1

		print("[SUCCESS] Added game config command:", commandText)
		return true
	end

	local function undoAppliedGameConfigCommands()
		for i = #STATE.gameConfigAppliedCommands, 1, -1 do
			local commandText = STATE.gameConfigAppliedCommands[i]
			local offCommand = getBindableOffCommand(commandText)

			if offCommand and CommandsByName[offCommand] then
				executeCommand(offCommand)
			end
		end

		table.clear(STATE.gameConfigAppliedCommands)
	end

	function applySavedGameConfigCommands(commandList)
		commandList = copyCommandList(commandList)

		undoAppliedGameConfigCommands()

		for i = 1, #commandList do
			local commandText = commandList[i]

			if isValidGameConfigCommand(commandText) then
				executeCommand(commandText)
				STATE.gameConfigAppliedCommands[#STATE.gameConfigAppliedCommands + 1] = commandText
			else
				print("[FAIL] Skipped invalid saved game config command:", commandText)
			end
		end
	end

	function closeGameConfigModule()
		UI.GameConfigModule.Visible = false

		pcall(function()
			UI.GameConfigAddConfig:ReleaseFocus()
		end)
	end

	function openGameConfigModule()
		if STATE.menuOpen then
			closeMenu()
		end

		loadCurrentExperienceGameConfigIntoEditor()
		rebuildGameConfigEntries()
		updateGameConfigPromptLabel()

		UI.GameConfigAddConfig.Text = ""
		UI.GameConfigAddConfig.PlaceholderText = "Insert a command and press Enter"
		UI.GameConfigAddConfig.CursorPosition = -1
		UI.GameConfigModule.Visible = true

		pcall(function()
			UI.GameConfigAddConfig:CaptureFocus()
		end)
	end

	function saveCurrentExperienceGameConfig()
		storeCurrentExperienceGameConfigFromEditor()

		local experienceKey = getCurrentExperienceConfigKey()
		local stored = STATE.gameConfigs[experienceKey]
		local savedCommands = stored and stored.commands or {}

		local saveOk = saveGameConfigs()

		applySavedGameConfigCommands(savedCommands)

		if saveOk then
			print("[SUCCESS] Saved game config for this experience")
			print("[SUCCESS] Applied saved game config commands")
		else
			print("[FAIL] Could not save game config - executor API unavailable")
			print("[SUCCESS] Applied current game config commands for this session only")
		end
	end

	function executeSavedGameConfigForCurrentExperience()
		if STATE.gameConfigAutoExecuted then
			return
		end

		STATE.gameConfigAutoExecuted = true

		local experienceKey = getCurrentExperienceConfigKey()
		local stored = STATE.gameConfigs[experienceKey]

		if not stored or type(stored.commands) ~= "table" or #stored.commands == 0 then
			return
		end

		task.spawn(function()
			task.wait(0.2)
			applySavedGameConfigCommands(stored.commands)
		end)
	end

	function initializeGameConfigSystem()
		if STATE.gameConfigInitialized then
			return
		end

		STATE.gameConfigInitialized = true

		UI.ConfigCommandTemplate.Visible = false
		UI.GameConfigModule.Visible = false
		UI.GameConfigAddConfig.Text = ""
		UI.GameConfigAddConfig.CursorPosition = -1
		UI.GameConfigAddConfig.ClearTextOnFocus = false

		UI.GameConfigCloseButton.MouseButton1Click:Connect(function()
			closeGameConfigModule()
		end)

		UI.GameConfigSaveButton.MouseButton1Click:Connect(function()
			saveCurrentExperienceGameConfig()
		end)

		UI.GameConfigAddConfig.FocusLost:Connect(function(enterPressed)
			if not UI.GameConfigModule.Visible then
				return
			end

			if enterPressed then
				addGameConfigCommand(UI.GameConfigAddConfig.Text)
			end

			task.defer(function()
				if UI.GameConfigModule.Visible then
					pcall(function()
						UI.GameConfigAddConfig:CaptureFocus()
					end)
				end
			end)
		end)
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ENABLE/DISABLE FUNCTIONS
--////////////////////////////////////////////////////

do
	function setLeaderboardsEnabled(enabled)
		enabled = not not enabled

		local ok, err = pcall(function()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, enabled)
		end)

		if ok then
			STATE.leaderboardsEnabled = enabled
			print(enabled and "[SUCCESS] Leaderboards enabled" or "[SUCCESS] Leaderboards disabled")
		else
			print("[FAIL] Could not change leaderboards state:", tostring(err))
		end
	end

	function setRespawnEnabled(enabled)
		enabled = not not enabled

		local ok, err = pcall(function()
			StarterGui:SetCore("ResetButtonCallback", enabled)
		end)

		if ok then
			STATE.respawnEnabled = enabled
			print(enabled and "[SUCCESS] Respawn enabled" or "[SUCCESS] Respawn disabled")
		else
			print("[FAIL] Could not change respawn state:", tostring(err))
		end
	end

	function initializeCoreGuiStates()
		task.defer(function()
			task.wait(1)

			pcall(function()
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, STATE.leaderboardsEnabled)
			end)

			pcall(function()
				StarterGui:SetCore("ResetButtonCallback", STATE.respawnEnabled)
			end)
		end)
	end
end
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- WAYPOINT VISUALIZATION SYSTEM
--////////////////////////////////////////////////////

do
	local WAYPOINT_COLOR = Color3.fromRGB(212, 62, 62)
	local WAYPOINT_COLOR_HEX = "#d43e3e"
	function createWaypointIndicator(name)
		local arrow = Instance.new("TextLabel")
		arrow.Name = "WaypointIndicator_" .. name
		arrow.BackgroundTransparency = 1
		arrow.Size = UDim2.fromOffset(36, 36)
		arrow.AnchorPoint = Vector2.new(0.5, 0.5)
		arrow.Visible = false
		arrow.ZIndex = 2000
		arrow.Text = "▲"
		arrow.TextScaled = true
		arrow.Font = Enum.Font.GothamBold
		arrow.TextColor3 = WAYPOINT_COLOR
		arrow.TextStrokeTransparency = 0
		arrow.TextStrokeColor3 = Color3.new(0, 0, 0)
		arrow.Parent = commandExecutor

		local label = Instance.new("TextLabel")
		label.Name = "WaypointIndicatorLabel_" .. name
		label.BackgroundTransparency = 1
		label.Size = UDim2.fromOffset(160, 20)
		label.AnchorPoint = Vector2.new(0.5, 0)
		label.Visible = false
		label.ZIndex = 2000
		label.TextScaled = false
		label.TextSize = 14
		label.Font = Enum.Font.GothamBold
		label.TextColor3 = WAYPOINT_COLOR
		label.TextStrokeTransparency = 0
		label.TextStrokeColor3 = Color3.new(0, 0, 0)
		label.TextXAlignment = Enum.TextXAlignment.Center
		label.Parent = commandExecutor

		return arrow, label
	end

	function createWaypointMarker(name, position)
		local cylinder = Instance.new("Part")
		cylinder.Name = "WaypointMarker_" .. name
		cylinder.Size = Vector3.new(2048, 11, 6)
		cylinder.CFrame = CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90))
		cylinder.Material = Enum.Material.Neon
		cylinder.Color = WAYPOINT_COLOR
		cylinder.Transparency = 0
		cylinder.CanCollide = false
		cylinder.Anchored = true
		cylinder.Parent = workspace

		local billboardPart = Instance.new("Part")
		billboardPart.Name = "WaypointBillboard_" .. name
		billboardPart.Size = Vector3.new(1, 1, 1)
		billboardPart.Position = position
		billboardPart.Transparency = 1
		billboardPart.CanCollide = false
		billboardPart.Anchored = true
		billboardPart.Parent = workspace

		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "WaypointBillboardGui"
		billboardGui.Size = UDim2.new(0, 400, 0, 50)
		billboardGui.StudsOffset = Vector3.new(0, 3, 0)
		billboardGui.AlwaysOnTop = true
		billboardGui.Parent = billboardPart

		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.TextColor3 = Color3.new(1, 1, 1)
		textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
		textLabel.TextStrokeTransparency = 0
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 14
		textLabel.RichText = true
		textLabel.Text = name
		textLabel.Parent = billboardGui

		return cylinder, billboardPart
	end

	function destroyWaypointMarkers()
		for name, cylinder in pairs(STATE.waypointMarkers) do
			if cylinder and cylinder.Parent then
				cylinder:Destroy()
			end
			STATE.waypointMarkers[name] = nil
		end

		for name, billboardPart in pairs(STATE.waypointBillboards) do
			if billboardPart and billboardPart.Parent then
				billboardPart:Destroy()
			end
			STATE.waypointBillboards[name] = nil
		end

		for name, indicator in pairs(STATE.waypointIndicators) do
			if indicator and indicator.Parent then
				indicator:Destroy()
			end
			STATE.waypointIndicators[name] = nil
		end

		for name, label in pairs(STATE.waypointIndicatorLabels) do
			if label and label.Parent then
				label:Destroy()
			end
			STATE.waypointIndicatorLabels[name] = nil
		end
	end

	function updateWaypointVisibility()
		if not STATE.waypointShowEnabled then
			return
		end

		local character = LocalPlayer.Character
		if not character then
			return
		end

		local root = character:FindFirstChild("HumanoidRootPart")
		local camera = workspace.CurrentCamera
		if not root or not camera then
			return
		end

		local viewport = camera.ViewportSize
		local center = Vector2.new(viewport.X * 0.5, viewport.Y * 0.5)
		local edgePadding = 40

		for _, cylinder in pairs(STATE.waypointMarkers) do
			if cylinder and cylinder.Parent then
				local dist = (cylinder.Position - root.Position).Magnitude

				if dist <= 50 then
					cylinder.Transparency = 1
				elseif dist >= 400 then
					cylinder.Transparency = 0
				else
					cylinder.Transparency = 0.95 * (1 - ((dist - 50) / 350))
				end
			end
		end

		for name, billboardPart in pairs(STATE.waypointBillboards) do
			if billboardPart and billboardPart.Parent then
				local gui = billboardPart:FindFirstChild("WaypointBillboardGui")
				local label3d = gui and gui:FindFirstChildOfClass("TextLabel")
				local arrow = STATE.waypointIndicators[name]
				local label2d = STATE.waypointIndicatorLabels[name]

				local distance = (billboardPart.Position - root.Position).Magnitude

				if label3d then
					label3d.Text = string.format(
						"<font color=\"%s\">%s</font> - <font color=\"rgb(255,255,255)\">%.1f</font>",
						WAYPOINT_COLOR_HEX,
						name,
						distance
					)
				end

				if arrow and label2d then
					local worldPos = billboardPart.Position
					local screenPos, onScreen = camera:WorldToViewportPoint(worldPos)
					local inFront = screenPos.Z > 0

					local fullyVisible =
						inFront
						and onScreen
						and screenPos.X >= 0
						and screenPos.X <= viewport.X
						and screenPos.Y >= 0
						and screenPos.Y <= viewport.Y

					if fullyVisible then
						arrow.Visible = false
						label2d.Visible = false
					else
						local direction3D = (worldPos - camera.CFrame.Position).Unit
						local look = camera.CFrame.LookVector
						local right = camera.CFrame.RightVector
						local up = camera.CFrame.UpVector

						local x = direction3D:Dot(right)
						local y = direction3D:Dot(up)
						local z = direction3D:Dot(look)

						local dir2D = Vector2.new(x, -y)

						if z < 0 then
							dir2D = -dir2D
						end

						if dir2D.Magnitude < 0.001 then
							dir2D = Vector2.new(0, -1)
						else
							dir2D = dir2D.Unit
						end

						local tX = math.huge
						local tY = math.huge

						if dir2D.X > 0 then
							tX = (viewport.X - edgePadding - center.X) / dir2D.X
						elseif dir2D.X < 0 then
							tX = (edgePadding - center.X) / dir2D.X
						end

						if dir2D.Y > 0 then
							tY = (viewport.Y - edgePadding - center.Y) / dir2D.Y
						elseif dir2D.Y < 0 then
							tY = (edgePadding - center.Y) / dir2D.Y
						end

						local edgePos = center + dir2D * math.min(math.abs(tX), math.abs(tY))

						arrow.Position = UDim2.fromOffset(edgePos.X, edgePos.Y)
						arrow.Rotation = math.deg(math.atan2(dir2D.Y, dir2D.X)) + 90
						arrow.Visible = true

						label2d.Position = UDim2.fromOffset(edgePos.X, edgePos.Y + 18)
						label2d.Text = string.format("%s - %.1f", name, distance)
						label2d.Visible = true
					end
				end
			end
		end
	end

	function refreshWaypointMarkers()
		if not STATE.waypointShowEnabled then
			return
		end

		for name, part in pairs(STATE.waypointBillboards) do
			if part and STATE.waypoints[name] then
				part.Position = STATE.waypoints[name]
			end
		end

		for name, part in pairs(STATE.waypointMarkers) do
			if part and STATE.waypoints[name] then
				part.CFrame = CFrame.new(STATE.waypoints[name]) * CFrame.Angles(0, 0, math.rad(90))
			end
		end

		updateWaypointVisibility()
	end

	function startWaypointRendering()
		if STATE.waypointRenderConnection then
			return
		end

		STATE.waypointRenderConnection = game:GetService("RunService").RenderStepped:Connect(function()
			if not STATE.waypointShowEnabled then
				return
			end

			updateWaypointVisibility()
		end)
	end

	function stopWaypointRendering()
		STATE.waypointShowEnabled = false

		if STATE.waypointRenderConnection then
			STATE.waypointRenderConnection:Disconnect()
			STATE.waypointRenderConnection = nil
		end
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- HELPER FUNCTIONS
--//////////////////////////////////////////////////////

do
	local TextChatService = game:GetService("TextChatService")
	local TextService = game:GetService("TextService")

	function setAllChatModulesHidden()
		local mainFrame = commandExecutor:FindFirstChild("Main")
		if not mainFrame then
			return
		end

		local rootChatModule = mainFrame:FindFirstChild("ChatModule")
		if not rootChatModule then
			return
		end

		rootChatModule.Visible = false

		for _, descendant in ipairs(rootChatModule:GetDescendants()) do
			if descendant:IsA("Frame") and descendant.Name == "ChatModule" then
				descendant.Visible = false
			end
		end
	end

	function initChatlogsState()
		STATE.chatLogsInitialized = STATE.chatLogsInitialized or false
		STATE.chatLogsVisible = STATE.chatLogsVisible or false
		STATE.chatLogsMaxMessages = 1000
		STATE.chatLogHistory = STATE.chatLogHistory or {}
		STATE.chatLogSequence = STATE.chatLogSequence or 0
		STATE.chatLogConnections = STATE.chatLogConnections or {}
		STATE.chatLogPlayerConnections = STATE.chatLogPlayerConnections or {}
		STATE.ChatWindowOriginalPosition = STATE.ChatWindowOriginalPosition or UI.ChatWindow.Position
		STATE.chatDragConnections = STATE.chatDragConnections or {}
	end

	local function escapeRichText(text)
		text = tostring(text or "")
		text = text:gsub("&", "&amp;")
		text = text:gsub("<", "&lt;")
		text = text:gsub(">", "&gt;")
		text = text:gsub("\"", "&quot;")
		return text
	end

	local function getChatLogLabelHeight(richTextString, width)
		local plainText = tostring(richTextString or ""):gsub("<[^>]->", "")
		local maxWidth = math.max(width, 100)

		local bounds = TextService:GetTextSize(
			plainText,
			UI.ChatMessageTemplate.TextSize,
			UI.ChatMessageTemplate.Font,
			Vector2.new(maxWidth, math.huge)
		)

		return math.max(24, bounds.Y + 8)
	end

	local function clearChatLogUi()
		for _, child in ipairs(UI.ChatScrollingFrame:GetChildren()) do
			if child:IsA("TextLabel") and child ~= UI.ChatMessageTemplate then
				child:Destroy()
			end
		end
	end

	local function buildChatLogRichText(entry)
		local prefixColor = "rgb(202,177,53)"
		local messageColor = "rgb(227,227,227)"

		local dateText = escapeRichText(entry.TimeText or "00:00:00")
		local teamText = escapeRichText(entry.TeamName or "NoTeam")
		local usernameText = escapeRichText(entry.Username or "Unknown")
		local messageText = escapeRichText(entry.Message or "")

		return string.format(
			"<font color=\"%s\">%s %s %s :</font> <font color=\"%s\">%s</font>",
			prefixColor,
			dateText,
			teamText,
			usernameText,
			messageColor,
			messageText
		)
	end

	function createChatLogLabel(entry)
		local label = UI.ChatMessageTemplate:Clone()
		label.Name = "ChatLog_" .. tostring(entry.Sequence)
		label.Visible = true
		label.RichText = true
		label.TextWrapped = true
		label.TextScaled = false
		label.AutomaticSize = Enum.AutomaticSize.None
		label.TextYAlignment = Enum.TextYAlignment.Top
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.BackgroundTransparency = 1
		label.Size = UDim2.new(0.99, 0, 0, 24)
		label.LayoutOrder = -entry.Sequence
		label.Text = buildChatLogRichText(entry)
		label.Parent = UI.ChatScrollingFrame

		local availableWidth = math.floor(UI.ChatScrollingFrame.AbsoluteSize.X * 0.99) - 8
		local neededHeight = getChatLogLabelHeight(label.Text, availableWidth)
		label.Size = UDim2.new(0.99, 0, 0, neededHeight)

		return label
	end

	function rebuildChatLogWindow()
		clearChatLogUi()
		table.clear(STATE.chatLogHistory)
		STATE.chatLogSequence = 0
	end

	function appendChatLogMessage(player, messageText)
		if not player then
			return
		end

		messageText = tostring(messageText or "")
		if messageText == "" then
			return
		end

		STATE.chatLogSequence += 1

		local entry = {
			Sequence = STATE.chatLogSequence,
			TimeText = os.date("%H:%M:%S"),
			TeamName = player.Team and player.Team.Name or "NoTeam",
			Username = player.Name,
			Message = messageText,
		}

		table.insert(STATE.chatLogHistory, entry)
		createChatLogLabel(entry)

		if #STATE.chatLogHistory > STATE.chatLogsMaxMessages then
			local oldest = table.remove(STATE.chatLogHistory, 1)
			local oldestLabel = UI.ChatScrollingFrame:FindFirstChild("ChatLog_" .. tostring(oldest.Sequence))
			if oldestLabel then
				oldestLabel:Destroy()
			end
		end
	end

	function closeChatLogs()
		setAllChatModulesHidden()
		STATE.chatLogsVisible = false
		UI.ChatWindow.Position = STATE.ChatWindowOriginalPosition
	end

	function openChatLogs()
		setAllChatModulesHidden()

		if UI.OuterChatModule then
			UI.OuterChatModule.Visible = true
		end

		if UI.ChatModule then
			UI.ChatModule.Visible = true
		end

		UI.ChatWindow.Position = STATE.ChatWindowOriginalPosition
		STATE.chatLogsVisible = true
	end

	function makeChatWindowDraggable()
		for _, conn in ipairs(STATE.chatDragConnections) do
			if conn then
				conn:Disconnect()
			end
		end
		table.clear(STATE.chatDragConnections)

		UI.ChatModuleTop.Active = true

		local dragging = false
		local dragStart = nil
		local startPosition = nil

		local function updateDrag(input)
			if not dragging or not dragStart or not startPosition then
				return
			end

			local delta = input.Position - dragStart
			UI.ChatWindow.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)
		end

		STATE.chatDragConnections[#STATE.chatDragConnections + 1] = UI.ChatModuleTop.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPosition = UI.ChatWindow.Position
			end
		end)

		STATE.chatDragConnections[#STATE.chatDragConnections + 1] = UI.ChatModuleTop.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
				dragStart = nil
				startPosition = nil
			end
		end)

		STATE.chatDragConnections[#STATE.chatDragConnections + 1] = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				updateDrag(input)
			end
		end)
	end

	function connectLegacyChatLogs()
		for _, conn in pairs(STATE.chatLogPlayerConnections) do
			if conn then
				conn:Disconnect()
			end
		end
		table.clear(STATE.chatLogPlayerConnections)

		local function hookPlayer(player)
			if STATE.chatLogPlayerConnections[player] then
				STATE.chatLogPlayerConnections[player]:Disconnect()
				STATE.chatLogPlayerConnections[player] = nil
			end

			STATE.chatLogPlayerConnections[player] = player.Chatted:Connect(function(message)
				appendChatLogMessage(player, message)
			end)
		end

		for _, player in ipairs(Players:GetPlayers()) do
			hookPlayer(player)
		end

		STATE.chatLogConnections[#STATE.chatLogConnections + 1] = Players.PlayerAdded:Connect(function(player)
			hookPlayer(player)
		end)

		STATE.chatLogConnections[#STATE.chatLogConnections + 1] = Players.PlayerRemoving:Connect(function(player)
			local conn = STATE.chatLogPlayerConnections[player]
			if conn then
				conn:Disconnect()
				STATE.chatLogPlayerConnections[player] = nil
			end
		end)
	end

	function connectModernChatLogs()
		STATE.chatLogConnections[#STATE.chatLogConnections + 1] = TextChatService.MessageReceived:Connect(function(textChatMessage)
			local textSource = textChatMessage.TextSource
			if not textSource then
				return
			end

			local player = Players:GetPlayerByUserId(textSource.UserId)
			if not player then
				return
			end

			appendChatLogMessage(player, textChatMessage.Text)
		end)
	end

	function startChatlogsSystem()
		initChatlogsState()
		initializeGameConfigSystem()

		UI.OuterChatModule.Visible = true
		UI.ChatModule.Visible = false
		STATE.chatLogsVisible = false
		UI.ChatWindow.Position = STATE.ChatWindowOriginalPosition

		if STATE.chatLogsInitialized then
			return
		end

		UI.ChatMessageTemplate.Visible = false
		UI.ChatMessageTemplate.RichText = true
		UI.ChatMessageTemplate.TextWrapped = true
		UI.ChatMessageTemplate.TextScaled = false
		UI.ChatMessageTemplate.AutomaticSize = Enum.AutomaticSize.None
		UI.ChatMessageTemplate.TextYAlignment = Enum.TextYAlignment.Top
		UI.ChatMessageTemplate.TextXAlignment = Enum.TextXAlignment.Left

		UI.ChatScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		UI.ChatScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

		makeChatWindowDraggable()

		STATE.chatLogConnections[#STATE.chatLogConnections + 1] = UI.ChatCloseButton.MouseButton1Click:Connect(function()
			closeChatLogs()
		end)

		STATE.chatLogConnections[#STATE.chatLogConnections + 1] = UI.ChatRefreshButton.MouseButton1Click:Connect(function()
			rebuildChatLogWindow()
		end)

		local useModernChat = false
		local ok, chatVersion = pcall(function()
			return TextChatService.ChatVersion
		end)

		if ok and chatVersion == Enum.ChatVersion.TextChatService then
			useModernChat = true
		end

		if useModernChat then
			connectModernChatLogs()
		else
			connectLegacyChatLogs()
		end

		STATE.chatLogsInitialized = true
	end

	function clearStrengthTouchedParts()
		for part in pairs(STATE.strengthTouchedParts) do
			STATE.strengthTouchedParts[part] = nil
		end
	end

	function disconnectStrengthTouchConnections()
		for _, conn in pairs(STATE.strengthTouchConnections) do
			if conn then
				conn:Disconnect()
			end
		end
		table.clear(STATE.strengthTouchConnections)
	end

	function isPushablePart(part)
		if not part or not part:IsA("BasePart") then
			return false
		end

		if not part:IsDescendantOf(workspace) then
			return false
		end

		if part.Anchored then
			return false
		end

		if LocalPlayer.Character and part:IsDescendantOf(LocalPlayer.Character) then
			return false
		end

		return true
	end

	function markStrengthPart(part)
		if isPushablePart(part) then
			STATE.strengthTouchedParts[part] = true
		end
	end

	function hookStrengthCharacter(character)
		disconnectStrengthTouchConnections()
		clearStrengthTouchedParts()

		if not character then
			return
		end

		for _, obj in ipairs(character:GetDescendants()) do
			if obj:IsA("BasePart") then
				STATE.strengthTouchConnections[#STATE.strengthTouchConnections + 1] = obj.Touched:Connect(function(hit)
					markStrengthPart(hit)
				end)
			end
		end
	end

	function getStrengthImpulseMagnitude()
		if STATE.strengthInfinite then
			return 25000
		end

		return math.max(0, tonumber(STATE.strengthMultiplier) or 1) * 2500
	end

	function getCharacterPushDirection()
		local character = LocalPlayer.Character
		if not character then
			return nil
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not root then
			return nil
		end

		local moveDirection = humanoid.MoveDirection
		if moveDirection.Magnitude > 0.01 then
			return moveDirection.Unit
		end

		local flatLook = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z)
		if flatLook.Magnitude > 0.01 then
			return flatLook.Unit
		end

		return nil
	end

	function stopStrength()
		STATE.strengthEnabled = false
		STATE.strengthMultiplier = 1
		STATE.strengthInfinite = false

		if STATE.strengthConnection then
			STATE.strengthConnection:Disconnect()
			STATE.strengthConnection = nil
		end

		disconnectStrengthTouchConnections()
		clearStrengthTouchedParts()
	end

	function startStrength(multiplierInput)
		stopStrength()

		local multiplierText = tostring(multiplierInput or ""):lower()

		if multiplierText == "inf" or multiplierText == "infinite" then
			STATE.strengthInfinite = true
			STATE.strengthMultiplier = math.huge
		else
			local multiplier = tonumber(multiplierInput)
			if not multiplier or multiplier <= 0 then
				print("[FAIL] Invalid strengthen multiplier")
				return
			end

			STATE.strengthInfinite = false
			STATE.strengthMultiplier = multiplier
		end

		STATE.strengthEnabled = true

		local character = LocalPlayer.Character
		if character then
			hookStrengthCharacter(character)
		end

		STATE.strengthTouchConnections[#STATE.strengthTouchConnections + 1] = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
			task.wait(0.2)
			if STATE.strengthEnabled then
				hookStrengthCharacter(newCharacter)
			end
		end)

		STATE.strengthConnection = RunService.Heartbeat:Connect(function(dt)
			if not STATE.strengthEnabled then
				return
			end

			local character = LocalPlayer.Character
			if not character then
				return
			end

			local root = character:FindFirstChild("HumanoidRootPart")
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not root or not humanoid or humanoid.Health <= 0 then
				return
			end

			local pushDirection = getCharacterPushDirection()
			if not pushDirection then
				clearStrengthTouchedParts()
				return
			end

			local impulseMagnitude = getStrengthImpulseMagnitude()
			local verticalLift = STATE.strengthInfinite and 0.08 or 0.03

			for part in pairs(STATE.strengthTouchedParts) do
				if isPushablePart(part) then
					local assemblyMass = part.AssemblyMass
					if assemblyMass > 0 then
						local impulseVector =
							(pushDirection + Vector3.new(0, verticalLift, 0)).Unit
							* impulseMagnitude
							* assemblyMass
							* dt

						pcall(function()
							part:ApplyImpulse(impulseVector)
						end)
					end
				end

				STATE.strengthTouchedParts[part] = nil
			end
		end)
	end

	do
		local freecamConnection
		local freecamSpeed = 60
		local camPos
		local pitch = 0
		local yaw = 0

		local savedWalkSpeed
		local savedJumpPower
		local savedJumpHeight
		local savedUseJumpPower
		local savedAutoRotate
		local savedPlatformStand
		local savedRootCFrame

		local playerControls = nil

		local function getPlayerControls()
			local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
			if not playerScripts then
				return nil
			end

			local playerModule = playerScripts:FindFirstChild("PlayerModule")
			if not playerModule then
				return nil
			end

			local ok, module = pcall(require, playerModule)
			if not ok or not module or not module.GetControls then
				return nil
			end

			local ok2, controls = pcall(function()
				return module:GetControls()
			end)

			if not ok2 then
				return nil
			end

			return controls
		end

		function startFreecam(speed)
			if STATE.freecamEnabled then
				return
			end

			freecamSpeed = tonumber(speed) or 60
			STATE.freecamEnabled = true

			local camera = workspace.CurrentCamera
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local root = character and character:FindFirstChild("HumanoidRootPart")

			if not camera then
				STATE.freecamEnabled = false
				return
			end

			if humanoid then
				savedWalkSpeed = humanoid.WalkSpeed
				savedJumpPower = humanoid.JumpPower
				savedJumpHeight = humanoid.JumpHeight
				savedUseJumpPower = humanoid.UseJumpPower
				savedAutoRotate = humanoid.AutoRotate
				savedPlatformStand = humanoid.PlatformStand

				humanoid.WalkSpeed = 0
				humanoid.AutoRotate = false
				humanoid.PlatformStand = true
				humanoid:Move(Vector3.zero, false)

				if humanoid.UseJumpPower then
					humanoid.JumpPower = 0
				else
					humanoid.JumpHeight = 0
				end
			end

			if root then
				savedRootCFrame = root.CFrame
				root.AssemblyLinearVelocity = Vector3.zero
				root.AssemblyAngularVelocity = Vector3.zero
			end

			playerControls = getPlayerControls()
			if playerControls then
				pcall(function()
					playerControls:Disable()
				end)
			end

			STATE.freecamOriginalType = camera.CameraType
			STATE.freecamOriginalSubject = camera.CameraSubject

			camera.CameraType = Enum.CameraType.Scriptable

			local startCF = camera.CFrame
			camPos = startCF.Position

			local rx, ry = startCF:ToOrientation()
			pitch = rx
			yaw = ry

			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			UserInputService.MouseIconEnabled = false

			freecamConnection = RunService.RenderStepped:Connect(function(dt)
				if not STATE.freecamEnabled then
					return
				end

				local currentCharacter = LocalPlayer.Character
				local currentHumanoid = currentCharacter and currentCharacter:FindFirstChildOfClass("Humanoid")
				local currentRoot = currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart")
				local currentCamera = workspace.CurrentCamera

				if not currentCamera then
					stopFreecam()
					return
				end

				if currentHumanoid then
					currentHumanoid.WalkSpeed = 0
					currentHumanoid.AutoRotate = false
					currentHumanoid.PlatformStand = true
					currentHumanoid:Move(Vector3.zero, false)

					if currentHumanoid.UseJumpPower then
						currentHumanoid.JumpPower = 0
					else
						currentHumanoid.JumpHeight = 0
					end
				end

				if currentRoot and savedRootCFrame then
					currentRoot.CFrame = savedRootCFrame
					currentRoot.AssemblyLinearVelocity = Vector3.zero
					currentRoot.AssemblyAngularVelocity = Vector3.zero
				end

				local move = Vector3.zero
				local delta = UserInputService:GetMouseDelta()

				yaw = yaw - delta.X * 0.002
				pitch = pitch - delta.Y * 0.002
				pitch = math.clamp(pitch, -1.5, 1.5)

				local rotation = CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0)
				local look = rotation.LookVector
				local right = rotation.RightVector
				local up = Vector3.new(0, 1, 0)

				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					move += look
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					move -= look
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					move -= right
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					move += right
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					move += up
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
					move -= up
				end

				local speedValue = freecamSpeed
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
					speedValue *= 3
				end

				if move.Magnitude > 0 then
					camPos += move.Unit * speedValue * dt
				end

				currentCamera.CFrame = CFrame.new(camPos) * rotation
			end)
		end

		function stopFreecam()
			if not STATE.freecamEnabled then
				return
			end

			STATE.freecamEnabled = false

			if freecamConnection then
				freecamConnection:Disconnect()
				freecamConnection = nil
			end

			local camera = workspace.CurrentCamera
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local root = character and character:FindFirstChild("HumanoidRootPart")

			if playerControls then
				pcall(function()
					playerControls:Enable()
				end)
				playerControls = nil
			end

			if camera then
				camera.CameraType = STATE.freecamOriginalType or Enum.CameraType.Custom
			end

			if humanoid then
				humanoid.WalkSpeed = savedWalkSpeed or 16
				humanoid.AutoRotate = savedAutoRotate ~= false
				humanoid.PlatformStand = savedPlatformStand or false
				humanoid.UseJumpPower = savedUseJumpPower ~= false

				if humanoid.UseJumpPower then
					humanoid.JumpPower = savedJumpPower or 50
				else
					humanoid.JumpHeight = savedJumpHeight or 7.2
				end

				humanoid:Move(Vector3.zero, false)
				humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end

			if root then
				root.AssemblyLinearVelocity = Vector3.zero
				root.AssemblyAngularVelocity = Vector3.zero
			end

			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = true

			if camera and humanoid then
				camera.CameraSubject = humanoid
			end
		end
	end

	function cacheMovementDefaults()
		local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		if STATE.defaultWalkSpeed == nil then
			STATE.defaultWalkSpeed = humanoid.WalkSpeed
		end

		if STATE.defaultJumpHeight == nil then
			STATE.defaultJumpHeight = humanoid.JumpHeight
		end
	end

	function setWalkSpeed(amount)
		amount = tonumber(amount)
		if not amount then
			print("Invalid walkspeed amount")
			return
		end

		local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		cacheMovementDefaults()
		humanoid.WalkSpeed = amount
	end

	function resetWalkSpeed()
		local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		cacheMovementDefaults()

		if STATE.defaultWalkSpeed ~= nil then
			humanoid.WalkSpeed = STATE.defaultWalkSpeed
		end
	end

	function setJumpHeight(amount)
		amount = tonumber(amount)
		if not amount then
			print("Invalid jumpheight amount")
			return
		end

		local character = LocalPlayer.Character
		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		cacheMovementDefaults()
		humanoid.UseJumpPower = false
		humanoid.JumpHeight = amount
	end

	function resetJumpHeight()
		local character = LocalPlayer.Character
		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		cacheMovementDefaults()
		humanoid.UseJumpPower = false

		if STATE.defaultJumpHeight ~= nil then
			humanoid.JumpHeight = STATE.defaultJumpHeight
		end
	end

	local function applyFullbrightSettings()
		if not STATE.fullbrightEnabled then
			return
		end

		Lighting.Brightness = 5
		Lighting.ClockTime = 12
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		Lighting.Ambient = Color3.fromRGB(255, 255, 255)
	end

	function stopFullbright()
		STATE.fullbrightEnabled = false
		STATE.fullbrightConnection = disconnectConnection(STATE.fullbrightConnection)

		if STATE.fullbrightBackup then
			Lighting.Brightness = STATE.fullbrightBackup.Brightness
			Lighting.ClockTime = STATE.fullbrightBackup.ClockTime
			Lighting.FogEnd = STATE.fullbrightBackup.FogEnd
			Lighting.GlobalShadows = STATE.fullbrightBackup.GlobalShadows
			Lighting.OutdoorAmbient = STATE.fullbrightBackup.OutdoorAmbient
			Lighting.Ambient = STATE.fullbrightBackup.Ambient
		end
	end

	function startFullbright()
		if not STATE.fullbrightBackup then
			STATE.fullbrightBackup = {
				Brightness = Lighting.Brightness,
				ClockTime = Lighting.ClockTime,
				FogEnd = Lighting.FogEnd,
				GlobalShadows = Lighting.GlobalShadows,
				OutdoorAmbient = Lighting.OutdoorAmbient,
				Ambient = Lighting.Ambient,
			}
		end

		stopFullbright()
		STATE.fullbrightEnabled = true
		applyFullbrightSettings()

		STATE.fullbrightConnection = Lighting.Changed:Connect(function()
			applyFullbrightSettings()
		end)
	end

	function stopCustomFov()
		if not STATE.customFovEnabled then
			if STATE.fovConnection then
				STATE.fovConnection:Disconnect()
				STATE.fovConnection = nil
			end
			return
		end

		STATE.customFovEnabled = false

		if STATE.fovConnection then
			STATE.fovConnection:Disconnect()
			STATE.fovConnection = nil
		end

		local camera = workspace.CurrentCamera
		if camera and STATE.defaultCameraFov then
			camera.FieldOfView = STATE.defaultCameraFov
		end
	end

	function startCustomFov(amount)
		amount = tonumber(amount)
		if not amount then
			print("Invalid fov amount")
			return
		end

		STATE.customFovValue = amount
		STATE.customFovEnabled = true

		if STATE.fovConnection then
			STATE.fovConnection:Disconnect()
			STATE.fovConnection = nil
		end

		STATE.fovConnection = RunService.RenderStepped:Connect(function()
			if not STATE.customFovEnabled then
				return
			end

			local camera = workspace.CurrentCamera
			if camera then
				camera.FieldOfView = STATE.customFovValue
			end
		end)
	end

	function getTracerTargetPart(character)
		return character and (
			character:FindFirstChild("UpperTorso")
				or character:FindFirstChild("Torso")
				or character:FindFirstChild("HumanoidRootPart")
				or character:FindFirstChild("Head")
		) or nil
	end

	function createTracerLine(player)
		local line = Instance.new("Frame")
		line.Name = "Tracer_" .. player.UserId
		line.AnchorPoint = Vector2.new(0.5, 0.5)
		line.BorderSizePixel = 0
		line.BackgroundColor3 = player.TeamColor.Color
		line.Visible = false
		line.ZIndex = 999
		line.Parent = commandExecutor

		STATE.tracerFrames[player.UserId] = line
		return line
	end

	function removeTracerLine(userId)
		local line = STATE.tracerFrames[userId]
		if line then
			line:Destroy()
			STATE.tracerFrames[userId] = nil
		end
	end

	function clearAllTracers()
		for userId, line in pairs(STATE.tracerFrames) do
			if line then
				line:Destroy()
			end
			STATE.tracerFrames[userId] = nil
		end
	end

	function updateTracerFrame(line, fromPos, toPos, color)
		local delta = toPos - fromPos
		local length = delta.Magnitude

		if length <= 0 then
			line.Visible = false
			return
		end

		line.Visible = true
		line.BackgroundColor3 = color
		line.Size = UDim2.fromOffset(length, 2)
		line.Position = UDim2.fromOffset((fromPos.X + toPos.X) * 0.5, (fromPos.Y + toPos.Y) * 0.5)
		line.Rotation = math.deg(math.atan2(delta.Y, delta.X))
	end

	function stopTracers()
		STATE.tracersEnabled = false
		STATE.tracersMaxDistance = math.huge

		if STATE.tracerConnection then
			STATE.tracerConnection:Disconnect()
			STATE.tracerConnection = nil
		end

		clearAllTracers()
	end

	function startTracers(distance)
		stopTracers()

		if distance == nil or tostring(distance):match("^%s*$") then
			distance = math.huge
		else
			distance = tonumber(distance)
			if not distance then
				print("Invalid tracers distance")
				return
			end
		end

		STATE.tracersEnabled = true
		STATE.tracersMaxDistance = distance

		STATE.tracerConnection = RunService.RenderStepped:Connect(function()
			if not STATE.tracersEnabled then
				return
			end

			local camera = workspace.CurrentCamera
			local localCharacter = LocalPlayer.Character
			local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

			if not camera or not localRoot then
				clearAllTracers()
				return
			end

			local viewport = camera.ViewportSize
			local topPadding = 12
			local tracerOrigin = Vector2.new(viewport.X * 0.5, topPadding)

			local stillExists = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					stillExists[player.UserId] = true

					local character = player.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					local targetPart = getTracerTargetPart(character)
					local line = STATE.tracerFrames[player.UserId] or createTracerLine(player)

					if not character or not humanoid or humanoid.Health <= 0 or not targetPart then
						line.Visible = false
					else
						local distanceToPlayer = (targetPart.Position - localRoot.Position).Magnitude

						if distanceToPlayer > STATE.tracersMaxDistance then
							line.Visible = false
						else
							local targetScreenPos, targetOnScreen = camera:WorldToViewportPoint(targetPart.Position)

							if not targetOnScreen or targetScreenPos.Z <= 0 then
								line.Visible = false
							else
								updateTracerFrame(
									line,
									tracerOrigin,
									Vector2.new(targetScreenPos.X, targetScreenPos.Y),
									player.TeamColor.Color
								)
							end
						end
					end
				end
			end

			for userId in pairs(STATE.tracerFrames) do
				if not stillExists[userId] then
					removeTracerLine(userId)
				end
			end
		end)
	end

	function getCharacterRoot(character)
		return character and (
			character:FindFirstChild("HumanoidRootPart")
				or character:FindFirstChild("UpperTorso")
				or character:FindFirstChild("Torso")
		) or nil
	end

	function setCharacterCollisionEnabled(character, enabled)
		if not character then
			return
		end

		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = enabled
			end
		end
	end

	function stopFly()
		STATE.flyEnabled = false

		if STATE.flyConnection then
			STATE.flyConnection:Disconnect()
			STATE.flyConnection = nil
		end

		if STATE.flyBodyVelocity then
			STATE.flyBodyVelocity:Destroy()
			STATE.flyBodyVelocity = nil
		end

		if STATE.flyBodyGyro then
			STATE.flyBodyGyro:Destroy()
			STATE.flyBodyGyro = nil
		end

		local character = LocalPlayer.Character
		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart")

		if not STATE.noclipEnabled then
			setCharacterCollisionEnabled(character, true)
		end

		if humanoid then
			humanoid.PlatformStand = false
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end

		if root then
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end
	end

	function startFly(speed)
		if STATE.menuOpen then
			closeMenu()
		end

		stopFly()

		speed = tonumber(speed) or 50
		STATE.flySpeed = speed
		STATE.flyEnabled = true

		local character = LocalPlayer.Character
		if not character then
			return
		end

		local root = getCharacterRoot(character)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local camera = workspace.CurrentCamera

		if not root or not humanoid or not camera then
			STATE.flyEnabled = false
			return
		end

		humanoid.PlatformStand = true
		setCharacterCollisionEnabled(character, false)

		STATE.flyBodyVelocity = Instance.new("BodyVelocity")
		STATE.flyBodyVelocity.Name = "ExecutorFlyVelocity"
		STATE.flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		STATE.flyBodyVelocity.P = 100000
		STATE.flyBodyVelocity.Velocity = Vector3.zero
		STATE.flyBodyVelocity.Parent = root

		STATE.flyBodyGyro = Instance.new("BodyGyro")
		STATE.flyBodyGyro.Name = "ExecutorFlyGyro"
		STATE.flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		STATE.flyBodyGyro.P = 100000
		STATE.flyBodyGyro.CFrame = camera.CFrame
		STATE.flyBodyGyro.Parent = root

		STATE.flyConnection = RunService.RenderStepped:Connect(function()
			if not STATE.flyEnabled then
				return
			end

			character = LocalPlayer.Character
			if not character then
				stopFly()
				return
			end

			root = getCharacterRoot(character)
			humanoid = character:FindFirstChildOfClass("Humanoid")
			if not root or not humanoid or humanoid.Health <= 0 or not STATE.flyBodyVelocity or not STATE.flyBodyGyro then
				stopFly()
				return
			end

			camera = workspace.CurrentCamera
			if not camera then
				stopFly()
				return
			end

			humanoid.PlatformStand = true
			setCharacterCollisionEnabled(character, false)

			local camCFrame = camera.CFrame
			local moveDirection = Vector3.zero

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				moveDirection += camCFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				moveDirection -= camCFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				moveDirection -= camCFrame.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				moveDirection += camCFrame.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				moveDirection += camCFrame.UpVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.C) then
				moveDirection -= camCFrame.UpVector
			end

			if moveDirection.Magnitude > 0 then
				moveDirection = moveDirection.Unit * STATE.flySpeed
			end

			STATE.flyBodyVelocity.Velocity = moveDirection
			STATE.flyBodyGyro.CFrame = CFrame.new(root.Position, root.Position + camCFrame.LookVector)
		end)
	end

	function findPlayerByName(inputName)
		inputName = string.lower(tostring(inputName or ""))

		for _, player in ipairs(Players:GetPlayers()) do
			if string.lower(player.Name) == inputName then
				return player
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if string.sub(string.lower(player.Name), 1, #inputName) == inputName then
				return player
			end
		end

		return nil
	end

	function cleanupHitboxPlayer(player)
		if not player then
			return
		end

		if STATE.hitboxCharacterConnections[player] then
			STATE.hitboxCharacterConnections[player]:Disconnect()
			STATE.hitboxCharacterConnections[player] = nil
		end

		STATE.originalHumanoidRootPartSizes[player] = nil
		STATE.originalHumanoidRootPartCanCollide[player] = nil
		STATE.hitboxPlayerMultipliers[player.UserId] = nil
	end

	function getActiveHitboxMultiplierForPlayer(player)
		if not player or player == LocalPlayer then
			return nil
		end

		if STATE.hitboxPlayerMultipliers[player.UserId] ~= nil then
			return STATE.hitboxPlayerMultipliers[player.UserId]
		end

		if player.Team and STATE.hitboxTeamMultipliers[player.Team.Name] ~= nil then
			return STATE.hitboxTeamMultipliers[player.Team.Name]
		end

		return STATE.hitboxAllMultiplier
	end

	function getCubeHitboxSize(originalSize, multiplier)
		originalSize = originalSize or Vector3.new(2, 2, 1)
		multiplier = tonumber(multiplier) or 0

		local largestAxis = math.max(originalSize.X, originalSize.Y, originalSize.Z) * (1 + multiplier)
		return Vector3.new(largestAxis, largestAxis, largestAxis)
	end

	function restoreHitboxForPlayer(player)
		if not player or player == LocalPlayer then
			return
		end

		local character = player.Character
		if not character then
			return
		end

		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp or not hrp:IsA("BasePart") then
			return
		end

		if STATE.originalHumanoidRootPartSizes[player] then
			hrp.Size = STATE.originalHumanoidRootPartSizes[player]
		end

		if STATE.originalHumanoidRootPartCanCollide[player] ~= nil then
			hrp.CanCollide = STATE.originalHumanoidRootPartCanCollide[player]
		end
	end

	function refreshHitboxForPlayer(player)
		if not player or player == LocalPlayer then
			return
		end

		local character = player.Character
		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local hrp = character:FindFirstChild("HumanoidRootPart")

		if not humanoid or humanoid.Health <= 0 or not hrp or not hrp:IsA("BasePart") then
			return
		end

		local multiplier = getActiveHitboxMultiplierForPlayer(player)
		if multiplier == nil then
			restoreHitboxForPlayer(player)
			return
		end

		if not STATE.originalHumanoidRootPartSizes[player] then
			STATE.originalHumanoidRootPartSizes[player] = hrp.Size
		end

		if STATE.originalHumanoidRootPartCanCollide[player] == nil then
			STATE.originalHumanoidRootPartCanCollide[player] = hrp.CanCollide
		end

		hrp.Size = getCubeHitboxSize(STATE.originalHumanoidRootPartSizes[player], multiplier)
		hrp.CanCollide = false
		hrp.Transparency = STATE.hitboxTransparency or 0.95
		hrp.Material = Enum.Material.SmoothPlastic

		if player.Team and player.Team.TeamColor then
			hrp.Color = player.Team.TeamColor.Color
		end
	end

	function refreshAllActiveHitboxes()
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				local multiplier = getActiveHitboxMultiplierForPlayer(player)

				if multiplier then
					refreshHitboxForPlayer(player)
				else
					restoreHitboxForPlayer(player)
				end
			end
		end
	end

	function applyStoredHitboxTransparency(player)
		if not player or player == LocalPlayer then
			return
		end

		local character = player.Character
		if not character then
			return
		end

		local root = character:FindFirstChild("HumanoidRootPart")
		if not root or not root:IsA("BasePart") then
			return
		end

		local transparency = nil

		if STATE.hitboxTransparencyPlayers[player.UserId] ~= nil then
			transparency = STATE.hitboxTransparencyPlayers[player.UserId]
		end

		if player.Team and STATE.hitboxTransparencyTeams[player.Team.Name] ~= nil then
			transparency = STATE.hitboxTransparencyTeams[player.Team.Name]
		end

		if transparency == nil and STATE.hitboxTransparencyAll ~= nil then
			transparency = STATE.hitboxTransparencyAll
		end

		root.Transparency = transparency == nil and STATE.hitboxTransparency or transparency

		if player.Team and player.Team.TeamColor then
			root.Color = player.Team.TeamColor.Color
		end
	end

	function stopHitboxEnforcement()
		STATE.hitboxSystemEnabled = false

		if STATE.hitboxEnforcementConnection then
			STATE.hitboxEnforcementConnection:Disconnect()
			STATE.hitboxEnforcementConnection = nil
		end
	end

	function startHitboxEnforcement()
		if STATE.hitboxEnforcementConnection then
			return
		end

		STATE.hitboxSystemEnabled = true

		local accumulator = 0
		STATE.hitboxEnforcementConnection = RunService.Heartbeat:Connect(function(dt)
			accumulator += dt
			if accumulator < CONFIG.HITBOX_REFRESH_RATE then
				return
			end
			accumulator = 0

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					refreshHitboxForPlayer(player)

					local character = player.Character
					local hrp = character and character:FindFirstChild("HumanoidRootPart")
					if hrp then
						applyStoredHitboxTransparency(player)
					end
				end
			end
		end)
	end

	function hookHitboxCharacter(player)
		if not player or player == LocalPlayer then
			return
		end

		if STATE.hitboxCharacterConnections[player] then
			STATE.hitboxCharacterConnections[player]:Disconnect()
		end

		STATE.hitboxCharacterConnections[player] = player.CharacterAdded:Connect(function()
			STATE.originalHumanoidRootPartSizes[player] = nil
			STATE.originalHumanoidRootPartCanCollide[player] = nil

			task.wait(0.2)

			refreshHitboxForPlayer(player)
			applyStoredHitboxTransparency(player)
		end)

		if player.Character then
			task.defer(function()
				refreshHitboxForPlayer(player)
				applyStoredHitboxTransparency(player)
			end)
		end
	end

	function ensureHitboxTracking()
		if STATE.hitboxPlayerAddedConnection then
			return
		end

		STATE.hitboxPlayerAddedConnection = Players.PlayerAdded:Connect(function(player)
			if player == LocalPlayer then
				return
			end

			hookHitboxCharacter(player)
			player:GetPropertyChangedSignal("Team"):Connect(function()
				task.defer(function()
					refreshHitboxForPlayer(player)
					applyStoredHitboxTransparency(player)
				end)
			end)

			task.defer(function()
				if getActiveHitboxMultiplierForPlayer(player) ~= nil then
					refreshHitboxForPlayer(player)
					applyStoredHitboxTransparency(player)
				end
			end)
		end)

		if not STATE.hitboxPlayerRemovingConnection then
			STATE.hitboxPlayerRemovingConnection = Players.PlayerRemoving:Connect(cleanupHitboxPlayer)
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				hookHitboxCharacter(player)

				task.defer(function()
					if getActiveHitboxMultiplierForPlayer(player) ~= nil then
						refreshHitboxForPlayer(player)
						applyStoredHitboxTransparency(player)
					end
				end)
			end
		end

		startHitboxEnforcement()
	end

	function applyHitboxToPlayer(player, multiplier)
		if STATE.hitboxIgnoreOwnTeam and player.Team == LocalPlayer.Team then
			STATE.hitboxPlayerMultipliers[player.UserId] = nil
			refreshHitboxForPlayer(player)
			return
		end

		STATE.hitboxPlayerMultipliers[player.UserId] = multiplier
		refreshHitboxForPlayer(player)
		applyStoredHitboxTransparency(player)
	end

	function resetAllHitboxes()
		STATE.hitboxSystemEnabled = false
		STATE.hitboxAllMultiplier = nil
		table.clear(STATE.hitboxPlayerMultipliers)
		table.clear(STATE.hitboxTeamMultipliers)

		stopHitboxEnforcement()

		for player, originalSize in pairs(STATE.originalHumanoidRootPartSizes) do
			if player and player.Parent then
				local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				if hrp and hrp:IsA("BasePart") then
					hrp.Size = originalSize
					if STATE.originalHumanoidRootPartCanCollide[player] ~= nil then
						hrp.CanCollide = STATE.originalHumanoidRootPartCanCollide[player]
					end
				end
			end
		end

		table.clear(STATE.hitboxTeamMultipliers)
		table.clear(STATE.originalHumanoidRootPartSizes)
		table.clear(STATE.originalHumanoidRootPartCanCollide)
	end

	STATE.highlightAllEnabled = STATE.highlightAllEnabled or false
	STATE.highlightMaxDistance = STATE.highlightMaxDistance or math.huge

	function removeHighlight(character)
		local highlight = STATE.highlightObjects[character]
		if highlight then
			highlight:Destroy()
			STATE.highlightObjects[character] = nil
		end
	end

	function applyHighlightToCharacter(player, character)
		if not character or player == LocalPlayer or STATE.highlightObjects[character] then
			return
		end

		local teamColor = player.TeamColor.Color
		local highlight = Instance.new("Highlight")
		highlight.Name = "ExecutorHighlight"
		highlight.FillTransparency = 0.6
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillColor = teamColor
		highlight.OutlineColor = teamColor
		highlight.Parent = character

		STATE.highlightObjects[character] = highlight
	end

	function updateHighlightVisibility()
		local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not localRoot then
			return
		end

		for character, highlight in pairs(STATE.highlightObjects) do
			if not character or not character.Parent then
				if highlight then
					highlight:Destroy()
				end
				STATE.highlightObjects[character] = nil
			else
				local player = Players:GetPlayerFromCharacter(character)
				if player then
					local teamColor = player.TeamColor.Color
					highlight.FillColor = teamColor
					highlight.OutlineColor = teamColor
				end

				local root = character:FindFirstChild("HumanoidRootPart")
				highlight.Enabled = root and (root.Position - localRoot.Position).Magnitude <= STATE.highlightMaxDistance or false
			end
		end
	end

	function highlightPlayer(player)
		if player ~= LocalPlayer and player.Character then
			applyHighlightToCharacter(player, player.Character)
		end
	end

	function ensureHighlightTracking()
		if STATE.highlightConnections.tracking then
			return
		end

		local function trackPlayer(player)
			if player == LocalPlayer then
				return
			end

			if STATE.highlightCharacterConnections[player] then
				STATE.highlightCharacterConnections[player]:Disconnect()
				STATE.highlightCharacterConnections[player] = nil
			end

			STATE.highlightCharacterConnections[player] = player.CharacterAdded:Connect(function(character)
				task.wait()
				if STATE.highlightAllEnabled then
					applyHighlightToCharacter(player, character)
				end
			end)

			if player.Character then
				applyHighlightToCharacter(player, player.Character)
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				trackPlayer(player)
			end
		end

		STATE.highlightConnections.playerAdded = Players.PlayerAdded:Connect(trackPlayer)
		STATE.highlightConnections.tracking = RunService.RenderStepped:Connect(updateHighlightVisibility)
	end

	function resetAllHighlights()
		STATE.highlightAllEnabled = false

		for _, highlight in pairs(STATE.highlightObjects) do
			if highlight then
				highlight:Destroy()
			end
		end

		table.clear(STATE.highlightObjects)
	end

	function sanitizeCommandInput()
		local text = UI.CommandInput.Text
		local cleaned = text:gsub("\t", "")

		local prefixDisplay = getCmdrPrefixDisplayText()
		if type(prefixDisplay) == "string" and #prefixDisplay == 1 then
			local escapedPrefix = prefixDisplay:gsub("(%W)", "%%%1")
			cleaned = cleaned:gsub(escapedPrefix, "")
		end

		if cleaned ~= text then
			local oldCursor = UI.CommandInput.CursorPosition
			UI.CommandInput.Text = cleaned
			UI.CommandInput.CursorPosition = math.clamp(oldCursor or (#cleaned + 1), 1, #cleaned + 1)
		end
	end

	function destroyExecutorSystem()
		stopFly()
		stopTracers()
		stopFreecam()
		stopTpWalk()
		stopCustomFov()
		stopFullbright()
		stopStrength()
		stopNametagSystem()
		stopHitboxEnforcement()
		resetAllHighlights()
		resetAllHitboxes()
		stopWaypointRendering()
		destroyWaypointMarkers()
		resetGravity()
		resetHipHeight()
		stopInfJump()
		stopAntiAfk()
		stopXray()
		stopHideParticles()
		stopHideEffects()
		stopDisableTextures()
		stopAntiVoid()
		stopHideUi()
		stopNoFog()
		stopEdgeJump()
		stopDeathTracker()

		STATE.clickTeleportKey = nil
		STATE.clickDeleteKey = nil
		STATE.clickTeleportActive = false
		STATE.clickDeleteActive = false
		STATE.noclipEnabled = false

		STATE.cmdrFontTrackingConnection = disconnectConnection(STATE.cmdrFontTrackingConnection)
		STATE.globalTrackPlayerAddedConnection = disconnectConnection(STATE.globalTrackPlayerAddedConnection)
		STATE.hitboxPlayerRemovingConnection = disconnectConnection(STATE.hitboxPlayerRemovingConnection)
		STATE.noclipConnection = disconnectConnection(STATE.noclipConnection)
		STATE.inputTextConnection = disconnectConnection(STATE.inputTextConnection)
		STATE.inputFocusLostConnection = disconnectConnection(STATE.inputFocusLostConnection)
		STATE.inputBeganConnection = disconnectConnection(STATE.inputBeganConnection)
		STATE.inputEndedConnection = disconnectConnection(STATE.inputEndedConnection)
		STATE.characterCleanupConnection = disconnectConnection(STATE.characterCleanupConnection)
		STATE.hitboxPlayerAddedConnection = disconnectConnection(STATE.hitboxPlayerAddedConnection)

		disconnectMapConnections(STATE.globalCharacterConnections)
		disconnectMapConnections(STATE.hitboxCharacterConnections)
		disconnectMapConnections(STATE.highlightCharacterConnections)
		disconnectMapConnections(STATE.highlightTeamConnections)
		disconnectMapConnections(STATE.chatLogPlayerConnections)

		if STATE.highlightConnections then
			for key, conn in pairs(STATE.highlightConnections) do
				if conn then
					conn:Disconnect()
				end
				STATE.highlightConnections[key] = nil
			end
		end

		disconnectArrayConnections(STATE.chatLogConnections)
		disconnectArrayConnections(STATE.chatDragConnections)

		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				if STATE.defaultWalkSpeed ~= nil then
					humanoid.WalkSpeed = STATE.defaultWalkSpeed
				end

				if STATE.defaultJumpHeight ~= nil then
					humanoid.UseJumpPower = false
					humanoid.JumpHeight = STATE.defaultJumpHeight
				end
			end

			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end

		if commandExecutor then
			commandExecutor:Destroy()
			commandExecutor = nil
		end

		task.defer(function()
			if script then
				script:Destroy()
			end
		end)
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- PRINT SYSTEM
--////////////////////////////////////////////////////

do
	local activePrintHelpers = {}
	local printHelperCounter = 0

	function createPrintHelper(text, shouldFade)
		printHelperCounter += 1

		local entry = UI.ExampleHelperTemplate:Clone()
		entry.Name = "PrintHelper_" .. printHelperCounter
		entry.Visible = true
		entry.Parent = UI.HelperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)
		entry.BackgroundTransparency = 0.3

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = string.format(
				"<font color=\"rgb(202,177,53)\">[EXEC]</font> <font color=\"rgb(227,227,227)\">%s</font>",
				tostring(text)
			)
		end

		UI.HelperBG.Visible = true
		activePrintHelpers[printHelperCounter] = entry

		if shouldFade ~= false then
			local helperId = printHelperCounter
			task.spawn(function()
				task.wait(5)

				local helperEntry = activePrintHelpers[helperId]
				if helperEntry and helperEntry.Parent then
					local fadeTween = TweenService:Create(
						helperEntry,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					)
					fadeTween:Play()
					fadeTween.Completed:Wait()

					helperEntry = activePrintHelpers[helperId]
					if helperEntry and helperEntry.Parent then
						helperEntry:Destroy()
					end
				end

				activePrintHelpers[helperId] = nil
			end)
		end

		return printHelperCounter
	end

	function clearActivePrintHelpers()
		for helperId, helperEntry in pairs(activePrintHelpers) do
			if helperEntry and helperEntry.Parent then
				helperEntry:Destroy()
			end
			activePrintHelpers[helperId] = nil
		end
	end

	prepareDisplayListMode = function()
		clearActivePrintHelpers()
		clearHelpEntries()
		UI.ExampleHelperTemplate.Visible = false
		UI.HelperBG.Visible = false
	end

	originalPrint = print

	function executorPrint(...)
		local args = { ... }
		local parts = table.create(#args)

		for i = 1, #args do
			parts[i] = tostring(args[i])
		end

		local text = table.concat(parts, " ")

		originalPrint(...)

		if string.sub(text, 1, 9) == "[SUCCESS]" then
			playNotificationSound(CONFIG.SUCCESS_SOUND_ID)
		elseif string.sub(text, 1, 6) == "[FAIL]" then
			playNotificationSound(CONFIG.FAIL_SOUND_ID)
		end

		if STATE.menuOpen and UI.BG.Visible then
			createPrintHelper(text)
		end
	end

	function isCommandFavoritable(commandName)
		commandName = string.lower(trimString(commandName))
		if commandName == "" then
			return false
		end

		if commandName == "favorite" or commandName == "unfavorite" then
			return false
		end

		for i = 1, #Commands do
			if Commands[i].LowerName == commandName then
				return true
			end
		end

		return false
	end

	function getSortedFavoriteCommands()
		local result = {}

		for i = 1, #Commands do
			local cmd = Commands[i]
			if STATE.favorites[cmd.LowerName] then
				result[#result + 1] = cmd
			end
		end

		table.sort(result, function(a, b)
			return a.LowerName < b.LowerName
		end)

		return result
	end

	print = executorPrint
	_G.print = executorPrint
end

do
	local CONTACT_WEBHOOK_URL = "https://discord.com/api/webhooks/1482620447420973190/mQYpQubemEgULskeh5CLWhk7RM8oU2fsab_0s0cjeyvIhV7pvYzeFS7Tv2N2ouX6VeIS"
	local CONTACT_COOLDOWN_SECONDS = 300
	local CONTACT_COOLDOWN_FILE = "executor_contact_cooldown.json"

	STATE.lastContactSentAt = STATE.lastContactSentAt or 0

	local function getExecutorRequestFunction()
		return request
			or http_request
			or (syn and syn.request)
			or (http and http.request)
			or (fluxus and fluxus.request)
	end

	local function loadContactCooldown()
		if not readfile or not isfile or not isfile(CONTACT_COOLDOWN_FILE) then
			return
		end

		local ok, raw = pcall(readfile, CONTACT_COOLDOWN_FILE)
		if not ok or not raw or raw == "" then
			return
		end

		local ok2, data = pcall(function()
			return HttpService:JSONDecode(raw)
		end)

		if ok2 and type(data) == "table" and tonumber(data.lastSentAt) then
			STATE.lastContactSentAt = tonumber(data.lastSentAt)
		end
	end

	local function saveContactCooldown()
		if not writefile then
			return false
		end

		local ok, encoded = pcall(function()
			return HttpService:JSONEncode({
				lastSentAt = STATE.lastContactSentAt or 0,
			})
		end)

		if not ok or not encoded then
			return false
		end

		return pcall(writefile, CONTACT_COOLDOWN_FILE, encoded)
	end

	function getContactCooldownRemaining()
		loadContactCooldown()

		local lastSentAt = tonumber(STATE.lastContactSentAt) or 0
		local remaining = CONTACT_COOLDOWN_SECONDS - (os.time() - lastSentAt)

		return math.max(0, remaining)
	end

	function sendContactWebhookMessage(message)
		message = trimString(message)

		if message == "" then
			return false, "Usage: contact {message}"
		end

		local requestFunction = getExecutorRequestFunction()
		if not requestFunction then
			return false, "Your executor does not support HTTP POST requests"
		end

		local remaining = getContactCooldownRemaining()
		if remaining > 0 then
			local minutes = math.floor(remaining / 60)
			local seconds = remaining % 60
			return false, string.format("Contact cooldown active. Try again in %02d:%02d", minutes, seconds)
		end

		message = message:gsub("@everyone", "`@everyone`"):gsub("@here", "`@here`")
		if #message > 1200 then
			message = string.sub(message, 1, 1200) .. "..."
		end

		local payload = {
			username = "Uni Executor Contact",
			content = string.format(
				"**New contact message**\n**DisplayName:** %s\n**Username:** %s\n**UserId:** %s\n**PlaceId:** %s\n**JobId:** %s\n**Message:** %s",
				tostring(LocalPlayer.DisplayName),
				tostring(LocalPlayer.Name),
				tostring(LocalPlayer.UserId),
				tostring(game.PlaceId),
				tostring(game.JobId),
				message
			),
		}

		local ok, response = pcall(function()
			return requestFunction({
				Url = CONTACT_WEBHOOK_URL,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json",
				},
				Body = HttpService:JSONEncode(payload),
			})
		end)

		if not ok then
			return false, tostring(response)
		end

		local statusCode = tonumber(response and (response.StatusCode or response.Status)) or 0
		if statusCode < 200 or statusCode >= 300 then
			local responseBody = response and (response.Body or response.body) or ""
			if responseBody ~= "" then
				return false, string.format("Webhook request failed (HTTP %d): %s", statusCode, tostring(responseBody))
			end

			return false, string.format("Webhook request failed (HTTP %d)", statusCode)
		end

		STATE.lastContactSentAt = os.time()
		saveContactCooldown()

		return true
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- COMMANDS
--////////////////////////////////////////////////////
do
	local CommandHandlers = {}

	function CommandHandlers.teleportwalkto(username)
		if not username or username == "" then
			print("[FAIL] Usage: teleportwalkto {player}")
			return
		end

		startTeleportWalkTo(username)
	end

	function CommandHandlers.unteleportwalkto()
		if not STATE.teleportWalkToEnabled then
			print("[FAIL] TeleportWalkTo is not currently enabled")
			return
		end

		stopTeleportWalkTo()
	end

	local function normalizeAliases(aliases)
		local result = {}

		if type(aliases) ~= "table" then
			return result
		end

		local seen = {}

		for i = 1, #aliases do
			local alias = string.lower(trimString(aliases[i]))
			if alias ~= "" and not seen[alias] then
				seen[alias] = true
				result[#result + 1] = alias
			end
		end

		return result
	end

	local function rebuildCommandRegistryCaches()
		table.clear(CommandsByName)
		table.clear(CommandNames)

		for i = 1, #Commands do
			local cmd = Commands[i]

			CommandsByName[cmd.LowerName] = cmd
			CommandNames[#CommandNames + 1] = cmd.LowerName

			if cmd.Aliases then
				for j = 1, #cmd.Aliases do
					local alias = cmd.Aliases[j]

					if alias ~= cmd.LowerName and not CommandsByName[alias] then
						CommandsByName[alias] = cmd
					end
				end
			end
		end

		STATE.commandCategoryCache = nil
	end

	function addCommand(name, description, execute, category, aliases)
		local lowerName = string.lower(name)

		local cmd = {
			Name = name,
			LowerName = lowerName,
			Description = description,
			Execute = execute,
			Category = string.lower(category or "utility"),
			Aliases = normalizeAliases(aliases),
		}

		Commands[#Commands + 1] = cmd
	end

	do
		function CommandHandlers.esp(distance)
			if distance == nil or tostring(distance):match("^%s*$") then
				distance = math.huge
			else
				distance = tonumber(distance)
				if not distance then
					print("[FAIL] Invalid distance value for esp command")
					return
				end
			end

			print("[SUCCESS] Nametag render distance set to:", distance == math.huge and "infinite" or distance, "studs")
			startNametagSystem(distance)
		end

		function CommandHandlers.unesp()
			print("[SUCCESS] Nametag system disabled")
			stopNametagSystem()
		end

		function CommandHandlers.chams(targetName, distance)
			targetName = tostring(targetName or "")
			if targetName == "" then
				print("[FAIL] Missing target name for chams")
				return
			end

			if distance == nil or tostring(distance):match("^%s*$") then
				distance = math.huge
			else
				distance = tonumber(distance)
				if not distance then
					print("[FAIL] Invalid chams distance value")
					return
				end
			end

			STATE.highlightMaxDistance = distance
			ensureHighlightTracking()

			local lowerTarget = string.lower(targetName)

			if lowerTarget == "all" then
				STATE.highlightAllEnabled = true

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer then
						highlightPlayer(player)
					end
				end

				print("[SUCCESS] Applied highlights to all players with distance:", distance == math.huge and "infinite" or distance)
				return
			end

			for _, team in ipairs(game:GetService("Teams"):GetTeams()) do
				if string.lower(team.Name) == lowerTarget then
					for _, player in ipairs(Players:GetPlayers()) do
						if player.Team == team and player ~= LocalPlayer then
							highlightPlayer(player)
						end
					end

					print("[SUCCESS] Applied highlights to team:", team.Name)
					return
				end
			end

			local targetPlayer = findPlayerByName(targetName)
			if not targetPlayer then
				print("[FAIL] Player or team not found:", targetName)
				return
			end

			highlightPlayer(targetPlayer)
			print("[SUCCESS] Applied chams to player:", targetPlayer.Name)
		end

		function CommandHandlers.unhighlight()
			resetAllHighlights()
			print("[SUCCESS] Removed all highlights")
		end

		function CommandHandlers.fullbright()
			if STATE.fullbrightEnabled then
				print("[FAIL] Fullbright is already enabled")
				return
			end

			print("[SUCCESS] Fullbright enabled")
			startFullbright()
		end

		function CommandHandlers.unfullbright()
			if not STATE.fullbrightEnabled then
				print("[FAIL] Fullbright is not currently enabled")
				return
			end

			print("[SUCCESS] Fullbright disabled")
			stopFullbright()
		end

		function CommandHandlers.espchams(distance)
			if distance == nil or tostring(distance):match("^%s*$") then
				distance = math.huge
			else
				distance = tonumber(distance)
				if not distance then
					print("[FAIL] Invalid espchams distance value")
					return
				end
			end

			startNametagSystem(distance)

			STATE.highlightMaxDistance = distance
			ensureHighlightTracking()
			STATE.highlightAllEnabled = true

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					highlightPlayer(player)
				end
			end

			updateHighlightVisibility()
			print("[SUCCESS] Espchams enabled with distance:", distance == math.huge and "infinite" or distance)
		end

		function CommandHandlers.unespchams()
			stopNametagSystem()
			resetAllHighlights()
			print("[SUCCESS] Espchams disabled")
		end

		function CommandHandlers.tracers(distance)
			if STATE.tracersEnabled then
				print("[FAIL] Tracers are already enabled")
				return
			end

			print("[SUCCESS] Tracers enabled")
			startTracers(distance)
		end

		function CommandHandlers.untracers()
			if not STATE.tracersEnabled then
				print("[FAIL] Tracers are not currently enabled")
				return
			end

			print("[SUCCESS] Tracers disabled")
			stopTracers()
		end

		function CommandHandlers.xray()
			if STATE.xrayEnabled then
				print("[FAIL] Xray is already enabled")
				return
			end

			startXray()
			print("[SUCCESS] Xray enabled")
		end

		function CommandHandlers.unxray()
			if not STATE.xrayEnabled then
				print("[FAIL] Xray is not currently enabled")
				return
			end

			stopXray()
			print("[SUCCESS] Xray disabled")
		end

		function CommandHandlers.hideparticles()
			if STATE.particlesHidden then
				print("[FAIL] Particles are already hidden")
				return
			end

			startHideParticles()
			print("[SUCCESS] Particles hidden")
		end

		function CommandHandlers.showparticles()
			if not STATE.particlesHidden then
				print("[FAIL] Particles are already visible")
				return
			end

			stopHideParticles()
			print("[SUCCESS] Particles restored")
		end

		function CommandHandlers.hideeffects()
			if STATE.effectsHidden then
				print("[FAIL] Effects are already hidden")
				return
			end

			startHideEffects()
			print("[SUCCESS] Effects hidden")
		end

		function CommandHandlers.showeffects()
			if not STATE.effectsHidden then
				print("[FAIL] Effects are already visible")
				return
			end

			stopHideEffects()
			print("[SUCCESS] Effects restored")
		end

		function CommandHandlers.disabletextures()
			if STATE.texturesDisabled then
				print("[FAIL] Textures are already disabled")
				return
			end

			startDisableTextures()
			print("[SUCCESS] Textures disabled")
		end

		function CommandHandlers.enabletextures()
			if not STATE.texturesDisabled then
				print("[FAIL] Textures are already enabled")
				return
			end

			stopDisableTextures()
			print("[SUCCESS] Textures restored")
		end

		function CommandHandlers.hitboxtransparency(...)
			local args = { ... }
			if #args < 1 then
				print("Usage: hitboxtransparency {amount} {player/team/all}")
				return
			end

			local amount = tonumber(args[1])
			if not amount then
				print("Invalid transparency value")
				return
			end

			amount = math.clamp(amount, 0, 1)

			if #args == 1 then
				args[2] = "all"
			end

			table.remove(args, 1)
			local targetName = table.concat(args, " ")
			local lowerTarget = string.lower(targetName)

			if lowerTarget == "all" then
				STATE.hitboxTransparencyAll = amount
				table.clear(STATE.hitboxTransparencyPlayers)
				table.clear(STATE.hitboxTransparencyTeams)

				for _, player in ipairs(Players:GetPlayers()) do
					applyStoredHitboxTransparency(player)
				end

				print("Hitbox transparency set to", amount, "for all players")
				return
			end

			for _, team in ipairs(game:GetService("Teams"):GetTeams()) do
				if string.lower(team.Name) == lowerTarget then
					STATE.hitboxTransparencyTeams[team.Name] = amount

					for _, player in ipairs(Players:GetPlayers()) do
						if player.Team == team then
							applyStoredHitboxTransparency(player)
						end
					end

					print("Hitbox transparency set to", amount, "for team:", team.Name)
					return
				end
			end

			local targetPlayer = findPlayerByName(targetName)
			if not targetPlayer then
				print("Player or team not found:", targetName)
				return
			end

			STATE.hitboxTransparencyPlayers[targetPlayer.UserId] = amount
			applyStoredHitboxTransparency(targetPlayer)
			print("Hitbox transparency set to", amount, "for player:", targetPlayer.Name)
		end
	end

	do
		function CommandHandlers.tpwalk(multiplier)
			multiplier = tonumber(multiplier)
			if not multiplier then
				print("[FAIL] Invalid tpwalk multiplier value")
				return
			end

			print("[SUCCESS] Tpwalk enabled with multiplier:", multiplier)
			startTpWalk(multiplier)
		end

		function CommandHandlers.untpwalk()
			print("[SUCCESS] Tpwalk disabled")
			stopTpWalk()
		end

		function CommandHandlers.blink(distance)
			distance = tonumber(distance)
			if not distance then
				print("[FAIL] Invalid blink distance value")
				return
			end

			local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not rootPart then
				print("[FAIL] HumanoidRootPart not found for blink")
				return
			end

			local lookVector = rootPart.CFrame.LookVector
			local flatForward = Vector3.new(lookVector.X, 0, lookVector.Z)

			if flatForward.Magnitude <= 0 then
				print("[FAIL] Invalid look direction for blink")
				return
			end

			flatForward = flatForward.Unit
			rootPart.CFrame = CFrame.new(rootPart.Position + flatForward * distance, rootPart.Position + flatForward * (distance + 1))

			print("[SUCCESS] Teleported", distance, "studs forward")
		end

		function CommandHandlers.fly(speed)
			if STATE.menuOpen then
				closeMenu()
			end

			if STATE.flyEnabled then
				print("[FAIL] Fly is already enabled")
				return
			end

			print("[SUCCESS] Fly enabled")
			startFly(speed)
		end

		function CommandHandlers.unfly()
			if not STATE.flyEnabled then
				print("[FAIL] Fly is not currently enabled")
				return
			end

			print("[SUCCESS] Fly disabled")
			stopFly()
		end

		function CommandHandlers.freecam(speed)
			if STATE.freecamEnabled then
				print("[FAIL] Freecam is already enabled")
				return
			end

			print("[SUCCESS] Freecam enabled")
			startFreecam(speed)
		end

		function CommandHandlers.unfreecam()
			if not STATE.freecamEnabled then
				print("[FAIL] Freecam is not currently enabled")
				return
			end

			print("[SUCCESS] Freecam disabled")
			stopFreecam()
		end

		function CommandHandlers.walkspeed(amount)
			if not amount or amount == "" then
				print("[FAIL] Missing walkspeed amount")
				return
			end

			local numAmount = tonumber(amount)
			if not numAmount then
				print("[FAIL] Invalid walkspeed value:", amount)
				return
			end

			print("[SUCCESS] Walkspeed set to:", numAmount)
			setWalkSpeed(amount)
		end

		function CommandHandlers.resetwalkspeed()
			print("[SUCCESS] Walkspeed reset to default")
			resetWalkSpeed()
		end

		function CommandHandlers.jumpheight(amount)
			if not amount or amount == "" then
				print("[FAIL] Missing jumpheight amount")
				return
			end

			local numAmount = tonumber(amount)
			if not numAmount then
				print("[FAIL] Invalid jumpheight value:", amount)
				return
			end

			print("[SUCCESS] Jumpheight set to:", numAmount)
			setJumpHeight(amount)
		end

		function CommandHandlers.resetjumpheight()
			print("[SUCCESS] Jumpheight reset to default")
			resetJumpHeight()
		end

		function CommandHandlers.maxzoom(amount)
			if not amount or amount == "" then
				print("[FAIL] Missing zoom amount")
				return
			end

			amount = tonumber(amount)
			if not amount then
				print("[FAIL] Invalid zoom amount value:", amount)
				return
			end

			LocalPlayer.CameraMaxZoomDistance = amount
			print("[SUCCESS] Max zoom distance set to:", amount)
		end

		function CommandHandlers.defaultzoom()
			LocalPlayer.CameraMaxZoomDistance = STATE.defaultCameraMaxZoom
			print("[SUCCESS] Camera zoom reset to default:", STATE.defaultCameraMaxZoom)
		end

		function CommandHandlers.gravity(multiplier)
			if not multiplier or multiplier == "" then
				print("[FAIL] Missing gravity multiplier")
				return
			end

			local num = tonumber(multiplier)
			if not num then
				print("[FAIL] Invalid gravity multiplier")
				return
			end

			setGravityMultiplier(num)
			print("[SUCCESS] Gravity multiplier set to:", num, "->", workspace.Gravity)
		end

		function CommandHandlers.resetgravity()
			resetGravity()
			print("[SUCCESS] Gravity reset to:", workspace.Gravity)
		end

		function CommandHandlers.hipheight(amount)
			if not amount or amount == "" then
				print("[FAIL] Missing hipheight amount")
				return
			end

			local num = tonumber(amount)
			if not num then
				print("[FAIL] Invalid hipheight amount")
				return
			end

			setHipHeight(num)
			print("[SUCCESS] HipHeight set to:", num)
		end

		function CommandHandlers.resethipheight()
			resetHipHeight()
			print("[SUCCESS] HipHeight reset")
		end

		function CommandHandlers.infjump()
			if STATE.infJumpEnabled then
				print("[FAIL] Infjump is already enabled")
				return
			end

			startInfJump()
			print("[SUCCESS] Infjump enabled")
		end

		function CommandHandlers.uninfjump()
			if not STATE.infJumpEnabled then
				print("[FAIL] Infjump is not currently enabled")
				return
			end

			stopInfJump()
			print("[SUCCESS] Infjump disabled")
		end

		function CommandHandlers.edgejump()
			if STATE.edgeJumpEnabled then
				print("[FAIL] Edgejump is already enabled")
				return
			end

			startEdgeJump()
			if STATE.edgeJumpEnabled then
				print("[SUCCESS] Edgejump enabled")
			end
		end

		function CommandHandlers.unedgejump()
			if not STATE.edgeJumpEnabled then
				print("[FAIL] Edgejump is not currently enabled")
				return
			end

			stopEdgeJump()
			print("[SUCCESS] Edgejump disabled")
		end
	end

	do
		function CommandHandlers.hitbox(...)
			local args = { ... }
			if #args < 2 then
				print("[FAIL] Usage: hitbox {player/team} {multiplier}")
				return
			end

			local multiplier = tonumber(args[#args])
			if not multiplier then
				print("[FAIL] Invalid hitbox multiplier value")
				return
			end

			args[#args] = nil
			local targetName = table.concat(args, " ")
			if targetName == "" then
				print("[FAIL] Missing target name or team")
				return
			end

			ensureHitboxTracking()

			local lowerTarget = string.lower(targetName)

			for _, team in ipairs(game:GetService("Teams"):GetTeams()) do
				if string.lower(team.Name) == lowerTarget then
					STATE.hitboxTeamMultipliers[team.Name] = multiplier

					for _, player in ipairs(Players:GetPlayers()) do
						if player.Team == team and player ~= LocalPlayer then
							applyHitboxToPlayer(player, multiplier)
						end
					end

					STATE.hitboxSystemEnabled = true
					refreshAllActiveHitboxes()
					print("[SUCCESS] Applied hitbox multiplier", multiplier, "to team:", team.Name)
					return
				end
			end

			if lowerTarget == "all" then
				STATE.hitboxAllMultiplier = multiplier

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer then
						STATE.hitboxPlayerMultipliers[player.UserId] = nil
					end
				end

				STATE.hitboxSystemEnabled = true
				refreshAllActiveHitboxes()
				print("[SUCCESS] Applied hitbox multiplier", multiplier, "to all players")
				return
			end

			local targetPlayer = findPlayerByName(targetName)
			if not targetPlayer then
				print("[FAIL] Player or team not found:", targetName)
				return
			end

			STATE.hitboxSystemEnabled = true
			applyHitboxToPlayer(targetPlayer, multiplier)
			print("[SUCCESS] Applied hitbox multiplier", multiplier, "to player:", targetPlayer.Name)
		end

		function CommandHandlers.resethitboxes()
			resetAllHitboxes()
			print("[SUCCESS] Reset all expanded hitboxes")
		end

		function CommandHandlers.goto(username)
			if not username or username == "" then
				print("[FAIL] Missing username for goto command")
				return
			end

			local target = findPlayerByName(username)
			if not target then
				print("[FAIL] Player not found:", username)
				return
			end

			local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")

			if not root then
				print("[FAIL] Your HumanoidRootPart not found")
				return
			end

			if not targetRoot then
				print("[FAIL] Target HumanoidRootPart not found")
				return
			end

			root.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
			print("[SUCCESS] Teleported to player:", target.Name)
		end

		function CommandHandlers.view(username)
			if not username or username == "" then
				print("[FAIL] Missing username for view command")
				return
			end

			local target = findPlayerByName(username)
			if not target then
				print("[FAIL] Player not found:", username)
				return
			end

			local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				print("[FAIL] Target humanoid not found")
				return
			end

			local camera = workspace.CurrentCamera
			if not camera then
				print("[FAIL] Camera not found")
				return
			end

			camera.CameraSubject = humanoid
			STATE.viewingPlayer = target
			print("[SUCCESS] Now viewing player:", target.Name)
		end

		function CommandHandlers.unview()
			local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			local camera = workspace.CurrentCamera

			if not humanoid then
				print("[FAIL] Your humanoid not found")
				return
			end

			if not camera then
				print("[FAIL] Camera not found")
				return
			end

			camera.CameraSubject = humanoid
			STATE.viewingPlayer = nil
			print("[SUCCESS] Camera returned to your character")
		end

		function CommandHandlers.noclip()
			if STATE.noclipEnabled then
				print("[FAIL] Noclip is already enabled")
				return
			end

			STATE.noclipEnabled = true
			STATE.noclipConnection = game:GetService("RunService").Stepped:Connect(function()
				local character = LocalPlayer.Character
				if not character then
					return
				end

				for _, part in ipairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end)

			print("[SUCCESS] Noclip enabled")
		end

		function CommandHandlers.clip()
			if not STATE.noclipEnabled then
				print("[FAIL] Noclip is not currently enabled")
				return
			end

			STATE.noclipEnabled = false

			if STATE.noclipConnection then
				STATE.noclipConnection:Disconnect()
				STATE.noclipConnection = nil
			end

			local character = LocalPlayer.Character
			if character then
				for _, part in ipairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = true
					end
				end
			end

			print("[SUCCESS] Noclip disabled")
		end

		function CommandHandlers.sit()
			local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				print("[FAIL] Humanoid not found for sit")
				return
			end

			humanoid.Sit = true
			print("[SUCCESS] Character sitting")
		end

		function CommandHandlers.respawn()
			local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				print("[FAIL] Humanoid not found for respawn")
				return
			end

			humanoid.Health = 0
			print("[SUCCESS] Character respawned")
		end

		function CommandHandlers.playerinfo(username)
			if not username or username == "" then
				print("[FAIL] Missing username for playerinfo command")
				return
			end

			local target = findPlayerByName(username)
			if not target then
				print("[FAIL] Player not found:", username)
				return
			end

			populatePlayerInfo(target)
		end

		function CommandHandlers.strengthen(multiplier)
			if not multiplier or multiplier == "" then
				print("[FAIL] Missing strengthen multiplier")
				return
			end

			local text = tostring(multiplier):lower()
			if text == "inf" or text == "infinite" then
				startStrength("inf")
				print("[SUCCESS] Infinite strength enabled")
				return
			end

			local num = tonumber(multiplier)
			if not num or num <= 0 then
				print("[FAIL] Invalid strengthen multiplier")
				return
			end

			startStrength(num)
			print("[SUCCESS] Strength multiplier set to:", num)
		end

		function CommandHandlers.unstrengthen()
			if not STATE.strengthEnabled then
				print("[FAIL] Strengthen is not currently enabled")
				return
			end

			stopStrength()
			print("[SUCCESS] Strengthen disabled")
		end
	end

	do
		function CommandHandlers.help(category)
			if category and tostring(category):match("%S") then
				populateHelpList(category)
				print("[SUCCESS] Help category displayed:", tostring(category))
			else
				populateHelpList()
				print("[SUCCESS] Full help list displayed")
			end
		end

		function CommandHandlers.rejoin()
			executorPrint("[SUCCESS] Rejoining server...")

			local TeleportService = game:GetService("TeleportService")

			if queue_on_teleport then
				queue_on_teleport([[
				loadstring(game:HttpGet("https://raw.githubusercontent.com/realuni/UnisCommandExecutor/refs/heads/main/source"))()
			]])
			end

			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		end

		function CommandHandlers.teams()
			print("[SUCCESS] Teams list displayed")
			populateTeamsList()
		end

		function CommandHandlers.destroy()
			print("[SUCCESS] Executor system destroyed")
			destroyExecutorSystem()
		end

		function CommandHandlers.bind(...)
			local args = { ... }
			if #args < 2 then
				print("[FAIL] Usage: bind {key} {command}")
				return
			end

			local keyName = string.upper(args[1])
			local keyCode = Enum.KeyCode[keyName]
			if not keyCode then
				print("[FAIL] Invalid key:", keyName)
				return
			end

			if isCurrentCmdrPrefixKey(keyCode) then
				print("[FAIL] This key is currently used as the cmdr prefix")
				return
			end

			table.remove(args, 1)
			local commandText = table.concat(args, " ")
			if commandText == "" then
				print("[FAIL] Missing command to bind")
				return
			end

			local lowerCommand = string.lower(commandText)

			if lowerCommand == "clickteleport" then
				STATE.ghostBinds[keyCode] = "clickteleport"
				saveBinds()
				print("[SUCCESS] Bound ghost command clickteleport to key:", keyName)
				return
			end

			if lowerCommand == "clickdelete" then
				STATE.ghostBinds[keyCode] = "clickdelete"
				saveBinds()
				print("[SUCCESS] Bound ghost command clickdelete to key:", keyName)
				return
			end

			if lowerCommand == "bind"
				or lowerCommand == "togglebind"
				or lowerCommand == "holdbind"
				or lowerCommand == "unbind"
				or lowerCommand == "clearbinds" then
				print("[FAIL] Cannot bind bind-related commands")
				return
			end

			if not STATE.keybinds[keyCode] then
				STATE.keybinds[keyCode] = {}
			end

			table.insert(STATE.keybinds[keyCode], commandText)

			saveBinds()
			print("[SUCCESS] Bound key", keyName, "to command:", commandText)
		end

		function CommandHandlers.unbind(key)
			if not key or key == "" then
				print("[FAIL] Usage: unbind {key}")
				return
			end

			local keyName = string.upper(key)
			local keyCode = Enum.KeyCode[keyName]

			if not keyCode then
				print("[FAIL] Invalid key:", keyName)
				return
			end

			if not STATE.keybinds[keyCode]
				and not STATE.toggleBinds[keyCode]
				and not STATE.holdBinds[keyCode]
				and not STATE.ghostBinds[keyCode] then
				print("[FAIL] No bind found for key:", keyName)
				return
			end

			STATE.keybinds[keyCode] = nil
			STATE.toggleBinds[keyCode] = nil
			STATE.holdBinds[keyCode] = nil
			STATE.ghostBinds[keyCode] = nil
			STATE.activeHoldBinds[keyCode] = nil
			saveBinds()

			print("[SUCCESS] Unbound key:", keyName)
		end

		function CommandHandlers.binds()
			prepareDisplayListMode()

			local found = false

			for key, commands in pairs(STATE.keybinds) do
				found = true
				for _, cmd in ipairs(commands) do
					createExampleHelperLine(key.Name .. " -> " .. cmd)
				end
			end

			for key, data in pairs(STATE.toggleBinds) do
				found = true
				createExampleHelperLine(key.Name .. " -> " .. data.onCommand .. " / " .. data.offCommand .. " (toggle)")
			end

			for key, data in pairs(STATE.holdBinds) do
				found = true
				createExampleHelperLine(key.Name .. " -> " .. data.onCommand .. " / " .. data.offCommand .. " (hold)")
			end

			for key, ghost in pairs(STATE.ghostBinds) do
				found = true
				createExampleHelperLine(key.Name .. " -> " .. ghost .. " (ghost)")
			end

			createExampleHelperLine("executorintro -> " .. tostring(STATE.executorIntroEnabled))
			createExampleHelperLine("soundnotifications -> " .. tostring(STATE.soundNotificationsEnabled))
			found = true

			if not found then
				createExampleHelperLine("No binds set.")
			end

			UI.HelperBG.Visible = true
			print("[SUCCESS] Binds list displayed")
		end

		function CommandHandlers.clearbinds()
			table.clear(STATE.keybinds)
			table.clear(STATE.toggleBinds)
			table.clear(STATE.holdBinds)
			table.clear(STATE.ghostBinds)
			table.clear(STATE.activeHoldBinds)
			saveBinds()

			print("[SUCCESS] All binds cleared")
		end

		function CommandHandlers.togglebind(...)
			local args = { ... }
			if #args < 2 then
				print("[FAIL] Usage: togglebind {key} {command}")
				return
			end

			local keyName = string.upper(args[1])
			local keyCode = Enum.KeyCode[keyName]
			if not keyCode then
				print("[FAIL] Invalid key:", keyName)
				return
			end

			if isCurrentCmdrPrefixKey(keyCode) then
				print("[FAIL] This key is currently used as the cmdr prefix")
				return
			end

			table.remove(args, 1)
			local commandText = table.concat(args, " ")
			if commandText == "" then
				print("[FAIL] Missing command to bind")
				return
			end

			local lowerCommandName = getCommandNameFromText(commandText)

			if lowerCommandName == "bind"
				or lowerCommandName == "togglebind"
				or lowerCommandName == "holdbind"
				or lowerCommandName == "unbind"
				or lowerCommandName == "clearbinds" then
				print("[FAIL] Cannot bind bind-related commands")
				return
			end

			local offCommand = getBindableOffCommand(commandText)
			if not offCommand then
				print("[FAIL] No automatic off-command exists for:", lowerCommandName)
				return
			end

			STATE.toggleBinds[keyCode] = {
				onCommand = commandText,
				offCommand = offCommand,
				state = false
			}

			saveBinds()
			print("[SUCCESS] Toggle bind created:", keyName, "->", commandText, "/", offCommand)
		end

		function CommandHandlers.holdbind(...)
			local args = { ... }
			if #args < 2 then
				print("[FAIL] Usage: holdbind {key} {command}")
				return
			end

			local keyName = string.upper(args[1])
			local keyCode = Enum.KeyCode[keyName]
			if not keyCode then
				print("[FAIL] Invalid key:", keyName)
				return
			end

			if isCurrentCmdrPrefixKey(keyCode) then
				print("[FAIL] This key is currently used as the cmdr prefix")
				return
			end

			table.remove(args, 1)
			local commandText = table.concat(args, " ")
			if commandText == "" then
				print("[FAIL] Missing command to bind")
				return
			end

			local lowerCommandName = getCommandNameFromText(commandText)

			if lowerCommandName == "bind"
				or lowerCommandName == "togglebind"
				or lowerCommandName == "holdbind"
				or lowerCommandName == "unbind"
				or lowerCommandName == "clearbinds" then
				print("[FAIL] Cannot bind bind-related commands")
				return
			end

			local offCommand = getBindableOffCommand(commandText)
			if not offCommand then
				print("[FAIL] No automatic off-command exists for:", lowerCommandName)
				return
			end

			STATE.holdBinds[keyCode] = {
				onCommand = commandText,
				offCommand = offCommand
			}
			STATE.activeHoldBinds[keyCode] = nil

			saveBinds()
			print("[SUCCESS] Hold bind created:", keyName, "->", commandText, "/", offCommand)
		end

		function CommandHandlers.waypointcreate(...)
			local args = { ... }
			if #args < 1 then
				print("[FAIL] Usage: waypointcreate {name}")
				return
			end

			local waypointName = table.concat(args, " ")
			if waypointName == "" then
				print("[FAIL] Missing waypoint name")
				return
			end

			if STATE.waypoints[waypointName] then
				print("[FAIL] Waypoint already exists:", waypointName)
				return
			end

			local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not root then
				print("[FAIL] HumanoidRootPart not found")
				return
			end

			STATE.waypoints[waypointName] = root.Position

			if saveWaypoints() then
				print("[SUCCESS] Waypoint created and saved:", waypointName)
			else
				print("[SUCCESS] Waypoint created (not saved - executor API unavailable):", waypointName)
			end
		end

		function CommandHandlers.fov(amount)
			if not amount or amount == "" then
				print("[FAIL] Missing FOV amount")
				return
			end

			local numAmount = tonumber(amount)
			if not numAmount then
				print("[FAIL] Invalid FOV value:", amount)
				return
			end

			print("[SUCCESS] FOV set to:", numAmount)
			startCustomFov(amount)
		end

		function CommandHandlers.resetfov()
			print("[SUCCESS] FOV reset to default")
			stopCustomFov()
		end

		function CommandHandlers.waypointdelete(...)
			local args = { ... }
			if #args < 1 then
				print("[FAIL] Usage: waypointdelete {name}")
				return
			end

			local waypointName = table.concat(args, " ")
			if waypointName == "" then
				print("[FAIL] Missing waypoint name")
				return
			end

			if not STATE.waypoints[waypointName] then
				print("[FAIL] Waypoint not found:", waypointName)
				return
			end

			STATE.waypoints[waypointName] = nil

			local marker = STATE.waypointMarkers[waypointName]
			if marker then
				marker:Destroy()
				STATE.waypointMarkers[waypointName] = nil
			end

			local billboard = STATE.waypointBillboards[waypointName]
			if billboard then
				billboard:Destroy()
				STATE.waypointBillboards[waypointName] = nil
			end

			local indicator = STATE.waypointIndicators[waypointName]
			if indicator then
				indicator:Destroy()
				STATE.waypointIndicators[waypointName] = nil
			end

			local label = STATE.waypointIndicatorLabels[waypointName]
			if label then
				label:Destroy()
				STATE.waypointIndicatorLabels[waypointName] = nil
			end

			if saveWaypoints() then
				print("[SUCCESS] Waypoint deleted and saved:", waypointName)
			else
				print("[SUCCESS] Waypoint deleted (not saved - executor API unavailable):", waypointName)
			end
		end

		function CommandHandlers.waypoints()
			prepareDisplayListMode()

			local found = false
			for name in pairs(STATE.waypoints) do
				found = true
				createExampleHelperLine(name)
			end

			if not found then
				createExampleHelperLine("No waypoints created.")
			end

			UI.HelperBG.Visible = true
			print("[SUCCESS] Waypoints list displayed")
		end

		function CommandHandlers.gotowaypoint(...)
			local args = { ... }
			if #args < 1 then
				print("[FAIL] Usage: gotowaypoint {name}")
				return
			end

			local waypointName = table.concat(args, " ")
			if waypointName == "" then
				print("[FAIL] Missing waypoint name")
				return
			end

			if not STATE.waypoints[waypointName] then
				print("[FAIL] Waypoint not found:", waypointName)
				return
			end

			local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not root then
				print("[FAIL] HumanoidRootPart not found")
				return
			end

			root.CFrame = CFrame.new(STATE.waypoints[waypointName])
			print("[SUCCESS] Teleported to waypoint:", waypointName)
		end

		function CommandHandlers.savewaypoints()
			if saveWaypoints() then
				print("[SUCCESS] Waypoints saved to file")
			else
				print("[FAIL] Could not save waypoints - executor API unavailable")
			end
		end

		function CommandHandlers.showwaypoints()
			if STATE.waypointShowEnabled and next(STATE.waypointMarkers) ~= nil then
				print("[FAIL] Waypoints are already shown")
				return
			end

			destroyWaypointMarkers()

			local count = 0
			for name, position in pairs(STATE.waypoints) do
				local cylinder, billboardPart = createWaypointMarker(name, position)
				local arrow, label = createWaypointIndicator(name)

				STATE.waypointMarkers[name] = cylinder
				STATE.waypointBillboards[name] = billboardPart
				STATE.waypointIndicators[name] = arrow
				STATE.waypointIndicatorLabels[name] = label
				count += 1
			end

			STATE.waypointShowEnabled = true
			startWaypointRendering()

			print("[SUCCESS] Showing waypoint markers for", count, "waypoints")
		end

		function CommandHandlers.hidewaypoints()
			if not STATE.waypointShowEnabled then
				print("[FAIL] Waypoints are already hidden")
				return
			end

			stopWaypointRendering()
			destroyWaypointMarkers()
			print("[SUCCESS] Hid all waypoint markers")
		end

		function CommandHandlers.clickteleport()
			print("[FAIL] This is a ghost command. You must bind it to a key first using: bind {key} clickteleport")
		end

		function CommandHandlers.clickdelete()
			print("[FAIL] This is a ghost command. You must bind it to a key first using: bind {key} clickdelete")
		end

		function CommandHandlers.chatlogs()
			openChatLogs()
			print("[SUCCESS] Chat logs opened")
		end

		function CommandHandlers.enableleaderboards()
			setLeaderboardsEnabled(true)
		end

		function CommandHandlers.disableleaderboards()
			setLeaderboardsEnabled(false)
		end

		function CommandHandlers.enablerespawn()
			setRespawnEnabled(true)
		end

		function CommandHandlers.disablerespawn()
			setRespawnEnabled(false)
		end

		function CommandHandlers.antiafk()
			if STATE.antiAfkEnabled then
				print("[FAIL] Antiafk is already enabled")
				return
			end

			startAntiAfk()
			print("[SUCCESS] Antiafk enabled")
		end

		function CommandHandlers.unantiafk()
			if not STATE.antiAfkEnabled then
				print("[FAIL] Antiafk is not currently enabled")
				return
			end

			stopAntiAfk()
			print("[SUCCESS] Antiafk disabled")
		end

		function CommandHandlers.antivoid()
			if STATE.antiVoidEnabled then
				print("[FAIL] Antivoid is already enabled")
				return
			end

			startAntiVoid()
			print("[SUCCESS] Antivoid enabled")
		end

		function CommandHandlers.unantivoid()
			if not STATE.antiVoidEnabled then
				print("[FAIL] Antivoid is not currently enabled")
				return
			end

			stopAntiVoid()
			print("[SUCCESS] Antivoid disabled")
		end

		function CommandHandlers.hideui()
			if STATE.uiHidden then
				print("[FAIL] UI is already hidden")
				return
			end

			startHideUi()
			print("[SUCCESS] UI hidden")
		end

		function CommandHandlers.showui()
			if not STATE.uiHidden then
				print("[FAIL] UI is already visible")
				return
			end

			stopHideUi()
			print("[SUCCESS] UI restored")
		end

		function CommandHandlers.nofog()
			if STATE.fogModified then
				print("[FAIL] Nofog is already enabled")
				return
			end

			startNoFog()
			print("[SUCCESS] Nofog enabled")
		end

		function CommandHandlers.resetfog()
			if not STATE.fogModified then
				print("[FAIL] Nofog is not currently enabled")
				return
			end

			stopNoFog()
			print("[SUCCESS] Fog restored")
		end

		function CommandHandlers.serverinfo()
			showServerInfo()
			print("[SUCCESS] Server info displayed")
		end

		function CommandHandlers.cmdhistory()
			showCommandHistory()
			print("[SUCCESS] Command history displayed")
		end

		function CommandHandlers.repeatlast()
			local last = STATE.lastExecutedCommand
			if not last or last == "" then
				print("[FAIL] No last command found")
				return
			end

			if string.lower(last) == "repeatlast" then
				print("[FAIL] Refused to repeat repeatlast recursively")
				return
			end

			print("[SUCCESS] Re-executing:", last)
			executeCommand(last)
		end

		function CommandHandlers.dex()
			print("[SUCCESS] Loading Dex Explorer...")

			local success, err = pcall(function()
				local httpget = game.HttpGet or game.httpget
				local loader = loadstring or load

				if not httpget then
					error("HttpGet not supported by this executor")
				end

				if not loader then
					error("loadstring not supported by this executor")
				end

				local src = httpget(game, "https://raw.githubusercontent.com/infyiff/backup/main/dex.lua")
				loader(src)()
			end)

			if not success then
				print("[FAIL] Could not load Dex:", err)
			end
		end

		function CommandHandlers.defaults()
			showDefaultsInfo()
			print("[SUCCESS] Defaults displayed")
		end

		function CommandHandlers.executorintro(mode)
			mode = string.lower(tostring(mode or ""))

			if mode ~= "on" and mode ~= "off" then
				print("[FAIL] Usage: executorintro {on/off}")
				return
			end

			STATE.executorIntroEnabled = (mode == "on")
			saveBinds()

			print("[SUCCESS] Executor intro set to:", mode)
		end

		function CommandHandlers.cmdrprefix(key)
			if not key or key == "" then
				print("[FAIL] Usage: cmdrprefix {key}")
				return
			end

			local success, result = setCmdrPrefixKeyFromText(key)
			if not success then
				print("[FAIL] " .. tostring(result))
				return
			end

			print("[SUCCESS] Cmdr prefix set to:", result)
		end

		function CommandHandlers.disablesoundnotifications()
			if not STATE.soundNotificationsEnabled then
				print("[FAIL] Sound notifications are already disabled")
				return
			end

			STATE.soundNotificationsEnabled = false
			saveBinds()
			print("[SUCCESS] Sound notifications disabled")
		end

		function CommandHandlers.enablesoundnotifications()
			if STATE.soundNotificationsEnabled then
				print("[FAIL] Sound notifications are already enabled")
				return
			end

			STATE.soundNotificationsEnabled = true
			saveBinds()
			print("[SUCCESS] Sound notifications enabled")
		end

		function CommandHandlers.favorite(...)
			local args = { ... }

			if #args ~= 1 then
				print("[FAIL] Usage: favorite {command}")
				return
			end

			local commandName = string.lower(trimString(args[1]))

			if commandName == "" then
				print("[FAIL] Missing command name")
				return
			end

			if not isCommandFavoritable(commandName) then
				print("[FAIL] Only real command names can be favorited")
				return
			end

			if STATE.favorites[commandName] then
				print("[FAIL] Command is already favorited:", commandName)
				return
			end

			STATE.favorites[commandName] = true
			saveBinds()
			STATE.commandCategoryCache = nil

			print("[SUCCESS] Favorited command:", commandName)
		end

		function CommandHandlers.unfavorite(...)
			local args = { ... }

			if #args ~= 1 then
				print("[FAIL] Usage: unfavorite {command}")
				return
			end

			local commandName = string.lower(trimString(args[1]))

			if commandName == "" then
				print("[FAIL] Missing command name")
				return
			end

			if not CommandsByName[commandName] then
				print("[FAIL] Command not found:", commandName)
				return
			end

			if not STATE.favorites[commandName] then
				print("[FAIL] Command is not favorited:", commandName)
				return
			end

			STATE.favorites[commandName] = nil
			saveBinds()
			STATE.commandCategoryCache = nil

			print("[SUCCESS] Unfavorited command:", commandName)
		end

		function CommandHandlers.jump()
			local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if not humanoid or humanoid.Health <= 0 then
				print("[FAIL] Humanoid not found for jump")
				return
			end

			humanoid.Jump = true
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			print("[SUCCESS] Jumped")
		end

		function CommandHandlers.remotespy()
			print("[SUCCESS] Loading RemoteSpy...")

			local success, err = pcall(function()
				local httpget = game.HttpGet or game.httpget
				local loader = loadstring or load

				if not httpget then
					error("HttpGet not supported by this executor")
				end

				if not loader then
					error("loadstring not supported by this executor")
				end

				local src = httpget(game, "https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua")
				loader(src)()
			end)

			if not success then
				print("[FAIL] Could not load RemoteSpy:", err)
			end
		end

		function CommandHandlers.deathteleport()
			print("[SUCCESS] Teleporting to your last death position...")

			local success, err = teleportToLastDeathPosition()
			if not success then
				print("[FAIL] Could not teleport to last death position:", err)
				return
			end

			print("[SUCCESS] Teleported to your last death position")
		end

		function CommandHandlers.cmdrtheme(...)
			local newColor, err = parseCmdrThemeColor(...)
			if not newColor then
				print("[FAIL] " .. tostring(err))
				return
			end

			applyCmdrThemeColor(newColor)

			if saveBinds() then
				print("[SUCCESS] Cmdr theme set to:", colorToCmdrThemeHexString(newColor))
			else
				print("[SUCCESS] Cmdr theme set to:", colorToCmdrThemeHexString(newColor), "(not saved - executor API unavailable)")
			end
		end

		function CommandHandlers.resetcmdrtheme()
			local defaultColor = Color3.fromRGB(202, 177, 53)

			applyCmdrThemeColor(defaultColor)

			if saveBinds() then
				print("[SUCCESS] Cmdr theme reset to default:", colorToCmdrThemeHexString(defaultColor))
			else
				print("[SUCCESS] Cmdr theme reset to default:", colorToCmdrThemeHexString(defaultColor), "(not saved - executor API unavailable)")
			end
		end

		function CommandHandlers.cmdrfont(...)
			local fontEnum, err = parseCmdrFontName(...)
			if not fontEnum then
				print("[FAIL] " .. tostring(err))
				return
			end

			applyCmdrFont(fontEnum)

			if saveBinds() then
				print("[SUCCESS] Cmdr font set to:", fontEnum.Name)
			else
				print("[SUCCESS] Cmdr font set to:", fontEnum.Name, "(not saved - executor API unavailable)")
			end
		end

		function CommandHandlers.resetcmdrfont()
			resetCmdrFont()

			if saveBinds() then
				print("[SUCCESS] Cmdr font reset to original")
			else
				print("[SUCCESS] Cmdr font reset to original (not saved - executor API unavailable)")
			end
		end

		function CommandHandlers.contact(...)
			local message = trimString(table.concat({...}, " "))

			if message == "" then
				print("[FAIL] Usage: contact {message}")
				return
			end

			local success, err = sendContactWebhookMessage(message)
			if not success then
				print("[FAIL] " .. tostring(err))
				return
			end

			print("[SUCCESS] Contact message sent")
		end

		function CommandHandlers.joinjobid(...)
			local args = {...}

			if #args < 1 then
				print("[FAIL] Usage: joinjobid {jobid} {placeid}")
				return
			end

			local targetJobId = trimString(tostring(args[1]))
			local targetPlaceId = game.PlaceId

			if targetJobId == "" then
				print("[FAIL] Missing jobId")
				return
			end

			if #args >= 2 then
				targetPlaceId = tonumber(args[2])
				if not targetPlaceId then
					print("[FAIL] Invalid placeId")
					return
				end
			end

			if targetPlaceId == game.PlaceId and targetJobId == game.JobId then
				print("[FAIL] You are already in that server")
				return
			end

			print("[EXEC] Joining JobId:", targetJobId, "PlaceId:", targetPlaceId)

			if queue_on_teleport then
				queue_on_teleport([[
			loadstring(game:HttpGet("https://raw.githubusercontent.com/realuni/UnisLuauCommandExecutor/refs/heads/main/main.lua"))()
		]])
			end

			local ok, err = pcall(function()
				TeleportService:TeleportToPlaceInstance(targetPlaceId, targetJobId, LocalPlayer)
			end)

			if not ok then
				print("[FAIL] Teleport request failed:", tostring(err))
			end
		end

		function CommandHandlers.gameconfig()
			openGameConfigModule()
			print("[SUCCESS] Game config opened")
		end
	end

	addCommand("esp", "Displays a customizable nametag above every player displaying their username, health and distance from you in studs", CommandHandlers.esp, "visual")
	addCommand("unesp", "Turns off the customizable nametags above every player displaying their username, health and distance from you in studs.", CommandHandlers.unesp, "visual")
	addCommand("tpwalk", "Makes your character walk faster without speeding up any animations, usage: 'tpwalk 0.25' for a slight boost", CommandHandlers.tpwalk, "player")
	addCommand("untpwalk", "Removes any previously granted 'tpwalk' functions to the players character if there were any", CommandHandlers.untpwalk, "player")
	addCommand("blink", "Teleports you x studs towards the direction your character is looking at.", CommandHandlers.blink, "player")
	addCommand("hitbox", "Multiplies the hitbox area of the selected player or team, usage: 'hitbox username 2' or 'hitbox Engineering Department 2'", CommandHandlers.hitbox, "utility")
	addCommand("resethitboxes", "Removes any previously expanded hitboxes to player characters if there were any", CommandHandlers.resethitboxes, "utility")
	addCommand("respawn", "Resets your roblox character - Sets your humanoid health to 0", CommandHandlers.respawn, "utility")
	addCommand("rejoin", "Rejoins the same server and re-executes the script if supported by your executor", CommandHandlers.rejoin, "utility")
	addCommand("chams", "chams the specified players making them visible through walls, and displaying their animations in real time", CommandHandlers.chams, "visual")
	addCommand("unchams", "Removes any previously added chams effects to every player if there were any", CommandHandlers.unhighlight, "visual")
	addCommand("help", "Shows all commands, or only one category. Usage: help or help movement", CommandHandlers.help, "utility")
	addCommand("goto", "Teleports your player to the specified player, usage: 'goto username'", CommandHandlers.goto, "utility")
	addCommand("view", "Teleports your player camera to the specified player, usage: 'view username'", CommandHandlers.view, "utility")
	addCommand("unview", "Teleports your player camera back to you, if you are spectating someone", CommandHandlers.unview, "utility")
	addCommand("noclip", "Disables all collisions for your local player essentially letting you walk through walls", CommandHandlers.noclip, "player")
	addCommand("clip", "Disables the noclip function", CommandHandlers.clip, "player")
	addCommand("sit", "Forces your player to sit on the nearest ground, to unsit simply jump once", CommandHandlers.sit, "player")
	addCommand("fov", "Changes local fov (field of view), usage: 'fov 80'", CommandHandlers.fov, "player")
	addCommand("resetfov", "Resets your local fov to the default one set by the owner of this experience", CommandHandlers.resetfov, "player")
	addCommand("fly", "Lets you fly around the game, usage: 'fly 100' For a decently fast flight, to unfly just execute the command 'unfly'", CommandHandlers.fly, "player")
	addCommand("unfly", "Stops your character from flying any longer unless you use the fly command again", CommandHandlers.unfly, "player")
	addCommand("tracers", "Draws tracers, each one leading to different player, - tracer color is based on the players team color", CommandHandlers.tracers, "visual")
	addCommand("untracers", "Disables the tracers, each one leading to different player, - tracer color is based on the players team color", CommandHandlers.untracers, "visual")
	addCommand("freecam", "Lets you fly around in sort of a spectator mode, cool minecraft reference huh?", CommandHandlers.freecam, "utility")
	addCommand("unfreecam", "Destroys your freecam and puts your camera back to your character", CommandHandlers.unfreecam, "utility")
	addCommand("walkspeed", "Increases your walkspeed accordingly to what you specify within the command prompt", CommandHandlers.walkspeed, "player", {"ws"})
	addCommand("resetwalkspeed", "Resets your characters walkspeed to a default one set by the owner of this experience", CommandHandlers.resetwalkspeed, "player", {"rws"})
	addCommand("jumpheight", "Increases your jumpheight accordingly to what you specify within the command prompt", CommandHandlers.jumpheight, "player")
	addCommand("resetjumpheight", "Resets your characters jumpheight to a default one set by the owner of this experience", CommandHandlers.resetjumpheight, "player")
	addCommand("fullbright", "Illuminates your whole game, this is useful for playing at night!", CommandHandlers.fullbright, "visual", {"fb"})
	addCommand("unfullbright", "Resets the brightness to the default one set by the owner of this experience", CommandHandlers.unfullbright, "visual", {"unfb"})
	addCommand("espchams", "Combines both the esp and the chams functions!", CommandHandlers.espchams, "visual", {"esph"})
	addCommand("unespchams", "Disables the combination of both the esp and the chams functions!", CommandHandlers.unespchams, "visual", {"unesph"})
	addCommand("maxzoom", "Changes your camera's max zoom distance based on what you specify within the command prompt", CommandHandlers.maxzoom, "player", {"mz"})
	addCommand("defaultzoom", "Changes your camera's max zoom distance to the default settings set by the owner of this experience.", CommandHandlers.defaultzoom, "player", {"dz"})
	addCommand("teams", "Shows every team that exists in this experience", CommandHandlers.teams, "utility")
	addCommand("destroy", "Destroys the entire system leaving no trace of use!", CommandHandlers.destroy, "system", {"exit", "quit", "leave", "remove"})
	addCommand("hitboxtransparency", "Changes the transparency of player humanoid root parts (0-1), usage: hitboxtransparency {amount} {player/team/all}", CommandHandlers.hitboxtransparency, "visual")
	addCommand("bind", "Binds a command to the specified key, usage: bind {key} {command}", CommandHandlers.bind, "binds")
	addCommand("unbind", "Removes a keybind, usage: unbind {key}", CommandHandlers.unbind, "binds")
	addCommand("binds", "Lets you view all of your previously created binds.", CommandHandlers.binds, "binds")
	addCommand("clearbinds", "Clears all of your previously created binds", CommandHandlers.clearbinds, "binds", {"cb"})
	addCommand("togglebind", "Binds a toggleable command to the specified key", CommandHandlers.togglebind, "binds", {"tb"})
	addCommand("waypointcreate", "Creates a waypoint at your current position with the specified name", CommandHandlers.waypointcreate, "utility", {"wpc"})
	addCommand("waypointdelete", "Deletes the specified waypoint", CommandHandlers.waypointdelete, "utility", {"wpd"})
	addCommand("waypoints", "Shows all created waypoints", CommandHandlers.waypoints, "utility", {"wp"})
	addCommand("gotowaypoint", "Teleports you to the specified waypoint", CommandHandlers.gotowaypoint, "utility", {"gotowp"})
	addCommand("savewaypoints", "Manually saves all waypoints to file", CommandHandlers.savewaypoints, "utility", {"savewp"})
	addCommand("showwaypoints", "Shows 3D markers for all waypoints with distance-based transparency", CommandHandlers.showwaypoints, "utility", {"swp"})
	addCommand("hidewaypoints", "Hides all waypoint markers", CommandHandlers.hidewaypoints, "utility", {"hwp"})
	addCommand("playerinfo", "Displays detailed information about the specified player", CommandHandlers.playerinfo, "utility")
	addCommand("clickteleport", "Ghost command - Teleports you to where you click when holding the bound key. Must be bound using the bind command.", CommandHandlers.clickteleport, "player")
	addCommand("clickdelete", "Ghost command - Deletes the object you click when holding the bound key. Must be bound using the bind command.", CommandHandlers.clickdelete, "player")
	addCommand("chatlogs", "Opens a draggable chat logs window which shows up to 1000 player messages from newest to oldest", CommandHandlers.chatlogs, "utility")
	addCommand("strengthen", "Lets you push unanchored parts much more smoothly, usage: strengthen {multiplier} or strengthen inf", CommandHandlers.strengthen, "player")
	addCommand("unstrengthen", "Disables the strengthen system and restores normal pushing", CommandHandlers.unstrengthen, "player")
	addCommand("enableleaderboards", "Enables the built-in Roblox leaderboard/player list locally", CommandHandlers.enableleaderboards, "utility")
	addCommand("disableleaderboards", "Disables the built-in Roblox leaderboard/player list locally", CommandHandlers.disableleaderboards, "utility")
	addCommand("enablerespawn", "Enables the built-in Roblox reset character option locally", CommandHandlers.enablerespawn, "utility")
	addCommand("disablerespawn", "Disables the built-in Roblox reset character option locally", CommandHandlers.disablerespawn, "utility")
	addCommand("gravity", "Multiplies the current workspace gravity, usage: gravity {multiplier}", CommandHandlers.gravity, "player")
	addCommand("resetgravity", "Resets gravity back to the original value", CommandHandlers.resetgravity, "player")
	addCommand("hipheight", "Sets your humanoid hip height, usage: hipheight {amount}", CommandHandlers.hipheight, "player")
	addCommand("resethipheight", "Resets your humanoid hip height to the original value", CommandHandlers.resethipheight, "player")
	addCommand("infjump", "Lets you jump infinitely without needing to touch the ground", CommandHandlers.infjump, "player")
	addCommand("uninfjump", "Disables infjump", CommandHandlers.uninfjump, "player")
	addCommand("antiafk", "Prevents your client from idling out", CommandHandlers.antiafk, "utility")
	addCommand("unantiafk", "Disables antiafk", CommandHandlers.unantiafk, "utility")
	addCommand("xray", "Makes most world parts semi-transparent locally so you can see through them", CommandHandlers.xray, "visual")
	addCommand("unxray", "Disables xray and restores normal local visibility", CommandHandlers.unxray, "visual")
	addCommand("hideparticles", "Hides particle emitters and trails locally", CommandHandlers.hideparticles, "visual")
	addCommand("showparticles", "Shows particle emitters and trails again", CommandHandlers.showparticles, "visual")
	addCommand("hideeffects", "Hides common visual effects locally", CommandHandlers.hideeffects, "visual")
	addCommand("showeffects", "Shows common visual effects again", CommandHandlers.showeffects, "visual")
	addCommand("disabletextures", "Removes textures locally and forces part materials to SmoothPlastic", CommandHandlers.disabletextures, "visual")
	addCommand("enabletextures", "Restores textures and original materials locally", CommandHandlers.enabletextures, "visual")
	addCommand("antivoid", "Teleports you back up if you fall below the safe Y threshold", CommandHandlers.antivoid, "utility")
	addCommand("unantivoid", "Disables antivoid protection", CommandHandlers.unantivoid, "utility")
	addCommand("hideui", "Hides most game UI locally while keeping the executor alive", CommandHandlers.hideui, "utility")
	addCommand("showui", "Restores previously hidden UI", CommandHandlers.showui, "utility")
	addCommand("nofog", "Removes local fog by pushing FogStart/FogEnd very far away", CommandHandlers.nofog, "utility")
	addCommand("resetfog", "Restores the original local fog settings", CommandHandlers.resetfog, "utility")
	addCommand("edgejump", "Automatically jumps for you when you run off an edge", CommandHandlers.edgejump, "player")
	addCommand("unedgejump", "Disables the automatic edge jump system", CommandHandlers.unedgejump, "player")
	addCommand("serverinfo", "Displays local server/session information using the helper panel", CommandHandlers.serverinfo, "utility")
	addCommand("cmdhistory", "Shows your executed command history using the helper panel", CommandHandlers.cmdhistory, "system")
	addCommand("repeatlast", "Re-executes the last command you sent", CommandHandlers.repeatlast, "system")
	addCommand("dex", "Loads the Dex Explorer tool", CommandHandlers.dex, "utility")
	addCommand("holdbind", "Binds a command so it stays active only while the key is held", CommandHandlers.holdbind, "binds")
	addCommand("defaults", "Displays experience/player default values like walkspeed, jumpheight, zoom, gravity and more", CommandHandlers.defaults, "utility")
	addCommand("executorintro", "Enables or disables the intro on next execution, usage: executorintro {on/off}", CommandHandlers.executorintro, "system")
	addCommand("cmdrprefix", "Changes the cmdr open key and saves it. Usage: cmdrprefix {key}", CommandHandlers.cmdrprefix, "binds")
	addCommand("disablesoundnotifications", "Disables success/fail executor sound notifications", CommandHandlers.disablesoundnotifications, "system")
	addCommand("enablesoundnotifications", "Enables success/fail executor sound notifications", CommandHandlers.enablesoundnotifications, "system")
	addCommand("favorite", "Favorites a real command so it appears in the help menu under FAVORITED COMMANDS. Usage: favorite {command}", CommandHandlers.favorite, "system")
	addCommand("unfavorite", "Removes a command from your favorites list. Usage: unfavorite {command}", CommandHandlers.unfavorite, "system")
	addCommand("teleportwalkto", "Smooth pathfind-walks to the target player", CommandHandlers.teleportwalkto, "player", {"tpwt"})
	addCommand("unteleportwalkto", "Stops teleportwalkto", CommandHandlers.unteleportwalkto, "player", {"untpwt"})
	addCommand("jump", "Makes your character jump once", CommandHandlers.jump, "player")
	addCommand("remotespy", "Loads the SimpleSpy V3 remote spy tool", CommandHandlers.remotespy, "utility")
	addCommand("deathteleport", "Teleports you to the position where your character last died", CommandHandlers.deathteleport, "player", {"deathtp"})
	addCommand("cmdrtheme", "Changes the text color theme of your cmdr to the set one, example usage: cmdrtheme 28, 29, 34 / cmdrtheme #1c1d22", CommandHandlers.cmdrtheme, "system")
	addCommand("resetcmdrtheme", "Resets the text color theme of your cmdr back to the default gold color", CommandHandlers.resetcmdrtheme, "system")
	addCommand("cmdrfont", "Changes every font used by the cmdr to the specified Roblox font, example usage: cmdrfont GothamBold", CommandHandlers.cmdrfont, "system")
    addCommand( "resetcmdrfont", "Restores all cmdr fonts back to their original values", CommandHandlers.resetcmdrfont, "system")
	addCommand("contact", "Sends a message to the developer webhook. Cooldown: 5 minutes. Usage: contact {message}", CommandHandlers.contact, "system")
	addCommand("joinjobid", "Joins a specific server. Usage: joinjobid {jobid} {placeid}", CommandHandlers.joinjobid, "system")
	addCommand("gameconfig", "Opens the per-experience preset editor where you can save commands that auto-run when this script executes in that experience", CommandHandlers.gameconfig, "system")
	rebuildCommandRegistryCaches()
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- HELPERS
--////////////////////////////////////////////////////
do
	local COMMAND_DISPLAY_NAMES = {
		esp = "esp {distance}",
		tpwalk = "tpwalk {multiplier}",
		blink = "blink {distance}",
		hitbox = "hitbox {player/team} {multiplier}",
		chams = "chams {player/team/all} {distance}",
		goto = "goto {player}",
		view = "view {player}",
		fov = "fov {amount}",
		fly = "fly {speed}",
		tracers = "tracers {distance}",
		espchams = "espchams {distance}",
		unespchams = "unespchams",
		freecam = "freecam {speed}",
		unfreecam = "unfreecam",
		walkspeed = "walkspeed {amount}",
		resetwalkspeed = "resetwalkspeed",
		jumpheight = "jumpheight {amount}",
		resetjumpheight = "resetjumpheight",
		fullbright = "fullbright",
		unfullbright = "unfullbright",
		maxzoom = "maxzoom {amount}",
		defaultzoom = "defaultzoom",
		hitboxtransparency = "hitboxtransparency {amount} {player/team/all}",
		togglebind = "togglebind {key} {command}",
		bind = "bind {key} {command}",
		unbind = "unbind {key}",
		destroy = "destroy",
		waypointcreate = "waypointcreate {name}",
		waypointdelete = "waypointdelete {name}",
		gotowaypoint = "gotowaypoint {name}",
		playerinfo = "playerinfo {player}",
		clickteleport = "clickteleport [ghost - bind required]",
		clickdelete = "clickdelete [ghost - bind required]",
		chatlogs = "chatlogs",
		strengthen = "strengthen {multiplier}",
		unstrengthen = "unstrengthen",
		gravity = "gravity {multiplier}",
		resetgravity = "resetgravity",
		hipheight = "hipheight {amount}",
		resethipheight = "resethipheight",
		infjump = "infjump",
		uninfjump = "uninfjump",
		antiafk = "antiafk",
		unantiafk = "unantiafk",
		xray = "xray",
		unxray = "unxray",
		hideparticles = "hideparticles",
		showparticles = "showparticles",
		hideeffects = "hideeffects",
		showeffects = "showeffects",
		disabletextures = "disabletextures",
		enabletextures = "enabletextures",
		antivoid = "antivoid",
		unantivoid = "unantivoid",
		hideui = "hideui",
		showui = "showui",
		nofog = "nofog",
		resetfog = "resetfog",
		edgejump = "edgejump",
		unedgejump = "unedgejump",
		serverinfo = "serverinfo",
		cmdhistory = "cmdhistory",
		repeatlast = "repeatlast",
		dex = "dex",
		holdbind = "holdbind {key} {command}",
		defaults = "defaults",
		executorintro = "executorintro {on/off}",
		cmdrprefix = "cmdrprefix {key}",
		disablesoundnotifications = "disablesoundnotifications",
		enablesoundnotifications = "enablesoundnotifications",
		favorite = "favorite {command}",
		unfavorite = "unfavorite {command}",
		teleportwalkto = "teleportwalkto {player}",
		unteleportwalkto = "unteleportwalkto",
		jump = "jump",
		deathtp = "deathteleport",
		cmdrtheme = "cmdrtheme {r, g, b / #rrggbb}",
		resetcmdrtheme = "resetcmdrtheme",
		cmdrfont = "cmdrfont {font_name}",
		resetcmdrfont = "resetcmdrfont",
		contact = "contact {message}",
		gameconfig = "gameconfig",
		joinjobid = "joinjobid {jobid} {placeid}",
	}

	local originalTexts = {
		[UI.Title1] = UI.Title1.Text,
		[UI.Title2] = "Welcome back, " .. LocalPlayer.Name .. ".",
		[UI.Title3] = UI.Title3.Text,
	}

	UI.Title2.Text = originalTexts[UI.Title2]

	local CMDR_PREFIX_DISPLAY_NAMES = {
		Semicolon = ";",
		Comma = ",",
		Period = ".",
		Slash = "/",
		BackSlash = "\\",
		Quote = "'",
		LeftBracket = "[",
		RightBracket = "]",
		Minus = "-",
		Equals = "=",
		Backquote = "`",
		Zero = "0",
		One = "1",
		Two = "2",
		Three = "3",
		Four = "4",
		Five = "5",
		Six = "6",
		Seven = "7",
		Eight = "8",
		Nine = "9",
	}

	local CMDR_PREFIX_PARSE_ALIASES = {
		[";"] = "Semicolon",
		[","] = "Comma",
		["."] = "Period",
		["/"] = "Slash",
		["\\"] = "BackSlash",
		["'"] = "Quote",
		["["] = "LeftBracket",
		["]"] = "RightBracket",
		["-"] = "Minus",
		["="] = "Equals",
		["`"] = "Backquote",
		["0"] = "Zero",
		["1"] = "One",
		["2"] = "Two",
		["3"] = "Three",
		["4"] = "Four",
		["5"] = "Five",
		["6"] = "Six",
		["7"] = "Seven",
		["8"] = "Eight",
		["9"] = "Nine",
	}

	local CMDR_PREFIX_ALLOWED_NAMES = {
		Semicolon = true,
		Comma = true,
		Period = true,
		Slash = true,
		BackSlash = true,
		Quote = true,
		LeftBracket = true,
		RightBracket = true,
		Minus = true,
		Equals = true,
		Backquote = true,
	}

	do
		local digitNames = {"Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"}
		for _, digitName in ipairs(digitNames) do
			CMDR_PREFIX_ALLOWED_NAMES[digitName] = true
		end

		for code = string.byte("A"), string.byte("Z") do
			CMDR_PREFIX_ALLOWED_NAMES[string.char(code)] = true
		end

		for i = 1, 12 do
			CMDR_PREFIX_ALLOWED_NAMES["F" .. i] = true
		end
	end

	function isKeyUsedByAnyBind(keyCode)
		if not keyCode then
			return false
		end

		return STATE.keybinds[keyCode] ~= nil
			or STATE.toggleBinds[keyCode] ~= nil
			or STATE.holdBinds[keyCode] ~= nil
			or STATE.ghostBinds[keyCode] ~= nil
	end

	function isValidCmdrPrefixKey(keyCode)
		return keyCode ~= nil and CMDR_PREFIX_ALLOWED_NAMES[keyCode.Name] == true
	end

	function isCurrentCmdrPrefixKey(keyCode)
		return keyCode ~= nil and keyCode == (STATE.cmdrPrefixKey or Enum.KeyCode.Semicolon)
	end

	function parseCmdrPrefixKey(rawKey)
		local keyText = trimString(rawKey)
		if keyText == "" then
			return nil
		end

		local aliasName = CMDR_PREFIX_PARSE_ALIASES[keyText]
		if aliasName then
			return Enum.KeyCode[aliasName]
		end

		if #keyText == 1 and keyText:match("%a") then
			return Enum.KeyCode[string.upper(keyText)]
		end

		return Enum.KeyCode[keyText] or Enum.KeyCode[string.upper(keyText)]
	end

	function getCmdrPrefixDisplayText()
		local keyCode = STATE.cmdrPrefixKey or Enum.KeyCode.Semicolon
		local keyName = keyCode.Name

		if CMDR_PREFIX_DISPLAY_NAMES[keyName] then
			return CMDR_PREFIX_DISPLAY_NAMES[keyName]
		end

		if #keyName == 1 then
			return string.lower(keyName)
		end

		return keyName
	end

	function updateWelcomeCmdrPrefixText()
		local prefixDisplay = getCmdrPrefixDisplayText()
		local newText = string.format("Press ' %s ' to Open the Menu", prefixDisplay)

		originalTexts[UI.Title3] = newText
		UI.Title3.Text = newText
	end

	function setCmdrPrefixKeyFromText(rawKey)
		local trimmed = trimString(rawKey)
		if trimmed == "" then
			return false, "Usage: cmdrprefix {key}"
		end

		local keyCode = parseCmdrPrefixKey(trimmed)
		if not keyCode then
			return false, "Invalid key: " .. tostring(rawKey)
		end

		if not isValidCmdrPrefixKey(keyCode) then
			return false, "That key cannot be used as the cmdr prefix"
		end

		if isKeyUsedByAnyBind(keyCode) then
			return false, "That key is already used by a bind"
		end

		STATE.cmdrPrefixKey = keyCode
		saveBinds()
		updateWelcomeCmdrPrefixText()

		return true, getCmdrPrefixDisplayText()
	end

	updateWelcomeCmdrPrefixText()

	function getCommandDisplayNameForHelp(cmd)
		local mainDisplay = COMMAND_DISPLAY_NAMES[cmd.Name] or cmd.Name

		if not cmd.Aliases or #cmd.Aliases == 0 then
			return mainDisplay
		end

		local parts = { mainDisplay }

		for i = 1, #cmd.Aliases do
			local alias = cmd.Aliases[i]
			parts[#parts + 1] = COMMAND_DISPLAY_NAMES[alias] or alias
		end

		return table.concat(parts, " / ")
	end

	clearHelpEntries = function()
		for _, child in ipairs(UI.HelperScrollingFrame:GetChildren()) do
			if child:IsA("Frame") and child ~= UI.ExampleHelperTemplate and string.sub(child.Name, 1, 12) ~= "PrintHelper_" then
				child:Destroy()
			end
		end
	end

	function buildHelpEntryText(commandName, commandDescription)
		return string.format(
			"<font color=\"rgb(202,177,53)\">%s :</font> <font color=\"rgb(227,227,227)\">%s</font>",
			commandName,
			commandDescription
		)
	end

	--

	--

	--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	-- CATEGORY FUNCTIONS
	--////////////////////////////////////////////////////

	STATE.helpCategoryOrder = {
		"favorites",
		"visual",
		"player",
		"waypoints",
		"binds",
		"utility",
		"system",
	}

	STATE.helpCategoryTitles = {
		favorites = "FAVORITED COMMANDS",
		visual = "VISUAL",
		player = "PLAYER",
		waypoints = "WAYPOINTS",
		binds = "BINDS",
		utility = "UTILITY",
		system = "SYSTEM",
	}

	STATE.createHelpHeader = function(text)
		local entry = UI.ExampleHelperTemplate:Clone()
		entry.Name = "HelpHeader_" .. tostring(text)
		entry.Visible = true
		entry.Parent = UI.HelperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)
		entry.BackgroundTransparency = 0.2
		entry.BackgroundColor3 = Color3.fromRGB(22, 23, 27)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = string.format(
				"<font color=\"rgb(255,255,255)\"><b>[%s]</b></font>",
				tostring(text)
			)
		end

		return entry
	end

	STATE.createHelpCommandEntry = function(commandName, commandDescription, index)
		local entry = UI.ExampleHelperTemplate:Clone()
		entry.Name = "HelpEntry_" .. tostring(index)
		entry.Visible = true
		entry.Parent = UI.HelperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = buildHelpEntryText(commandName, commandDescription)
		end

		return entry
	end

	STATE.getCommandsGroupedByCategory = function()
		if STATE.commandCategoryCache then
			return STATE.commandCategoryCache
		end

		local grouped = {}

		for _, category in ipairs(STATE.helpCategoryOrder) do
			grouped[category] = {}
		end

		grouped.favorites = getSortedFavoriteCommands()

		for i = 1, #Commands do
			local cmd = Commands[i]
			local category = string.lower(cmd.Category or "utility")

			if STATE.favorites[cmd.LowerName] then
				continue
			end

			if not grouped[category] then
				grouped[category] = {}
			end

			grouped[category][#grouped[category] + 1] = cmd
		end

		for categoryName, categoryList in pairs(grouped) do
			if categoryName ~= "favorites" then
				table.sort(categoryList, function(a, b)
					return a.LowerName < b.LowerName
				end)
			end
		end

		STATE.commandCategoryCache = grouped
		return grouped
	end


	--

	--

	populateHelpList = function(categoryFilter)
		prepareDisplayListMode()

		categoryFilter = string.lower(tostring(categoryFilter or ""))

		local grouped = STATE.getCommandsGroupedByCategory()
		local createdAnything = false
		local entryIndex = 0

		for _, category in ipairs(STATE.helpCategoryOrder) do
			local commandsInCategory = grouped[category]

			if commandsInCategory and #commandsInCategory > 0 then
				if categoryFilter == "" or category == categoryFilter then
					STATE.createHelpHeader(STATE.helpCategoryTitles[category] or string.upper(category))
					createdAnything = true

					for _, cmd in ipairs(commandsInCategory) do
						entryIndex += 1
						STATE.createHelpCommandEntry(
							getCommandDisplayNameForHelp(cmd),
							cmd.Description,
							entryIndex
						)
					end
				end
			end
		end

		if not createdAnything then
			local entry = UI.ExampleHelperTemplate:Clone()
			entry.Name = "HelpEntry_None"
			entry.Visible = true
			entry.Parent = UI.HelperScrollingFrame
			entry.Size = UDim2.new(1, 0, 0, 28)

			local label = entry:FindFirstChild("CommandLine")
			if label then
				label.RichText = true
				label.Text = string.format(
					"<font color=\"rgb(227,227,227)\">No help category found for '%s'.</font>",
					tostring(categoryFilter)
				)
			end
		end

		UI.HelperBG.Visible = true
	end


	populatePlayerInfo = function(targetPlayer)
		prepareDisplayListMode()

		local function createLine(label, value)
			local entry = UI.ExampleHelperTemplate:Clone()
			entry.Visible = true
			entry.Parent = UI.HelperScrollingFrame
			entry.Size = UDim2.new(1, 0, 0, 28)

			local text = entry:FindFirstChild("CommandLine")
			if text then
				text.RichText = true
				text.Text = string.format(
					"<font color=\"rgb(202,177,53)\">%s :</font> <font color=\"rgb(227,227,227)\">%s</font>",
					label,
					tostring(value)
				)
			end
		end

		createLine("Display Name", targetPlayer.DisplayName)
		createLine("Username", targetPlayer.Name)
		createLine("UserId", targetPlayer.UserId)
		createLine("Join Date", os.date("%Y-%m-%d", os.time() - targetPlayer.AccountAge * 86400))
		createLine("Team", targetPlayer.Team and targetPlayer.Team.Name or "None")

		local character = targetPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local root = character:FindFirstChild("HumanoidRootPart")

			createLine("Health", humanoid and math.floor(humanoid.Health) or "Unknown")

			local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if root and localRoot then
				createLine("Distance", string.format("%.1f studs", (root.Position - localRoot.Position).Magnitude))
			end
		end

		UI.HelperBG.Visible = true
		print("[SUCCESS] Player info displayed")
	end

	populateTeamsList = function()
		prepareDisplayListMode()

		for _, team in ipairs(game:GetService("Teams"):GetTeams()) do
			createExampleHelperLine(team.Name)
		end

		UI.HelperBG.Visible = true
	end

	hideHelpList = function()
		UI.HelperBG.Visible = false
		clearHelpEntries()
		UI.ExampleHelperTemplate.Visible = false
		UI.ExampleHelperTemplate.CommandLine.Text = "Command Name : Command Description"
	end

	function tween(object, time, properties)
		local tw = TweenService:Create(object, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
		tw:Play()
		return tw
	end

	function typewrite(label, fullText)
		label.Text = ""
		for i = 1, #fullText do
			label.Text = string.sub(fullText, 1, i)
			task.wait(CONFIG.TYPE_SPEED)
		end
	end

	function fadeWelcomeOut()
		tween(UI.Welcome, CONFIG.FADE_TIME, {BackgroundTransparency = 1})
		tween(UI.Title1, CONFIG.FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1})
		tween(UI.Title2, CONFIG.FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1})
		tween(UI.Title3, CONFIG.FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1})

		task.wait(CONFIG.FADE_TIME)

		UI.Welcome.Visible = false
		UI.Title1.Visible = false
		UI.Title2.Visible = false
		UI.Title3.Visible = false
		STATE.WelcomeFinished = true
	end


	function playWelcomeSequence()
		UI.Welcome.Visible = true
		UI.Title1.Visible = true
		UI.Title2.Visible = true
		UI.Title3.Visible = true

		UI.Welcome.BackgroundTransparency = 0.25
		UI.Title1.TextTransparency = 0
		UI.Title2.TextTransparency = 0
		UI.Title3.TextTransparency = 0
		UI.Title1.BackgroundTransparency = 1
		UI.Title2.BackgroundTransparency = 1
		UI.Title3.BackgroundTransparency = 1

		UI.Title1.Text = ""
		UI.Title2.Text = ""
		UI.Title3.Text = ""

		typewrite(UI.Title1, originalTexts[UI.Title1])
		task.wait(CONFIG.BETWEEN_TITLES_DELAY)
		typewrite(UI.Title2, originalTexts[UI.Title2])
		task.wait(CONFIG.BETWEEN_TITLES_DELAY)
		typewrite(UI.Title3, originalTexts[UI.Title3])
		task.wait(CONFIG.WELCOME_HOLD_TIME)

		fadeWelcomeOut()
	end

	function clearSuggestionEntries()
		for _, child in ipairs(UI.Container:GetChildren()) do
			if child:IsA("Frame") and child ~= UI.ExampleSuggestionTemplate then
				child:Destroy()
			end
		end
	end

	function resetSuggester()
		STATE.currentBestMatch = nil
		UI.CommandSuggester.Visible = false
		UI.SuggesterCommandName.Text = "Command Name"
		UI.SuggesterCommandDescription.Text = "Command Description Goes Here"
		clearSuggestionEntries()
		UI.ExampleSuggestionTemplate.Visible = false
		UI.ExampleSuggestionTemplate.CommandName.Text = "Command Name"
		UI.ExampleSuggestionTemplate.CommandName.TextColor3 = CONFIG.COLOR_NORMAL
	end

	function resetInputAndSuggestions()
		UI.CommandInput.Text = ""
		UI.CommandInput.CursorPosition = -1
		resetSuggester()
	end

	function normalize(str)
		return string.lower(tostring(str or ""))
	end

	function getSearchText(str)
		return tostring(str or ""):gsub("^%s+", "")
	end

	local function scoreSingleCommandName(query, commandName)
		query = string.lower(tostring(query or ""))
		commandName = string.lower(tostring(commandName or ""))

		if query == "" or commandName == "" then
			return -math.huge
		end

		if commandName == query then
			return 1000
		end

		if string.sub(commandName, 1, #query) == query then
			return 800 - (#commandName - #query)
		end

		local startPos = string.find(commandName, query, 1, true)
		if startPos then
			return 600 - startPos
		end

		local score = 0
		local qIndex = 1
		local consecutive = 0

		for i = 1, #commandName do
			if qIndex <= #query and string.sub(commandName, i, i) == string.sub(query, qIndex, qIndex) then
				qIndex += 1
				consecutive += 1
				score += 20 + consecutive * 5
			else
				consecutive = 0
			end
		end

		if qIndex > #query then
			return 300 + score - #commandName * 0.5
		end

		return -math.huge
	end

	function scoreCommand(query, cmd)
		local bestScore = scoreSingleCommandName(query, cmd.LowerName)

		if cmd.Aliases then
			for i = 1, #cmd.Aliases do
				local aliasScore = scoreSingleCommandName(query, cmd.Aliases[i])

				if aliasScore > bestScore then
					bestScore = aliasScore
				end
			end
		end

		return bestScore
	end

	function getMatches(inputText)
		local ranked = {}

		for i = 1, #Commands do
			local cmd = Commands[i]
			local score = scoreCommand(inputText, cmd)

			if score > -math.huge then
				ranked[#ranked + 1] = {
					Command = cmd,
					Score = score,
				}
			end
		end

		table.sort(ranked, function(a, b)
			if a.Score == b.Score then
				return #a.Command.Name < #b.Command.Name
			end
			return a.Score > b.Score
		end)

		local maxCount = math.min(CONFIG.MAX_SUGGESTIONS, #ranked)
		local results = table.create(maxCount)

		for i = 1, maxCount do
			results[i] = ranked[i].Command
		end

		return results
	end

	function rebuildSuggestions(matches)
		clearSuggestionEntries()

		if #matches == 0 then
			UI.CommandSuggester.Visible = false
			STATE.currentBestMatch = nil
			UI.ExampleSuggestionTemplate.Visible = false
			return
		end

		STATE.currentBestMatch = matches[1]
		UI.CommandSuggester.Visible = true
		UI.SuggesterCommandName.Text = getCommandDisplayNameForHelp(STATE.currentBestMatch)
		UI.SuggesterCommandDescription.Text = STATE.currentBestMatch.Description
		UI.ExampleSuggestionTemplate.Visible = true

		for index = 1, #matches do
			local entry = index == 1 and UI.ExampleSuggestionTemplate or UI.ExampleSuggestionTemplate:Clone()
			if index ~= 1 then
				entry.Name = "Suggestion_" .. index
				entry.Visible = true
				entry.Parent = UI.Container
			end

			local entryLabel = entry:FindFirstChild("CommandName")
			if entryLabel then
				entryLabel.Text = getCommandDisplayNameForHelp(matches[index])
				entryLabel.TextColor3 =
					index == 1 and CONFIG.COLOR_SPOTLIGHT or CONFIG.COLOR_NORMAL
			end
		end
	end

	function updateSuggestions()
		local text = getSearchText(UI.CommandInput.Text)
		if text == "" then
			resetSuggester()
			return
		end

		rebuildSuggestions(getMatches(string.split(text, " ")[1] or ""))
		UI.SuggesterCommandName.Text = STATE.currentBestMatch and getCommandDisplayNameForHelp(STATE.currentBestMatch) or "Command Name"
	end

	openMenu = function()
		STATE.menuOpen = true
		STATE.suppressRefocus = false

		UI.BG.Visible = true
		UI.Version.Visible = true
		UI.MainBg.BackgroundTransparency = 1

		resetInputAndSuggestions()
		hideHelpList()
		sanitizeCommandInput()
		tween(UI.MainBg, 0.05, {BackgroundTransparency = 0.3})

		task.defer(function()
			if not STATE.menuOpen then
				return
			end

			if UI.CommandInput then
				pcall(function()
					UI.CommandInput:CaptureFocus()
					UI.CommandInput.CursorPosition = #UI.CommandInput.Text + 1
				end)
			end
		end)
	end

	closeMenu = function()
		STATE.menuOpen = false
		STATE.suppressRefocus = true

		if UI.CommandInput then
			pcall(function()
				UI.CommandInput:ReleaseFocus()
			end)
		end

		clearActivePrintHelpers()

		tween(UI.MainBg, 0.05, {BackgroundTransparency = 1}).Completed:Wait()

		UI.Version.Visible = false
		UI.BG.Visible = false

		resetInputAndSuggestions()
		hideHelpList()

		task.defer(function()
			STATE.suppressRefocus = false
		end)
	end

	function toggleMenu()
		if STATE.menuOpen then
			closeMenu()
		else
			openMenu()
		end

		task.defer(function()
			if not UI.CommandInput then
				return
			end

			local prefixDisplay = getCmdrPrefixDisplayText()
			if type(prefixDisplay) == "string" and #prefixDisplay == 1 then
				local escapedPrefix = prefixDisplay:gsub("(%W)", "%%%1")
				UI.CommandInput.Text = UI.CommandInput.Text:gsub(escapedPrefix, "")
			end

			UI.CommandInput.CursorPosition = #UI.CommandInput.Text + 1
			sanitizeCommandInput()
			updateSuggestions()
		end)
	end

	local PERSISTENT_HELP_COMMANDS = {
		help = true,
		teams = true,
		binds = true,
		waypoints = true,
	}

	TAB_FILL_COMMANDS = {
		esp = "esp ",
		tpwalk = "tpwalk ",
		blink = "blink ",
		hitbox = "hitbox ",
		chams = "chams ",
		goto = "goto ",
		view = "view ",
		fov = "fov ",
		fly = "fly ",
		tracers = "tracers ",
		freecam = "freecam ",
		walkspeed = "walkspeed ",
		jumpheight = "jumpheight ",
		maxzoom = "maxzoom ",
		esphighlight = "esphighlight ",
		playerinfo = "playerinfo ",
		clickteleport = "clickteleport",
		clickdelete = "clickdelete",
		gravity = "gravity ",
		hipheight = "hipheight ",
		favorite = "favorite ",
		unfavorite = "unfavorite ",
		cmdrprefix = "cmdrprefix ",
		jump = "jump",
		deathteleport = "deathteleport ",
		cmdrtheme = "cmdrtheme ",
		resetcmdrtheme = "resetcmdrtheme",
		cmdrfont = "cmdrfont ",
		resetcmdrfont = "resetcmdrfont",
		contact = "contact ",
		gameconfig = "gameconfig",
		joinjobid = "joinjobid ",
	}

	function splitCommandArguments(text)
		text = tostring(text or "")

		local args = {}
		local current = {}
		local inQuotes = false
		local length = string.len(text)
		local i = 1

		while i <= length do
			local char = text:sub(i, i)

			if char == "\"" then
				inQuotes = not inQuotes
			elseif char == " " and not inQuotes then
				if #current > 0 then
					table.insert(args, table.concat(current))
					table.clear(current)
				end
			else
				table.insert(current, char)
			end

			i += 1
		end

		if #current > 0 then
			table.insert(args, table.concat(current))
		end

		return args
	end

	executeCommand = function(commandText)
		local cleaned = trimString(commandText)
		if cleaned == "" then
			UI.CommandInput.Text = ""
			UI.CommandInput.CursorPosition = -1
			updateSuggestions()
			return
		end

		local parts = splitCommandArguments(cleaned)
		local rawName = parts[1]
		local cmdName = string.lower(tostring(rawName or ""))
		local cmd = CommandsByName[cmdName]

		if not cmd then
			print("[FAIL] Unknown command:", cleaned)

			UI.CommandInput.Text = ""
			UI.CommandInput.CursorPosition = -1
			updateSuggestions()

			task.defer(function()
				if STATE.menuOpen then
					UI.CommandInput:CaptureFocus()
				end
			end)

			return
		end

		table.remove(parts, 1)
		local args = (#parts > 0) and parts or nil

		if not PERSISTENT_HELP_COMMANDS[cmdName] then
			hideHelpList()
		end

		UI.CommandInput.Text = ""
		UI.CommandInput.CursorPosition = -1
		updateSuggestions()

		if cmdName ~= "repeatlast" then
			pushCommandHistory(cleaned)
		end

		local ok, err
		if args then
			ok, err = pcall(cmd.Execute, table.unpack(args))
		else
			ok, err = pcall(cmd.Execute)
		end

		if not ok then
			warn("Command execution failed for '" .. cmd.Name .. "': " .. tostring(err))
			print("[FAIL] Command error:", tostring(err))
		else
			sendCommandExecutionWebhook(cleaned)
		end

		task.defer(function()
			if STATE.menuOpen then
				UI.CommandInput:CaptureFocus()
			end
		end)
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- TUTORIAL SYSTEM
--////////////////////////////////////////////////////
do
	local TUTORIAL_FILE = "executor_tutorial.json"

	local TUTORIAL_TEXT_TOTAL_TIME = 0.75
	local TUTORIAL_FADE_TIME = 0.15
	local TUTORIAL_PAGE_DELAY = 0.25

	local TUTORIAL_BUTTON_UP_POSITION = UDim2.new(0, 0, -0.226, 0)
	local TUTORIAL_BUTTON_DOWN_POSITION = UDim2.new(0, 0, 0, 0)
	local TUTORIAL_BUTTON_PRESS_TIME = 0.05

	STATE.tutorialActive = STATE.tutorialActive or false
	STATE.tutorialCompleted = STATE.tutorialCompleted or false
	STATE.tutorialReadyForInput = STATE.tutorialReadyForInput or false
	STATE.tutorialPageKey = STATE.tutorialPageKey or nil
	STATE.tutorialSequenceId = STATE.tutorialSequenceId or 0

	local tutorialInitialized = false
	local tutorialGuiDefaults = {}
	local tutorialPages = {}

	local function rememberTutorialDefaults(guiObject)
		if tutorialGuiDefaults[guiObject] then
			return
		end

		local defaults = {
			Visible = guiObject.Visible,
		}

		if guiObject:IsA("GuiObject") then
			defaults.BackgroundTransparency = guiObject.BackgroundTransparency
		end

		if guiObject:IsA("TextLabel") or guiObject:IsA("TextButton") then
			defaults.Text = guiObject.Text
			defaults.TextTransparency = guiObject.TextTransparency
		end

		if guiObject:IsA("ImageLabel") then
			defaults.ImageTransparency = guiObject.ImageTransparency
		end

		if guiObject:IsA("TextButton") then
			defaults.Position = guiObject.Position
		end

		tutorialGuiDefaults[guiObject] = defaults
	end

	local function getTutorialButtonFromContainer(container)
		if not container then
			return nil
		end

		return container:FindFirstChildWhichIsA("TextButton")
	end

	local function isTutorialButtonContainer(guiObject)
		return guiObject
			and guiObject:IsA("Frame")
			and getTutorialButtonFromContainer(guiObject) ~= nil
	end

	local function prepareTutorialButtonContainer(container)
		rememberTutorialDefaults(container)

		local button = getTutorialButtonFromContainer(container)
		if button then
			rememberTutorialDefaults(button)

			button.Visible = false
			button.Active = false
			button.AutoButtonColor = false
			button.BackgroundTransparency = 1
			button.TextTransparency = 1
			button.Position = TUTORIAL_BUTTON_UP_POSITION
		end

		container.Visible = false
		container.BackgroundTransparency = 1
	end

	local function prepareTutorialElement(element)
		rememberTutorialDefaults(element)

		if element:IsA("TextLabel") then
			element.Visible = false
			element.Text = ""
			element.TextTransparency = tutorialGuiDefaults[element].TextTransparency or 0
			return
		end

		if element:IsA("ImageLabel") then
			element.Visible = false
			element.ImageTransparency = 1
			return
		end

		if isTutorialButtonContainer(element) then
			prepareTutorialButtonContainer(element)
			return
		end
	end

	local function prepareTutorialPage(pageFrame)
		pageFrame.Visible = false

		for _, child in ipairs(pageFrame:GetChildren()) do
			prepareTutorialElement(child)
		end
	end

	local function prepareAllTutorialPages()
		UI.TutorialFrames.Visible = false

		for _, child in ipairs(UI.TutorialFrames:GetChildren()) do
			if child:IsA("Frame") then
				prepareTutorialPage(child)
			end
		end
	end

	local function currentTutorialSequenceIs(seqId)
		return STATE.tutorialActive and STATE.tutorialSequenceId == seqId
	end

	local function playTutorialTextLabel(label, seqId)
		local defaults = tutorialGuiDefaults[label]
		local fullText = defaults and defaults.Text or ""

		label.Visible = true
		label.TextTransparency = defaults and defaults.TextTransparency or 0
		label.Text = ""

		if fullText == "" then
			return currentTutorialSequenceIs(seqId)
		end

		local charDelay = TUTORIAL_TEXT_TOTAL_TIME / math.max(#fullText, 1)

		for i = 1, #fullText do
			if not currentTutorialSequenceIs(seqId) then
				return false
			end

			label.Text = string.sub(fullText, 1, i)
			task.wait(charDelay)
		end

		return currentTutorialSequenceIs(seqId)
	end

	local function playTutorialImage(imageLabel, seqId)
		local defaults = tutorialGuiDefaults[imageLabel]

		imageLabel.Visible = true
		imageLabel.ImageTransparency = 1

		tween(imageLabel, TUTORIAL_FADE_TIME, {
			ImageTransparency = defaults and defaults.ImageTransparency or 0
		})

		task.wait(TUTORIAL_FADE_TIME)
		return currentTutorialSequenceIs(seqId)
	end

	local function playTutorialButtonContainer(container, seqId)
		local containerDefaults = tutorialGuiDefaults[container]
		local button = getTutorialButtonFromContainer(container)
		local buttonDefaults = button and tutorialGuiDefaults[button] or nil

		container.Visible = true
		container.BackgroundTransparency = 1

		if button then
			button.Visible = true
			button.Active = false
			button.AutoButtonColor = false
			button.BackgroundTransparency = 1
			button.TextTransparency = 1
			button.Position = TUTORIAL_BUTTON_UP_POSITION
		end

		tween(container, TUTORIAL_FADE_TIME, {
			BackgroundTransparency = containerDefaults and containerDefaults.BackgroundTransparency or 0
		})

		if button then
			tween(button, TUTORIAL_FADE_TIME, {
				BackgroundTransparency = buttonDefaults and buttonDefaults.BackgroundTransparency or 0,
				TextTransparency = buttonDefaults and buttonDefaults.TextTransparency or 0,
			})
		end

		task.wait(TUTORIAL_FADE_TIME)

		if button and currentTutorialSequenceIs(seqId) then
			button.Active = true
		end

		return currentTutorialSequenceIs(seqId)
	end

	local function playTutorialElement(element, seqId)
		if element:IsA("TextLabel") then
			return playTutorialTextLabel(element, seqId)
		end

		if element:IsA("ImageLabel") then
			return playTutorialImage(element, seqId)
		end

		if isTutorialButtonContainer(element) then
			return playTutorialButtonContainer(element, seqId)
		end

		return currentTutorialSequenceIs(seqId)
	end

	local function hideAllTutorialFrames()
		prepareAllTutorialPages()
		UI.TutorialFrames.Visible = false
	end

	local function showTutorialPage(pageKey)
		local pageData = tutorialPages[pageKey]
		if not pageData then
			return
		end

		STATE.tutorialSequenceId += 1
		local seqId = STATE.tutorialSequenceId

		STATE.tutorialReadyForInput = false
		STATE.tutorialPageKey = pageKey

		hideAllTutorialFrames()

		UI.TutorialFrames.Visible = true
		pageData.Frame.Visible = true

		for i = 1, #pageData.Sequence do
			if not playTutorialElement(pageData.Sequence[i], seqId) then
				return
			end
		end

		if currentTutorialSequenceIs(seqId) then
			STATE.tutorialReadyForInput = true
		end
	end

	local function continueNormalBootFlow()
		STATE.tutorialActive = false
		STATE.tutorialReadyForInput = false
		STATE.tutorialPageKey = nil
		STATE.tutorialSequenceId += 1

		hideAllTutorialFrames()

		if STATE.executorIntroEnabled then
			task.spawn(playWelcomeSequence)
		else
			STATE.WelcomeFinished = true
		end
	end

	function saveTutorialProgress(completed)
		STATE.tutorialCompleted = completed == true

		if not writefile then
			return false
		end

		local ok, encoded = pcall(function()
			return HttpService:JSONEncode({
				completed = STATE.tutorialCompleted
			})
		end)

		if not ok or not encoded then
			return false
		end

		return pcall(writefile, TUTORIAL_FILE, encoded)
	end

	function loadTutorialProgress()
		STATE.tutorialCompleted = false

		if not readfile or not isfile or not isfile(TUTORIAL_FILE) then
			return false
		end

		local ok, raw = pcall(readfile, TUTORIAL_FILE)
		if not ok or not raw then
			return false
		end

		local ok2, decoded = pcall(function()
			return HttpService:JSONDecode(raw)
		end)

		if not ok2 or type(decoded) ~= "table" then
			return false
		end

		STATE.tutorialCompleted = decoded.completed == true
		return STATE.tutorialCompleted
	end

	local function finishTutorial(markCompleted)
		if markCompleted then
			saveTutorialProgress(true)
		end

		continueNormalBootFlow()
	end

	local function goToTutorialPageAfterDelay(nextPageKey)
		STATE.tutorialReadyForInput = false

		task.delay(TUTORIAL_PAGE_DELAY, function()
			if not STATE.tutorialActive then
				return
			end

			showTutorialPage(nextPageKey)
		end)
	end

	local function connectTutorialButtonPressAnimations(button)
		button.AutoButtonColor = false
		button.Position = TUTORIAL_BUTTON_UP_POSITION

		button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				tween(button, TUTORIAL_BUTTON_PRESS_TIME, {
					Position = TUTORIAL_BUTTON_DOWN_POSITION
				})
			end
		end)

		button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				tween(button, TUTORIAL_BUTTON_PRESS_TIME, {
					Position = TUTORIAL_BUTTON_UP_POSITION
				})
			end
		end)

		button.MouseButton1Click:Connect(function()
			task.defer(function()
				if button and button.Parent then
					tween(button, TUTORIAL_BUTTON_PRESS_TIME, {
						Position = TUTORIAL_BUTTON_UP_POSITION
					})
				end
			end)
		end)
	end

	local function connectAllTutorialButtonPressAnimations()
		for _, descendant in ipairs(UI.TutorialFrames:GetDescendants()) do
			if descendant:IsA("TextButton") then
				connectTutorialButtonPressAnimations(descendant)
			end
		end
	end

	local function connectTutorialNavigation()
		UI.Tutorial0YesButton.MouseButton1Click:Connect(function()
			if not STATE.tutorialActive or not STATE.tutorialReadyForInput or STATE.tutorialPageKey ~= "Tutorial0" then
				return
			end

			goToTutorialPageAfterDelay("Tutorial1")
		end)

		UI.Tutorial0NoButton.MouseButton1Click:Connect(function()
			if not STATE.tutorialActive or not STATE.tutorialReadyForInput or STATE.tutorialPageKey ~= "Tutorial0" then
				return
			end

			STATE.tutorialReadyForInput = false

			task.delay(TUTORIAL_PAGE_DELAY, function()
				finishTutorial(true)
			end)
		end)

		UI.Tutorial1NextButton.MouseButton1Click:Connect(function()
			if not STATE.tutorialActive or not STATE.tutorialReadyForInput or STATE.tutorialPageKey ~= "Tutorial1" then
				return
			end

			goToTutorialPageAfterDelay("Tutorial2")
		end)

		UI.Tutorial2NextButton.MouseButton1Click:Connect(function()
			if not STATE.tutorialActive or not STATE.tutorialReadyForInput or STATE.tutorialPageKey ~= "Tutorial2" then
				return
			end

			goToTutorialPageAfterDelay("Tutorial3")
		end)

		UI.Tutorial3NextButton.MouseButton1Click:Connect(function()
			if not STATE.tutorialActive or not STATE.tutorialReadyForInput or STATE.tutorialPageKey ~= "Tutorial3" then
				return
			end

			goToTutorialPageAfterDelay("Tutorial4")
		end)

		UI.Tutorial4NextButton.MouseButton1Click:Connect(function()
			if not STATE.tutorialActive or not STATE.tutorialReadyForInput or STATE.tutorialPageKey ~= "Tutorial4" then
				return
			end

			goToTutorialPageAfterDelay("Tutorial5")
		end)

		UI.Tutorial5NextButton.MouseButton1Click:Connect(function()
			if not STATE.tutorialActive or not STATE.tutorialReadyForInput or STATE.tutorialPageKey ~= "Tutorial5" then
				return
			end

			STATE.tutorialReadyForInput = false

			task.delay(TUTORIAL_PAGE_DELAY, function()
				finishTutorial(true)
			end)
		end)
	end

	function initializeTutorialSystem()
		if tutorialInitialized then
			return
		end

		for _, descendant in ipairs(UI.TutorialFrames:GetDescendants()) do
			if descendant:IsA("GuiObject") then
				rememberTutorialDefaults(descendant)
			end
		end

		if tutorialGuiDefaults[UI.Tutorial5NextButton] then
			tutorialGuiDefaults[UI.Tutorial5NextButton].Text = "FINISH THE TUTORIAL"
		end
		UI.Tutorial5NextButton.Text = "FINISH THE TUTORIAL"

		tutorialPages = {
			Tutorial0 = {
				Frame = UI.Tutorial0,
				Sequence = {
					UI.Tutorial0_1,
					UI.Tutorial0_2,
					UI.Tutorial0Yes,
					UI.Tutorial0No,
				},
			},
			Tutorial1 = {
				Frame = UI.Tutorial1,
				Sequence = {
					UI.Tutorial1_1,
					UI.Tutorial1_2,
					UI.Tutorial1_3,
					UI.Tutorial1_4,
					UI.Tutorial1Next,
				},
			},
			Tutorial2 = {
				Frame = UI.Tutorial2,
				Sequence = {
					UI.Tutorial2_1,
					UI.Tutorial2_2,
					UI.Tutorial2_3,
					UI.Tutorial2Next,
				},
			},
			Tutorial3 = {
				Frame = UI.Tutorial3,
				Sequence = {
					UI.Tutorial3_1,
					UI.Tutorial3_3,
					UI.Tutorial3_4,
					UI.Tutorial3_5,
					UI.Tutorial3_6,
					UI.Tutorial3_7,
					UI.Tutorial3_8,
					UI.Tutorial3_9,
					UI.Tutorial3_10,
					UI.Tutorial3Next,
				},
			},
			Tutorial4 = {
				Frame = UI.Tutorial4,
				Sequence = {
					UI.Tutorial4_1,
					UI.Tutorial4_2,
					UI.Tutorial4_3,
					UI.Tutorial4_4,
					UI.Tutorial4_5,
					UI.Tutorial4_6,
					UI.Tutorial4_7,
					UI.Tutorial4_8,
					UI.Tutorial4_9,
					UI.Tutorial4_10,
					UI.Tutorial4_11,
					UI.Tutorial4_12,
					UI.Tutorial4_13,
					UI.Tutorial4_14,
					UI.Tutorial4Next,
				},
			},
			Tutorial5 = {
				Frame = UI.Tutorial5,
				Sequence = {
					UI.Tutorial5_1,
					UI.Tutorial5_2,
					UI.Tutorial5Next,
				},
			},
		}

		prepareAllTutorialPages()
		connectAllTutorialButtonPressAnimations()
		connectTutorialNavigation()

		tutorialInitialized = true
	end

	function beginStartupIntroFlow()
		initializeTutorialSystem()

		if STATE.executorIntroEnabled and not STATE.tutorialCompleted then
			STATE.WelcomeFinished = false
			STATE.tutorialActive = true
			showTutorialPage("Tutorial0")
			return
		end

		STATE.tutorialActive = false

		if STATE.executorIntroEnabled then
			task.spawn(playWelcomeSequence)
		else
			STATE.WelcomeFinished = true
		end
	end
end


--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- INPUT HANDLING
--////////////////////////////////////////////////////

STATE.inputTextConnection = UI.CommandInput:GetPropertyChangedSignal("Text"):Connect(function()
	if STATE.menuOpen then
		sanitizeCommandInput()
		updateSuggestions()
	end
end)

STATE.inputFocusLostConnection = UI.CommandInput.FocusLost:Connect(function(enterPressed)
	if enterPressed and STATE.menuOpen then
		executeCommand(UI.CommandInput.Text)
		return
	end

	if STATE.menuOpen and not STATE.suppressRefocus then
		task.defer(function()
			if STATE.menuOpen then
				UI.CommandInput:CaptureFocus()
			end
		end)
	end
end)

STATE.inputBeganConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
	local currentCmdrPrefixKey = STATE.cmdrPrefixKey or Enum.KeyCode.Semicolon

	if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentCmdrPrefixKey then
		if not STATE.WelcomeFinished then
			return
		end

		local focusedBox = UserInputService:GetFocusedTextBox()

		if focusedBox and focusedBox ~= UI.CommandInput then
			return
		end

		if STATE.menuOpen then
			STATE.suppressRefocus = true

			if UI.CommandInput then
				pcall(function()
					UI.CommandInput:ReleaseFocus(false)
				end)
			end

			task.defer(function()
				closeMenu()
			end)
		else
			openMenu()
		end

		task.defer(function()
			if UI.CommandInput then
				UI.CommandInput.Text = ""
				UI.CommandInput.CursorPosition = #UI.CommandInput.Text + 1
			end

			sanitizeCommandInput()
			updateSuggestions()
		end)

		return
	end

	if STATE.menuOpen and input.KeyCode == Enum.KeyCode.Tab and UI.CommandInput:IsFocused() then
		local best = STATE.currentBestMatch
		if best then
			UI.CommandInput.Text = TAB_FILL_COMMANDS[best.Name] or best.Name
			UI.CommandInput.CursorPosition = #UI.CommandInput.Text + 1
			UI.CommandInput:CaptureFocus()
			updateSuggestions()
		end
		return
	end

	if STATE.tutorialActive then
		return
	end

	if gameProcessed then
		return
	end

	if not UI.CommandInput:IsFocused() then
		if STATE.clickTeleportActive and input.UserInputType == Enum.UserInputType.MouseButton1 then
			if STATE.clickTeleportKey and UserInputService:IsKeyDown(STATE.clickTeleportKey) then
				performClickTeleport()
			end
			return
		end

		if STATE.clickDeleteActive and input.UserInputType == Enum.UserInputType.MouseButton1 then
			if STATE.clickDeleteKey and UserInputService:IsKeyDown(STATE.clickDeleteKey) then
				performClickDelete()
			end
			return
		end

		local key = input.KeyCode

		local hold = STATE.holdBinds[key]
		if hold then
			if not STATE.activeHoldBinds[key] then
				STATE.activeHoldBinds[key] = true
				executeCommand(hold.onCommand)
			end
			return
		end

		local toggle = STATE.toggleBinds[key]
		if toggle then
			if toggle.state then
				executeCommand(toggle.offCommand)
				toggle.state = false
			else
				executeCommand(toggle.onCommand)
				toggle.state = true
			end
			return
		end

		local ghost = STATE.ghostBinds[key]
		if ghost then
			if ghost == "clickteleport" then
				startClickTeleport(key)
			elseif ghost == "clickdelete" then
				startClickDelete(key)
			end
			return
		end

		local boundCommands = STATE.keybinds[key]
		if boundCommands then
			for _, cmd in ipairs(boundCommands) do
				executeCommand(cmd)
			end
			return
		end
	end
end)


STATE.inputEndedConnection = UserInputService.InputEnded:Connect(function(input)
	if STATE.tutorialActive then
		return
	end

	local key = input.KeyCode

	if STATE.activeHoldBinds[key] then
		STATE.activeHoldBinds[key] = nil

		local hold = STATE.holdBinds[key]
		if hold and hold.offCommand then
			executeCommand(hold.offCommand)
		end
	end

	if key == STATE.clickTeleportKey then
		stopClickTeleport()
	end

	if key == STATE.clickDeleteKey then
		stopClickDelete()
	end
end)

--////////////////////////////////////////////////////
-- TPWALK SYSTEM
--////////////////////////////////////////////////////

function startTpWalk(multiplier)
	if STATE.tpWalkConnection then
		STATE.tpWalkConnection:Disconnect()
		STATE.tpWalkConnection = nil
	end

	STATE.tpWalkEnabled = true

	STATE.tpWalkConnection = game:GetService("RunService").RenderStepped:Connect(function(dt)
		if not STATE.tpWalkEnabled then
			return
		end

		local character = LocalPlayer.Character
		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local rootPart = character:FindFirstChild("HumanoidRootPart")

		if not humanoid or not rootPart or humanoid.Health <= 0 then
			return
		end

		local moveDirection = humanoid.MoveDirection
		if moveDirection.Magnitude <= 0 then
			return
		end

		character:PivotTo(character:GetPivot() + moveDirection.Unit * humanoid.WalkSpeed * multiplier * dt)
	end)
end

function stopTpWalk()
	STATE.tpWalkEnabled = false

	if STATE.tpWalkConnection then
		STATE.tpWalkConnection:Disconnect()
		STATE.tpWalkConnection = nil
	end
end


--////////////////////////////////////////////////////
-- NAMETAG / HITBOX SYSTEM
--////////////////////////////////////////////////////

STATE.nametagData = STATE.nametagData or {
	PlayerHPColors = {},
	PlayerHitboxes = {},
	ColorHigh = Color3.fromHex("#6eff69"),
	ColorMed = Color3.fromHex("#ff984a"),
	ColorLow = Color3.fromHex("#ff6254"),
	SmoothSpeed = 5,
}

local function getNametagData()
	return STATE.nametagData
end

local function getNametagHealthColor(health, maxHealth)
	local data = getNametagData()
	local pct = health / maxHealth

	if pct > 0.75 then
		return data.ColorHigh
	elseif pct > 0.5 then
		return data.ColorMed
	end

	return data.ColorLow
end

local function lerpNametagColor(c1, c2, a)
	return Color3.new(
		c1.R + (c2.R - c1.R) * a,
		c1.G + (c2.G - c1.G) * a,
		c1.B + (c2.B - c1.B) * a
	)
end


--

--


local function createNametagBillboard(character)
	local head = character:FindFirstChild("Head")
	if not head then
		return nil
	end

	local existing = head:FindFirstChild("PlayerBillboardGui")
	if existing then
		existing:Destroy()
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "PlayerBillboardGui"
	billboard.Adornee = head
	billboard.Size = UDim2.new(0, 400, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	textLabel.TextStrokeTransparency = 0
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 14
	textLabel.RichText = true
	textLabel.Text = "LOADING..."
	textLabel.Parent = billboard

	billboard.Parent = head
	return textLabel
end

local function setNametagHitboxVisibility(character, isVisible)
	local adornments = getNametagData().PlayerHitboxes[character]
	if not adornments then
		return
	end

	for i = 1, #adornments do
		local adorn = adornments[i]
		if adorn and adorn.Parent then
			adorn.Visible = isVisible
		end
	end
end

local function ensureNametagHitbox(character)
	local data = getNametagData()
	if data.PlayerHitboxes[character] then
		return
	end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then
		return
	end

	data.PlayerHitboxes[character] = {}

	local box = Instance.new("BoxHandleAdornment")
	box.Adornee = root
	box.AlwaysOnTop = true
	box.ZIndex = 10
	box.Size = root.Size
	box.Transparency = STATE.hitboxTransparency
	box.Color3 = root.Color
	box.Visible = true
	box.Parent = root

	data.PlayerHitboxes[character][1] = box
end

local function updateNametagPlayer(player, localRoot, dt)
	if player == LocalPlayer then
		return
	end

	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local head = character and character:FindFirstChild("Head")

	if not character or not humanoid or not head then
		return
	end

	local distance = (head.Position - localRoot.Position).Magnitude
	local billboard = head:FindFirstChild("PlayerBillboardGui")
	local textLabel = billboard and billboard:FindFirstChildOfClass("TextLabel")

	ensureNametagHitbox(character)

	if distance > STATE.nametagRenderDistance then
		if billboard then
			billboard.Enabled = false
		end
		setNametagHitboxVisibility(character, false)
		return
	end

	if not textLabel then
		textLabel = createNametagBillboard(character)
		billboard = head:FindFirstChild("PlayerBillboardGui")
		getNametagData().PlayerHPColors[player] = getNametagData().ColorHigh
	end

	if billboard then
		billboard.Enabled = true
	end

	setNametagHitboxVisibility(character, true)

	if humanoid.Health <= 0 then
		if textLabel then
			textLabel.Text = player.Name .. " - DEAD"
		end
		setNametagHitboxVisibility(character, false)
		return
	end

	local data = getNametagData()
	local currentColor = lerpNametagColor(
		data.PlayerHPColors[player] or data.ColorHigh,
		getNametagHealthColor(humanoid.Health, humanoid.MaxHealth),
		math.clamp(data.SmoothSpeed * dt, 0, 1)
	)
	data.PlayerHPColors[player] = currentColor

	local teamColor = player.TeamColor.Color
	local teamColorHex = string.format(
		"#%02x%02x%02x",
		math.floor(teamColor.R * 255),
		math.floor(teamColor.G * 255),
		math.floor(teamColor.B * 255)
	)

	if textLabel then
		textLabel.Text = string.format(
			"<font color=\"%s\">%s</font> - %.1f M - <font color=\"#%02x%02x%02x\">%d HP</font>",
			teamColorHex,
			player.Name,
			distance,
			math.floor(currentColor.R * 255),
			math.floor(currentColor.G * 255),
			math.floor(currentColor.B * 255),
			math.floor(humanoid.Health)
		)
	end

	local adornments = data.PlayerHitboxes[character]
	if adornments then
		for _, adorn in pairs(adornments) do
			if adorn and adorn.Adornee then
				adorn.Color3 = teamColor
				adorn.Size = adorn.Adornee.Size
				adorn.Transparency = STATE.hitboxTransparency
			end
		end
	end
end

function startNametagSystem(renderDistance)
	STATE.nametagRenderDistance = renderDistance or math.huge

	if STATE.nametagSystemEnabled then
		return
	end

	STATE.nametagSystemEnabled = true

	local accumulator = 0
	local renderConn = RunService.RenderStepped:Connect(function(dt)
		if not STATE.nametagSystemEnabled then
			return
		end

		accumulator += dt
		if accumulator < CONFIG.NAMETAG_REFRESH_RATE then
			return
		end

		local stepDt = accumulator
		accumulator = 0

		local localCharacter = LocalPlayer.Character
		local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
		if not localRoot then
			return
		end

		for _, player in ipairs(Players:GetPlayers()) do
			updateNametagPlayer(player, localRoot, stepDt)
		end
	end)

	STATE.nametagConnections[#STATE.nametagConnections + 1] = renderConn
end

function stopNametagSystem()
	if not STATE.nametagSystemEnabled then
		return
	end

	STATE.nametagSystemEnabled = false
	disconnectArrayConnections(STATE.nametagConnections)

	local data = getNametagData()
	table.clear(data.PlayerHPColors)

	for character, adornments in pairs(data.PlayerHitboxes) do
		if character and character.Parent then
			for _, adorn in pairs(adornments) do
				if adorn then
					adorn:Destroy()
				end
			end
		end
		data.PlayerHitboxes[character] = nil
	end

	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		if character then
			local head = character:FindFirstChild("Head")
			if head then
				local gui = head:FindFirstChild("PlayerBillboardGui")
				if gui then
					gui:Destroy()
				end
			end
		end
	end
end

--////////////////////////////////////////////////////
-- GLOBAL PLAYER TRACKING SYSTEM
--////////////////////////////////////////////////////

local function onCharacterSpawn(player, character)
	task.wait()

	if STATE.hitboxSystemEnabled then
		refreshHitboxForPlayer(player)
		applyStoredHitboxTransparency(player)
	end

	if STATE.highlightAllEnabled then
		applyHighlightToCharacter(player, character)
	end
end

local function trackPlayer(player)
	if player == LocalPlayer then
		return
	end

	if STATE.globalCharacterConnections[player] then
		STATE.globalCharacterConnections[player]:Disconnect()
		STATE.globalCharacterConnections[player] = nil
	end

	STATE.globalCharacterConnections[player] = player.CharacterAdded:Connect(function(character)
		onCharacterSpawn(player, character)
	end)

	if player.Character then
		onCharacterSpawn(player, player.Character)
	end
end

local function startGlobalPlayerTracking()
	for _, player in ipairs(Players:GetPlayers()) do
		trackPlayer(player)
	end

	if not STATE.globalTrackPlayerAddedConnection then
		STATE.globalTrackPlayerAddedConnection = Players.PlayerAdded:Connect(trackPlayer)
	end
end

--////////////////////////////////////////////////////
-- DEATH TELEPORT TRACKING SYSTEM
--////////////////////////////////////////////////////

do
	local function disconnectDeathTrackerConnections()
		if STATE.deathTrackerCharacterConnection then
			STATE.deathTrackerCharacterConnection:Disconnect()
			STATE.deathTrackerCharacterConnection = nil
		end

		if STATE.deathTrackerDiedConnection then
			STATE.deathTrackerDiedConnection:Disconnect()
			STATE.deathTrackerDiedConnection = nil
		end
	end

	local function captureDeathPositionFromCharacter(character)
		if not character then
			return
		end

		local root = character:FindFirstChild("HumanoidRootPart")
		if not root then
			return
		end

		STATE.lastDeathCFrame = root.CFrame
	end

	local function hookDeathTrackerCharacter(character)
		if STATE.deathTrackerDiedConnection then
			STATE.deathTrackerDiedConnection:Disconnect()
			STATE.deathTrackerDiedConnection = nil
		end

		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		STATE.deathTrackerDiedConnection = humanoid.Died:Connect(function()
			captureDeathPositionFromCharacter(character)
		end)
	end

	function startDeathTracker()
		disconnectDeathTrackerConnections()

		if LocalPlayer.Character then
			hookDeathTrackerCharacter(LocalPlayer.Character)
		end

		STATE.deathTrackerCharacterConnection = LocalPlayer.CharacterAdded:Connect(function(character)
			task.wait()
			hookDeathTrackerCharacter(character)
		end)
	end

	function stopDeathTracker()
		disconnectDeathTrackerConnections()
	end

	function teleportToLastDeathPosition()
		if not STATE.lastDeathCFrame then
			return false, "No death position has been recorded yet"
		end

		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")

		if not character or not humanoid or not root or humanoid.Health <= 0 then
			return false, "Character is not ready"
		end

		root.CFrame = STATE.lastDeathCFrame + Vector3.new(0, 3, 0)
		return true
	end
end


--////////////////////////////////////////////////////
-- CLICK TELEPORT SYSTEM (GHOST COMMAND)
--////////////////////////////////////////////////////

function performClickTeleport()
	local character = LocalPlayer.Character
	if not character then
		return
	end

	local root = character:FindFirstChild("HumanoidRootPart")
	local camera = workspace.CurrentCamera
	local mouse = LocalPlayer:GetMouse()

	if not root or not camera then
		return
	end

	local ray = camera:ScreenPointToRay(mouse.X, mouse.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {character}

	local result = workspace:Raycast(
		ray.Origin,
		ray.Direction.Unit * CONFIG.CLICKTP_MAX_DISTANCE,
		params
	)
	if not result then
		return
	end

	local pos = result.Position
	if pos.Y < CONFIG.CLICKTP_MIN_Y then
		print("[FAIL] Teleport blocked (void protection)")
		return
	end

	root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
end

function startClickTeleport(keyCode)
	STATE.clickTeleportKey = keyCode
	STATE.clickTeleportActive = true
end

function stopClickTeleport()
	STATE.clickTeleportActive = false
end

-- CLICK DELETE SYSTEM (GHOST COMMAND)
--////////////////////////////////////////////////////

function performClickDelete()
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	local mouse = LocalPlayer:GetMouse()
	local ray = camera:ScreenPointToRay(mouse.X, mouse.Y)

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { LocalPlayer.Character }

	local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
	if not result then
		return
	end

	local target = result.Instance
	if not target or not target.Parent then
		return
	end

	if not target:IsDescendantOf(workspace) then
		print("[FAIL] Target is not inside workspace")
		return
	end

	if LocalPlayer.Character and target:IsDescendantOf(LocalPlayer.Character) then
		print("[FAIL] Refused to delete your own character part")
		return
	end

	local deletedName = target.Name
	local ok, err = pcall(function()
		target:Destroy()
	end)

	if ok then
		print("[SUCCESS] Deleted:", deletedName)
	else
		print("[FAIL] Could not delete:", deletedName, "-", tostring(err))
	end
end

function startClickDelete(keyCode)
	STATE.clickDeleteKey = keyCode
	STATE.clickDeleteActive = true
end

function stopClickDelete()
	STATE.clickDeleteActive = false
end

do
	local DEFAULT_CMDR_THEME_COLOR = Color3.fromRGB(202, 177, 53)

	STATE.cmdrThemeColor = STATE.cmdrThemeColor or DEFAULT_CMDR_THEME_COLOR

	local function color3ToRgb255(color)
		return
			math.floor(color.R * 255 + 0.5),
		math.floor(color.G * 255 + 0.5),
		math.floor(color.B * 255 + 0.5)
	end

	local function colorsEqual(a, b)
		if not a or not b then
			return false
		end

		local ar, ag, ab = color3ToRgb255(a)
		local br, bg, bb = color3ToRgb255(b)

		return ar == br and ag == bg and ab == bb
	end

	local function escapePattern(text)
		return tostring(text):gsub("(%W)", "%%%1")
	end

	function getCmdrThemeColor()
		return STATE.cmdrThemeColor or DEFAULT_CMDR_THEME_COLOR
	end

	function colorToCmdrThemeRgbString(color)
		local r, g, b = color3ToRgb255(color)
		return string.format("rgb(%d,%d,%d)", r, g, b)
	end

	function colorToCmdrThemeHexString(color)
		local r, g, b = color3ToRgb255(color)
		return string.format("#%02x%02x%02x", r, g, b)
	end

	local function replaceThemeColorInRichText(text, fromColor, toColor)
		text = tostring(text or "")

		local fromRgb = colorToCmdrThemeRgbString(fromColor)
		local toRgb = colorToCmdrThemeRgbString(toColor)

		local fromHexLower = colorToCmdrThemeHexString(fromColor)
		local toHexLower = colorToCmdrThemeHexString(toColor)

		local fromHexUpper = string.upper(fromHexLower)
		local toHexUpper = string.upper(toHexLower)

		text = text:gsub(escapePattern(fromRgb), toRgb)
		text = text:gsub(escapePattern(fromHexLower), toHexLower)
		text = text:gsub(escapePattern(fromHexUpper), toHexUpper)

		return text
	end

	function parseCmdrThemeColor(...)
		local raw = trimString(table.concat({...}, " "))
		raw = raw:gsub('^"(.*)"$', "%1")
		raw = raw:gsub("^'(.*)'$", "%1")

		if raw == "" then
			return nil, "Usage: cmdrtheme {r, g, b} or cmdrtheme {#rrggbb}"
		end

		local hex = raw:match("^#([%x][%x][%x][%x][%x][%x])$")
		if hex then
			local r = tonumber(hex:sub(1, 2), 16)
			local g = tonumber(hex:sub(3, 4), 16)
			local b = tonumber(hex:sub(5, 6), 16)
			return Color3.fromRGB(r, g, b)
		end

		local compact = raw:gsub("%s+", "")
		local rText, gText, bText = compact:match("^(%d+),(%d+),(%d+)$")
		if rText and gText and bText then
			local r = tonumber(rText)
			local g = tonumber(gText)
			local b = tonumber(bText)

			if not r or not g or not b then
				return nil, "Invalid color format"
			end

			if r < 0 or r > 255 or g < 0 or g > 255 or b < 0 or b > 255 then
				return nil, "RGB values must be between 0 and 255"
			end

			return Color3.fromRGB(r, g, b)
		end

		return nil, "Invalid color format. Use: 28, 29, 34 or #1c1d22"
	end

	function applyCmdrThemeColor(newColor)
		newColor = newColor or DEFAULT_CMDR_THEME_COLOR

		local oldColor = STATE.cmdrThemeColor or DEFAULT_CMDR_THEME_COLOR
		STATE.cmdrThemeColor = newColor

		if not commandExecutor then
			return
		end

		for _, descendant in ipairs(commandExecutor:GetDescendants()) do
			if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
				if colorsEqual(descendant.TextColor3, oldColor) or colorsEqual(descendant.TextColor3, DEFAULT_CMDR_THEME_COLOR) then
					descendant.TextColor3 = newColor
				end

				if descendant.RichText and type(descendant.Text) == "string" and descendant.Text ~= "" then
					local updated = descendant.Text
					updated = replaceThemeColorInRichText(updated, oldColor, newColor)

					if not colorsEqual(oldColor, DEFAULT_CMDR_THEME_COLOR) then
						updated = replaceThemeColorInRichText(updated, DEFAULT_CMDR_THEME_COLOR, newColor)
					end

					descendant.Text = updated
				end
			end
		end
	end

	do
		local themedPrintHelpers = {}
		local themedPrintHelperCounter = 0

		function createPrintHelper(text, shouldFade)
			themedPrintHelperCounter += 1

			local entry = UI.ExampleHelperTemplate:Clone()
			entry.Name = "PrintHelper_" .. themedPrintHelperCounter
			entry.Visible = true
			entry.Parent = UI.HelperScrollingFrame
			entry.Size = UDim2.new(1, 0, 0, 28)
			entry.BackgroundTransparency = 0.3

			local label = entry:FindFirstChild("CommandLine")
			if label then
				label.RichText = true
				label.Text = string.format(
					"<font color=\"%s\">[EXEC]</font> <font color=\"rgb(227,227,227)\">%s</font>",
					colorToCmdrThemeRgbString(getCmdrThemeColor()),
					tostring(text)
				)
			end

			UI.HelperBG.Visible = true
			themedPrintHelpers[themedPrintHelperCounter] = entry

			if shouldFade ~= false then
				local helperId = themedPrintHelperCounter
				task.spawn(function()
					task.wait(5)

					local helperEntry = themedPrintHelpers[helperId]
					if helperEntry and helperEntry.Parent then
						local fadeTween = TweenService:Create(
							helperEntry,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundTransparency = 1}
						)
						fadeTween:Play()
						fadeTween.Completed:Wait()

						helperEntry = themedPrintHelpers[helperId]
						if helperEntry and helperEntry.Parent then
							helperEntry:Destroy()
						end
					end

					themedPrintHelpers[helperId] = nil
				end)
			end

			return themedPrintHelperCounter
		end

		function clearActivePrintHelpers()
			for helperId, helperEntry in pairs(themedPrintHelpers) do
				if helperEntry and helperEntry.Parent then
					helperEntry:Destroy()
				end
				themedPrintHelpers[helperId] = nil
			end
		end
	end

	function buildHelpEntryText(commandName, commandDescription)
		return string.format(
			"<font color=\"%s\">%s :</font> <font color=\"rgb(227,227,227)\">%s</font>",
			colorToCmdrThemeRgbString(getCmdrThemeColor()),
			commandName,
			commandDescription
		)
	end

	function populatePlayerInfo(targetPlayer)
		prepareDisplayListMode()

		local function createLine(label, value)
			local entry = UI.ExampleHelperTemplate:Clone()
			entry.Visible = true
			entry.Parent = UI.HelperScrollingFrame
			entry.Size = UDim2.new(1, 0, 0, 28)

			local text = entry:FindFirstChild("CommandLine")
			if text then
				text.RichText = true
				text.Text = string.format(
					"<font color=\"%s\">%s :</font> <font color=\"rgb(227,227,227)\">%s</font>",
					colorToCmdrThemeRgbString(getCmdrThemeColor()),
					label,
					tostring(value)
				)
			end
		end

		createLine("Display Name", targetPlayer.DisplayName)
		createLine("Username", targetPlayer.Name)
		createLine("UserId", targetPlayer.UserId)
		createLine("Join Date", os.date("%Y-%m-%d", os.time() - targetPlayer.AccountAge * 86400))
		createLine("Team", targetPlayer.Team and targetPlayer.Team.Name or "None")

		local character = targetPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local root = character:FindFirstChild("HumanoidRootPart")

			createLine("Health", humanoid and math.floor(humanoid.Health) or "Unknown")

			local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if root and localRoot then
				createLine("Distance", string.format("%.1f studs", (root.Position - localRoot.Position).Magnitude))
			end
		end

		UI.HelperBG.Visible = true
		print("[SUCCESS] Player info displayed")
	end

	do
		local originalLoadBindsWithTheme = loadBinds
		local originalSaveBindsWithTheme = saveBinds

		function loadBinds()
			local result = false

			if originalLoadBindsWithTheme then
				result = originalLoadBindsWithTheme()
			end

			local themeColor = DEFAULT_CMDR_THEME_COLOR

			if readfile and isfile and isfile(BINDS_FILE) then
				local readOk, raw = pcall(readfile, BINDS_FILE)
				if readOk and raw then
					local decodeOk, data = pcall(HttpService.JSONDecode, HttpService, raw)
					if decodeOk and type(data) == "table" and type(data.settings) == "table" and type(data.settings.cmdrtheme) == "string" then
						local parsedColor = parseCmdrThemeColor(data.settings.cmdrtheme)
						if parsedColor then
							themeColor = parsedColor
						end
					end
				end
			end

			applyCmdrThemeColor(themeColor)
			return result
		end

		function saveBinds()
			local baseResult = false

			if originalSaveBindsWithTheme then
				baseResult = originalSaveBindsWithTheme()
			end

			if not baseResult then
				return false
			end

			if not writefile or not readfile or not isfile then
				return baseResult
			end

			local data = {}

			local readOk, raw = pcall(readfile, BINDS_FILE)
			if readOk and raw and raw ~= "" then
				local decodeOk, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
				if decodeOk and type(decoded) == "table" then
					data = decoded
				end
			end

			data.settings = type(data.settings) == "table" and data.settings or {}
			data.settings.cmdrtheme = colorToCmdrThemeHexString(getCmdrThemeColor())

			local encodeOk, encoded = pcall(HttpService.JSONEncode, HttpService, data)
			if not encodeOk or not encoded then
				return false
			end

			local writeOk = pcall(writefile, BINDS_FILE, encoded)
			return writeOk and true or false
		end
	end
end

do
	local CMDR_FONT_ATTR_NAME = "CmdrOriginalFontName"
	local CMDR_FONT_ATTR_FAMILY = "CmdrOriginalFontFamily"
	local CMDR_FONT_ATTR_WEIGHT = "CmdrOriginalFontWeight"
	local CMDR_FONT_ATTR_STYLE = "CmdrOriginalFontStyle"

	STATE.cmdrFontName = STATE.cmdrFontName or nil
	STATE.cmdrFontTrackingConnection = STATE.cmdrFontTrackingConnection or nil

	local function isCmdrTextObject(instance)
		return instance
			and (
				instance:IsA("TextLabel")
				or instance:IsA("TextButton")
				or instance:IsA("TextBox")
			)
	end

	local function normalizeFontKey(text)
		return string.lower(tostring(text or "")):gsub("[%s%p_]+", "")
	end

	local CMDR_FONT_LOOKUP = {}
	for _, enumFont in ipairs(Enum.Font:GetEnumItems()) do
		CMDR_FONT_LOOKUP[normalizeFontKey(enumFont.Name)] = enumFont
	end

	local function captureOriginalCmdrFont(instance)
		if not isCmdrTextObject(instance) then
			return
		end

		if instance:GetAttribute(CMDR_FONT_ATTR_NAME) == nil then
			pcall(function()
				instance:SetAttribute(CMDR_FONT_ATTR_NAME, instance.Font.Name)
			end)
		end

		local ok, fontFace = pcall(function()
			return instance.FontFace
		end)

		if ok and fontFace then
			if instance:GetAttribute(CMDR_FONT_ATTR_FAMILY) == nil then
				pcall(function()
					instance:SetAttribute(CMDR_FONT_ATTR_FAMILY, fontFace.Family)
				end)
			end

			if instance:GetAttribute(CMDR_FONT_ATTR_WEIGHT) == nil then
				pcall(function()
					instance:SetAttribute(CMDR_FONT_ATTR_WEIGHT, fontFace.Weight.Name)
				end)
			end

			if instance:GetAttribute(CMDR_FONT_ATTR_STYLE) == nil then
				pcall(function()
					instance:SetAttribute(CMDR_FONT_ATTR_STYLE, fontFace.Style.Name)
				end)
			end
		end
	end

	local function applyFontToCmdrObject(instance, fontEnum)
		if not isCmdrTextObject(instance) or not fontEnum then
			return
		end

		captureOriginalCmdrFont(instance)

		pcall(function()
			instance.Font = fontEnum
		end)

		pcall(function()
			instance.FontFace = Font.fromEnum(fontEnum)
		end)
	end

	local function restoreCmdrObjectFont(instance)
		if not isCmdrTextObject(instance) then
			return
		end

		local fontName = instance:GetAttribute(CMDR_FONT_ATTR_NAME)
		local family = instance:GetAttribute(CMDR_FONT_ATTR_FAMILY)
		local weightName = instance:GetAttribute(CMDR_FONT_ATTR_WEIGHT)
		local styleName = instance:GetAttribute(CMDR_FONT_ATTR_STYLE)

		if type(fontName) == "string" and Enum.Font[fontName] then
			pcall(function()
				instance.Font = Enum.Font[fontName]
			end)
		end

		if type(family) == "string"
			and type(weightName) == "string"
			and type(styleName) == "string"
			and Enum.FontWeight[weightName]
			and Enum.FontStyle[styleName]
		then
			pcall(function()
				instance.FontFace = Font.new(
					family,
					Enum.FontWeight[weightName],
					Enum.FontStyle[styleName]
				)
			end)
		end
	end

	function parseCmdrFontName(...)
		local raw = trimString(table.concat({...}, " "))
		raw = raw:gsub('^"(.*)"$', "%1")
		raw = raw:gsub("^'(.*)'$", "%1")

		if raw == "" then
			return nil, "Usage: cmdrfont {font_name}"
		end

		local fontEnum = CMDR_FONT_LOOKUP[normalizeFontKey(raw)]
		if not fontEnum then
			return nil, "Invalid font name: " .. tostring(raw)
		end

		return fontEnum
	end

	function applyCmdrFont(fontEnum)
		if not fontEnum or not commandExecutor then
			return
		end

		STATE.cmdrFontName = fontEnum.Name

		for _, descendant in ipairs(commandExecutor:GetDescendants()) do
			applyFontToCmdrObject(descendant, fontEnum)
		end
	end

	function resetCmdrFont()
		STATE.cmdrFontName = nil

		if not commandExecutor then
			return
		end

		for _, descendant in ipairs(commandExecutor:GetDescendants()) do
			restoreCmdrObjectFont(descendant)
		end
	end

	function initializeCmdrFontSystem()
		if not commandExecutor then
			return
		end

		for _, descendant in ipairs(commandExecutor:GetDescendants()) do
			captureOriginalCmdrFont(descendant)
		end

		if STATE.cmdrFontTrackingConnection then
			STATE.cmdrFontTrackingConnection:Disconnect()
			STATE.cmdrFontTrackingConnection = nil
		end

		STATE.cmdrFontTrackingConnection = commandExecutor.DescendantAdded:Connect(function(descendant)
			if not isCmdrTextObject(descendant) then
				return
			end

			captureOriginalCmdrFont(descendant)

			local activeFont = STATE.cmdrFontName and Enum.Font[STATE.cmdrFontName] or nil
			if activeFont then
				task.defer(function()
					if descendant and descendant.Parent then
						applyFontToCmdrObject(descendant, activeFont)
					end
				end)
			end
		end)
	end

	initializeCmdrFontSystem()

	do
		local previousLoadBinds = loadBinds
		local previousSaveBinds = saveBinds

		function loadBinds()
			local result = false

			if previousLoadBinds then
				result = previousLoadBinds()
			end

			local savedFontEnum = nil

			if readfile and isfile and isfile(BINDS_FILE) then
				local readOk, raw = pcall(readfile, BINDS_FILE)
				if readOk and raw then
					local decodeOk, data = pcall(HttpService.JSONDecode, HttpService, raw)
					if decodeOk and type(data) == "table" and type(data.settings) == "table" then
						local savedFontName = data.settings.cmdrfont
						if type(savedFontName) == "string" and savedFontName ~= "" then
							savedFontEnum = CMDR_FONT_LOOKUP[normalizeFontKey(savedFontName)]
						end
					end
				end
			end

			if savedFontEnum then
				applyCmdrFont(savedFontEnum)
			else
				resetCmdrFont()
			end

			return result
		end

		function saveBinds()
			local baseResult = false

			if previousSaveBinds then
				baseResult = previousSaveBinds()
			end

			if not baseResult then
				return false
			end

			if not writefile or not readfile or not isfile then
				return baseResult
			end

			local data = {}

			local readOk, raw = pcall(readfile, BINDS_FILE)
			if readOk and raw and raw ~= "" then
				local decodeOk, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
				if decodeOk and type(decoded) == "table" then
					data = decoded
				end
			end

			data.settings = type(data.settings) == "table" and data.settings or {}

			if STATE.cmdrFontName and STATE.cmdrFontName ~= "" then
				data.settings.cmdrfont = STATE.cmdrFontName
			else
				data.settings.cmdrfont = nil
			end

			local encodeOk, encoded = pcall(HttpService.JSONEncode, HttpService, data)
			if not encodeOk or not encoded then
				return false
			end

			local writeOk = pcall(writefile, BINDS_FILE, encoded)
			return writeOk and true or false
		end
	end
end

do
	STATE.teleportDebugInitialized = STATE.teleportDebugInitialized or false

	function initializeTeleportDebug()
		if STATE.teleportDebugInitialized then
			return
		end

		STATE.teleportDebugInitialized = true

		TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMessage, placeId, teleportOptions)
			if player ~= LocalPlayer then
				return
			end

			local failedJobId = "Unknown"

			pcall(function()
				if teleportOptions and teleportOptions.ServerInstanceId and teleportOptions.ServerInstanceId ~= "" then
					failedJobId = tostring(teleportOptions.ServerInstanceId)
				end
			end)

			print(
				"[FAIL] TeleportInitFailed:",
				tostring(teleportResult),
				tostring(errorMessage),
				"PlaceId:",
				tostring(placeId),
				"JobId:",
				failedJobId
			)
		end)
	end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- STARTUP
--////////////////////////////////////////////////////
do
	function forceTopLayer(guiObject)
		if not guiObject then
			return
		end

		if guiObject:IsA("ScreenGui") then
			guiObject.DisplayOrder = 999999
			guiObject.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		end
	end

	function bootExecutor()
		local screenGui = UI.BG:FindFirstAncestorOfClass("ScreenGui")
		if screenGui then
			screenGui.IgnoreGuiInset = true
			screenGui.DisplayOrder = 999999
			screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		end

		forceTopLayer(commandExecutor)

		resetSuggester()
		UI.BG.Visible = false
		UI.HelperBG.Visible = false
		UI.ExampleHelperTemplate.Visible = false
		UI.Welcome.Visible = false
		UI.TutorialFrames.Visible = false
		UI.OuterChatModule.Visible = false
		UI.ChatModule.Visible = false
		UI.GameConfigModule.Visible = false

		startGlobalPlayerTracking()
		startDeathTracker()
		startChatlogsSystem()
		initializeCoreGuiStates()
		initializeTeleportDebug()
		initializeGameConfigSystem()

		if loadWaypoints() then
			print("[SUCCESS] Loaded saved waypoints from file")
		else
			print("[INFO] No saved waypoints found or executor API unavailable")
		end

		if loadBinds() then
			print("[SUCCESS] Loaded saved binds from file")
		else
			print("[INFO] No saved binds found or executor API unavailable")
		end

		if loadGameConfigs() then
			print("[SUCCESS] Loaded saved game configs from file")
		else
			print("[INFO] No saved game configs found or executor API unavailable")
		end

		if loadTutorialProgress() then
			print("[SUCCESS] Tutorial already completed")
		else
			print("[INFO] Tutorial progress file missing or tutorial not completed yet")
		end

		beginStartupIntroFlow()

		task.defer(function()
			executeSavedGameConfigForCurrentExperience()
		end)

		STATE.characterCleanupConnection = LocalPlayer.CharacterAdded:Connect(function()
			task.wait()

			cacheMovementDefaults()
			stopFly()
			stopTracers()
			stopFreecam()
			refreshWaypointMarkers()

			if STATE.gravityCustomEnabled then
				if STATE.gravityMultiplier > 0 then
					workspace.Gravity = STATE.defaultGravity / STATE.gravityMultiplier
				else
					workspace.Gravity = STATE.defaultGravity * math.abs(STATE.gravityMultiplier)
				end
			end

			if STATE.edgeJumpEnabled then
				task.defer(function()
					startEdgeJump()
				end)
			end

			if STATE.fogModified then
				startNoFog()
			end

			if STATE.hipHeightCustomEnabled then
				task.defer(function()
					local humanoid = getLocalHumanoid()
					if humanoid and STATE.defaultHipHeight ~= nil then
						-- custom hipheight persistence placeholder
					end
				end)
			end
		end)
	end

	local bootOk, bootErr = pcall(bootExecutor)
	if not bootOk then
		warn("[EXECUTOR BOOT ERROR] " .. tostring(bootErr))
		pcall(function()
			originalPrint("[EXECUTOR BOOT ERROR]", tostring(bootErr))
		end)
	end
end
