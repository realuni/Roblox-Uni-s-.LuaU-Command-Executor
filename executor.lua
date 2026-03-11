
--// Made by reaIuni @ Roblox
--// Executable client-side command UI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local BINDS_FILE = "executor_binds.json"
local WAYPOINT_FILE = "executor_waypoints.json"
local print = print

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- UI CREATION
--////////////////////////////////////////////////////

local commandExecutor = Instance.new("ScreenGui")
commandExecutor.Name = "CommandExecutor"

-- FORCE UI ABOVE EVERYTHING
commandExecutor.IgnoreGuiInset = true
commandExecutor.DisplayOrder = 999999
commandExecutor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
commandExecutor.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
commandExecutor.ResetOnSpawn = false

do
	local main = Instance.new("Frame")
	main.Name = "Main"
	main.BorderSizePixel = 0
	main.BackgroundTransparency = 1
	main.Size = UDim2.fromScale(1, 1)
	main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	main.BorderColor = BrickColor.new("Really black")

	do
		local welcome = Instance.new("Frame")
		welcome.Name = "Welcome"
		welcome.BackgroundTransparency = 0.25
		welcome.BorderSizePixel = 0
		welcome.Visible = false
		welcome.Size = UDim2.fromScale(1, 1)
		welcome.BorderColor3 = Color3.fromRGB(0, 0, 0)
		welcome.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		welcome.BorderColor = BrickColor.new("Really black")

		do
			local title1 = Instance.new("TextLabel")
			title1.Name = "Title1"
			title1.Text = "UNI'S .LuaU COMMAND EXECUTOR"
			title1.TextSize = 14
			title1.BorderSizePixel = 0
			title1.BackgroundTransparency = 1
			title1.TextWrapped = true
			title1.TextScaled = true
			title1.Size = UDim2.fromScale(1, 0.053)
			title1.Position = UDim2.fromScale(0, 0.4083)
			title1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
			title1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title1.TextColor3 = Color3.fromRGB(255, 255, 255)
			title1.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title1.BorderColor = BrickColor.new("Really black")
			title1.Parent = welcome

			local title2 = Instance.new("TextLabel")
			title2.Name = "Title2"
			title2.Text = "Welcome back, username."
			title2.TextSize = 14
			title2.BorderSizePixel = 0
			title2.BackgroundTransparency = 1
			title2.TextWrapped = true
			title2.TextScaled = true
			title2.Size = UDim2.fromScale(1, 0.0359)
			title2.Position = UDim2.fromScale(0, 0.4614)
			title2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			title2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title2.TextColor3 = Color3.fromRGB(255, 255, 255)
			title2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title2.BorderColor = BrickColor.new("Really black")
			title2.Parent = welcome

			local title3 = Instance.new("TextLabel")
			title3.Name = "Title3"
			title3.Text = "Press ' ; ' to Open the Menu"
			title3.TextSize = 14
			title3.BorderSizePixel = 0
			title3.BackgroundTransparency = 1
			title3.TextWrapped = true
			title3.TextScaled = true
			title3.Size = UDim2.fromScale(1, 0.0359)
			title3.Position = UDim2.fromScale(0, 0.5547)
			title3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			title3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title3.TextColor3 = Color3.fromRGB(255, 255, 255)
			title3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title3.BorderColor = BrickColor.new("Really black")
			title3.Parent = welcome
		end

		welcome.Parent = main

		local bg = Instance.new("Frame")
		bg.Name = "BG"
		bg.BorderSizePixel = 0
		bg.BackgroundTransparency = 1
		bg.Size = UDim2.fromScale(1, 0.1823)
		bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
		bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		bg.BorderColor = BrickColor.new("Really black")
		bg.Visible = false

		do
			local mainBg = Instance.new("Frame")
			mainBg.Name = "MainBG"
			mainBg.BorderSizePixel = 0
			mainBg.BackgroundTransparency = 0.45
			mainBg.Size = UDim2.fromScale(0.9771, 0.1823)
			mainBg.Position = UDim2.fromScale(0.0111, 0.8215)
			mainBg.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
			mainBg.BorderColor3 = Color3.fromRGB(0, 0, 0)
			mainBg.BorderColor = BrickColor.new("Really black")

			do
				local textLabel = Instance.new("TextLabel")
				textLabel.Name = "PromptLabel"
				textLabel.Text = "LuaUExec@Cmdr$"
				textLabel.BackgroundTransparency = 1
				textLabel.BorderSizePixel = 0
				textLabel.TextSize = 14
				textLabel.TextWrapped = true
				textLabel.TextScaled = true
				textLabel.Size = UDim2.fromScale(0.0783, 0.5148)
				textLabel.Position = UDim2.fromScale(0.007, 0.2317)
				textLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json")
				textLabel.TextXAlignment = Enum.TextXAlignment.Left
				textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				textLabel.TextColor3 = Color3.fromRGB(202, 177, 53)
				textLabel.BorderColor = BrickColor.new("Really black")
				textLabel.Parent = mainBg

				local commandInput = Instance.new("TextBox")
				commandInput.PlaceholderText = "Type 'help' to view all of the commands"
				commandInput.Name = "CommandInput"
				commandInput.Text = ""
				commandInput.BackgroundTransparency = 1
				commandInput.BorderSizePixel = 0
				commandInput.CursorPosition = -1
				commandInput.TextSize = 14
				commandInput.TextWrapped = true
				commandInput.TextScaled = true
				commandInput.Position = UDim2.fromScale(0.0853, 0.2317)
				commandInput.Size = UDim2.fromScale(0.9146, 0.5148)
				commandInput.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
				commandInput.TextXAlignment = Enum.TextXAlignment.Left
				commandInput.TextColor3 = Color3.fromRGB(227, 227, 227)
				commandInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				commandInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
				commandInput.BorderColor = BrickColor.new("Really black")
				commandInput.ClearTextOnFocus = false
				commandInput.Parent = mainBg
			end

			mainBg.Parent = bg

			local helperBg = Instance.new("Frame")
			helperBg.Name = "HelperBG"
			helperBg.BorderSizePixel = 0
			helperBg.BackgroundTransparency = 1
			helperBg.Size = UDim2.fromScale(0.9771, 2.55)
			helperBg.Position = UDim2.fromScale(0.0111, 1.05)
			helperBg.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
			helperBg.BorderColor3 = Color3.fromRGB(0, 0, 0)
			helperBg.BorderColor = BrickColor.new("Really black")
			helperBg.Visible = false

			do
				local scrollingFrame = Instance.new("ScrollingFrame")
				scrollingFrame.Name = "ScrollingFrame"
				scrollingFrame.BackgroundTransparency = 1
				scrollingFrame.BorderSizePixel = 0
				scrollingFrame.ScrollBarThickness = 0
				scrollingFrame.Active = true
				scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
				scrollingFrame.CanvasSize = UDim2.fromOffset(0, 0)
				scrollingFrame.Size = UDim2.fromScale(1, 1)
				scrollingFrame.Position = UDim2.fromScale(0, 0)
				scrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
				scrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				scrollingFrame.BorderColor = BrickColor.new("Really black")

				do
					local uiListLayout = Instance.new("UIListLayout")
					uiListLayout.Name = "UIListLayout"
					uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					uiListLayout.Padding = UDim.new(0, 4)
					uiListLayout.Parent = scrollingFrame

					local exampleHelper = Instance.new("Frame")
					exampleHelper.Name = "ExampleHelper"
					exampleHelper.BorderSizePixel = 0
					exampleHelper.BackgroundTransparency = 0.45
					exampleHelper.Size = UDim2.new(1, 0, 0, 28)
					exampleHelper.BorderColor3 = Color3.fromRGB(0, 0, 0)
					exampleHelper.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
					exampleHelper.BorderColor = BrickColor.new("Really black")
					exampleHelper.Visible = false

					do
						local helperText = Instance.new("TextLabel")
						helperText.Name = "CommandLine"
						helperText.Text = "Command Name : Command Description"
						helperText.RichText = true
						helperText.BackgroundTransparency = 1
						helperText.BorderSizePixel = 0
						helperText.TextSize = 14
						helperText.TextWrapped = false
						helperText.TextScaled = false
						helperText.Size = UDim2.new(1, -16, 1, 0)
						helperText.Position = UDim2.new(0, 8, 0, 0)
						helperText.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json")
						helperText.TextXAlignment = Enum.TextXAlignment.Left
						helperText.TextYAlignment = Enum.TextYAlignment.Center
						helperText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						helperText.BorderColor3 = Color3.fromRGB(0, 0, 0)
						helperText.TextColor3 = Color3.fromRGB(202, 177, 53)
						helperText.BorderColor = BrickColor.new("Really black")
						helperText.Parent = exampleHelper
					end

					exampleHelper.Parent = scrollingFrame
				end

				scrollingFrame.Parent = helperBg
			end

			helperBg.Parent = bg
		end

		bg.Parent = main

		local commandSuggester = Instance.new("Frame")
		commandSuggester.Name = "CommandSuggester"
		commandSuggester.BorderSizePixel = 0
		commandSuggester.BackgroundTransparency = 0.45
		commandSuggester.Size = UDim2.fromScale(0.18, 0.0919)
		commandSuggester.Position = UDim2.fromScale(0.0945, 0.1883)
		commandSuggester.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
		commandSuggester.BorderColor3 = Color3.fromRGB(0, 0, 0)
		commandSuggester.BorderColor = BrickColor.new("Really black")
		commandSuggester.Visible = false

		do
			local commandName = Instance.new("TextLabel")
			commandName.Text = "player esp"
			commandName.Name = "CommandName"
			commandName.BackgroundTransparency = 1
			commandName.BorderSizePixel = 0
			commandName.TextSize = 14
			commandName.TextWrapped = true
			commandName.TextScaled = true
			commandName.Size = UDim2.fromScale(0.9821, 0.1996)
			commandName.Position = UDim2.fromScale(0.0388, 0.0974)
			commandName.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold)
			commandName.TextXAlignment = Enum.TextXAlignment.Left
			commandName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			commandName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			commandName.TextColor3 = Color3.fromRGB(255, 255, 255)
			commandName.BorderColor = BrickColor.new("Really black")
			commandName.Parent = commandSuggester

			local commandDescription = Instance.new("TextLabel")
			commandDescription.Text = "Command Description Goes Here, Command Description Goes Here, Command Description Goes Here, "
			commandDescription.Name = "CommandDescription"
			commandDescription.BackgroundTransparency = 1
			commandDescription.BorderSizePixel = 0
			commandDescription.TextSize = 14
			commandDescription.TextWrapped = true
			commandDescription.TextScaled = true
			commandDescription.Position = UDim2.fromScale(0.0388, 0.3808)
			commandDescription.Size = UDim2.fromScale(0.9269, 0.4666)
			commandDescription.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
			commandDescription.TextYAlignment = Enum.TextYAlignment.Top
			commandDescription.TextXAlignment = Enum.TextXAlignment.Left
			commandDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
			commandDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			commandDescription.BorderColor3 = Color3.fromRGB(0, 0, 0)
			commandDescription.BorderColor = BrickColor.new("Really black")
			commandDescription.Parent = commandSuggester

			local container = Instance.new("Frame")
			container.Name = "Container"
			container.BorderSizePixel = 0
			container.BackgroundTransparency = 1
			container.Size = UDim2.fromScale(1, 0.1785)
			container.Position = UDim2.fromScale(0, 0.9993)
			container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			container.BorderColor3 = Color3.fromRGB(0, 0, 0)
			container.BorderColor = BrickColor.new("Really black")

			do
				local uilistLayout2 = Instance.new("UIListLayout")
				uilistLayout2.SortOrder = Enum.SortOrder.LayoutOrder
				uilistLayout2.Parent = container

				local exampleSuggestion = Instance.new("Frame")
				exampleSuggestion.Name = "ExampleSuggestion"
				exampleSuggestion.BorderSizePixel = 0
				exampleSuggestion.BackgroundTransparency = 0.6
				exampleSuggestion.Size = UDim2.fromScale(1, 1.5276)
				exampleSuggestion.BorderColor3 = Color3.fromRGB(0, 0, 0)
				exampleSuggestion.BackgroundColor3 = Color3.fromRGB(28, 29, 34)
				exampleSuggestion.BorderColor = BrickColor.new("Really black")
				exampleSuggestion.Visible = false

				do
					local commandName2 = Instance.new("TextLabel")
					commandName2.Text = "player esp"
					commandName2.Name = "CommandName"
					commandName2.BackgroundTransparency = 1
					commandName2.BorderSizePixel = 0
					commandName2.TextSize = 14
					commandName2.TextWrapped = true
					commandName2.TextScaled = true
					commandName2.Size = UDim2.fromScale(0.9819, 0.5882)
					commandName2.Position = UDim2.fromScale(0.0388, 0.1935)
					commandName2.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json")
					commandName2.TextXAlignment = Enum.TextXAlignment.Left
					commandName2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					commandName2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					commandName2.TextColor3 = Color3.fromRGB(159, 182, 202)
					commandName2.BorderColor = BrickColor.new("Really black")
					commandName2.Parent = exampleSuggestion
				end

				exampleSuggestion.Parent = container
			end

			container.Parent = commandSuggester
		end

		commandSuggester.Parent = main
	end

	main.Parent = commandExecutor
end

commandExecutor.Parent = PlayerGui

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- REFERENCES
--////////////////////////////////////////////////////

local main = commandExecutor:WaitForChild("Main")
local welcome = main:WaitForChild("Welcome")
local title1 = welcome:WaitForChild("Title1")
local title2 = welcome:WaitForChild("Title2")
local title3 = welcome:WaitForChild("Title3")

local bg = main:WaitForChild("BG")
local mainBg = bg:WaitForChild("MainBG")
local commandInput = mainBg:WaitForChild("CommandInput")
local commandSuggester = main:WaitForChild("CommandSuggester")
local suggesterCommandName = commandSuggester:WaitForChild("CommandName")
local suggesterCommandDescription = commandSuggester:WaitForChild("CommandDescription")
local container = commandSuggester:WaitForChild("Container")
local exampleSuggestionTemplate = container:WaitForChild("ExampleSuggestion")
local helperBg = bg:WaitForChild("HelperBG")
local helperScrollingFrame = helperBg:WaitForChild("ScrollingFrame")
local exampleHelperTemplate = helperScrollingFrame:WaitForChild("ExampleHelper")
local exampleHelperLabel = exampleHelperTemplate:WaitForChild("CommandLine")
exampleHelperLabel.RichText = true

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- SETTINGS
--////////////////////////////////////////////////////

local STATE = {
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
	welcomeFinished = false,
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
}

local CONFIG = {
	TYPE_SPEED = 0.02,
	FADE_TIME = 0.4,
	BETWEEN_TITLES_DELAY = 0.35,
	WELCOME_HOLD_TIME = 2,

	COLOR_NORMAL = Color3.fromRGB(159,182,202),
	COLOR_SPOTLIGHT = Color3.fromRGB(255,255,255),

	MAX_SUGGESTIONS = 6,

	CLICKTP_MAX_DISTANCE = 1000,
	CLICKTP_MIN_Y = -1000
}

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- WAYPOINT STORAGE SYSTEM
--////////////////////////////////////////////////////

local function loadBinds()
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

	local keybinds = STATE.keybinds
	local toggleBinds = STATE.toggleBinds
	local ghostBinds = STATE.ghostBinds

	if data.keybinds then
		for keyName, command in pairs(data.keybinds) do
			local keyCode = Enum.KeyCode[keyName]
			if keyCode then
				keybinds[keyCode] = command
			end
		end
	end

	if data.togglebinds then
		for keyName, info in pairs(data.togglebinds) do
			local keyCode = Enum.KeyCode[keyName]
			if keyCode then
				toggleBinds[keyCode] = {
					onCommand = info.onCommand,
					offCommand = info.offCommand,
					state = false
				}
			end
		end
	end

	if data.ghostbinds then
		for keyName, ghostCommand in pairs(data.ghostbinds) do
			local keyCode = Enum.KeyCode[keyName]
			if keyCode then
				ghostBinds[keyCode] = ghostCommand
			end
		end
	end

	return true
end

local function saveBinds()
	if not writefile then
		return false
	end

	local data = {
		keybinds = {},
		togglebinds = {},
		ghostbinds = {}
	}

	for key, command in pairs(STATE.keybinds) do
		data.keybinds[key.Name] = command
	end

	for key, info in pairs(STATE.toggleBinds) do
		data.togglebinds[key.Name] = {
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

local function saveWaypoints()
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

local function loadWaypoints()
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

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- WAYPOINT VISUALIZATION SYSTEM
--////////////////////////////////////////////////////

local WAYPOINT_COLOR = Color3.fromRGB(212, 62, 62)
local WAYPOINT_COLOR_HEX = "#d43e3e"
local function createWaypointIndicator(name)
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

local function createWaypointMarker(name, position)
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

local function destroyWaypointMarkers()
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

local function updateWaypointVisibility()
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

local function refreshWaypointMarkers()
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

local function startWaypointRendering()
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

local function stopWaypointRendering()
	STATE.waypointShowEnabled = false

	if STATE.waypointRenderConnection then
		STATE.waypointRenderConnection:Disconnect()
		STATE.waypointRenderConnection = nil
	end
end


--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- SEARCH FUNCTIONS
--////////////////////////////////////////////////////

local populatePlayerInfo
local populateHelpList
local clearHelpEntries
local hideHelpList
local closeMenu
local openMenu

local function getCubeHitboxSize(originalSize, multiplier)
	local largestAxis = math.max(originalSize.X, originalSize.Y, originalSize.Z) * (1 + multiplier)
	return Vector3.new(largestAxis, largestAxis, largestAxis)
end

local function freezeCharacterForFreecam()
	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	STATE.freecamSavedWalkSpeed = humanoid.WalkSpeed
	STATE.freecamSavedJumpHeight = humanoid.JumpHeight
	STATE.freecamSavedAutoRotate = humanoid.AutoRotate

	humanoid.WalkSpeed = 0
	humanoid.JumpHeight = 0
	humanoid.AutoRotate = false
	humanoid:Move(Vector3.zero, true)

	character = character:FindFirstChild("HumanoidRootPart")
	if character then
		character.AssemblyLinearVelocity = Vector3.zero
		character.AssemblyAngularVelocity = Vector3.zero
	end
end

local function unfreezeCharacterFromFreecam()
	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	if STATE.freecamSavedWalkSpeed ~= nil then
		humanoid.WalkSpeed = STATE.freecamSavedWalkSpeed
	end
	if STATE.freecamSavedJumpHeight ~= nil then
		humanoid.JumpHeight = STATE.freecamSavedJumpHeight
	end
	if STATE.freecamSavedAutoRotate ~= nil then
		humanoid.AutoRotate = STATE.freecamSavedAutoRotate
	end

	humanoid:Move(Vector3.zero, true)

	character = character:FindFirstChild("HumanoidRootPart")
	if character then
		character.AssemblyLinearVelocity = Vector3.zero
		character.AssemblyAngularVelocity = Vector3.zero
	end
end

local function stopFreecam()
	STATE.freecamEnabled = false

	if STATE.freecamConnection then
		STATE.freecamConnection:Disconnect()
		STATE.freecamConnection = nil
	end

	if STATE.freecamMouseConnection then
		STATE.freecamMouseConnection:Disconnect()
		STATE.freecamMouseConnection = nil
	end

	local camera = workspace.CurrentCamera
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	if camera then
		camera.CameraType = Enum.CameraType.Custom
		camera.CameraSubject = humanoid
	end

	UserInputService.MouseBehavior = STATE.freecamOriginalMouseBehavior or Enum.MouseBehavior.Default
	UserInputService.MouseIconEnabled = STATE.freecamOriginalMouseIconEnabled == nil and true or STATE.freecamOriginalMouseIconEnabled

	unfreezeCharacterFromFreecam()

	STATE.freecamOriginalCameraType = nil
	STATE.freecamOriginalCameraSubject = nil
	STATE.freecamOriginalCameraCFrame = nil
	STATE.freecamOriginalCameraFocus = nil
	STATE.freecamPosition = nil
end

local function getFreecamCharacterStartCFrame()
	local camera = workspace.CurrentCamera
	local character = LocalPlayer.Character

	if not camera then
		return nil
	end

	local root = character and character:FindFirstChild("HumanoidRootPart")
	local head = character and character:FindFirstChild("Head")

	local startPosition
	if head then
		startPosition = head.Position
	elseif root then
		startPosition = root.Position + Vector3.new(0, 2, 0)
	else
		startPosition = camera.CFrame.Position
	end

	local lookVector = camera.CFrame.LookVector
	return CFrame.lookAt(startPosition, startPosition + lookVector)
end

local function startFreecam(speed)
	if STATE.menuOpen then
		closeMenu()
	end

	if STATE.freecamEnabled then
		return
	end

	speed = tonumber(speed) or 50

	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	local startCFrame = getFreecamCharacterStartCFrame()
	if not startCFrame then
		return
	end

	STATE.freecamEnabled = true
	freezeCharacterForFreecam()

	STATE.freecamOriginalCameraType = camera.CameraType
	STATE.freecamOriginalCameraSubject = camera.CameraSubject
	STATE.freecamOriginalCameraCFrame = camera.CFrame
	STATE.freecamOriginalCameraFocus = camera.Focus
	STATE.freecamOriginalMouseBehavior = UserInputService.MouseBehavior
	STATE.freecamOriginalMouseIconEnabled = UserInputService.MouseIconEnabled

	STATE.freecamPosition = startCFrame.Position
	STATE.freecamYaw = math.atan2(-startCFrame.LookVector.X, -startCFrame.LookVector.Z)
	STATE.freecamPitch = math.asin(startCFrame.LookVector.Y)

	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = startCFrame
	camera.Focus = startCFrame * CFrame.new(0, 0, -512)

	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	UserInputService.MouseIconEnabled = false

	STATE.freecamMouseConnection = UserInputService.InputChanged:Connect(function(input, gameProcessed)
		if not STATE.freecamEnabled then
			return
		end

		if gameProcessed then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement then
			STATE.freecamYaw -= input.Delta.X * STATE.freecamSensitivity
			STATE.freecamPitch -= input.Delta.Y * STATE.freecamSensitivity
			STATE.freecamPitch = math.clamp(STATE.freecamPitch, math.rad(-89), math.rad(89))
		end
	end)

	STATE.freecamConnection = game:GetService("RunService").RenderStepped:Connect(function(dt)
		if not STATE.freecamEnabled then
			return
		end

		local currentCamera = workspace.CurrentCamera
		if not currentCamera then
			stopFreecam()
			return
		end

		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")

		if humanoid then
			humanoid.WalkSpeed = 0
			humanoid.JumpHeight = 0
			humanoid.AutoRotate = false
			humanoid:Move(Vector3.zero, true)
		end

		if root then
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end

		local rotation = CFrame.fromOrientation(STATE.freecamPitch, STATE.freecamYaw, 0)
		local moveDirection = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			moveDirection += rotation.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			moveDirection -= rotation.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			moveDirection -= rotation.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			moveDirection += rotation.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			moveDirection += Vector3.yAxis
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.C) then
			moveDirection -= Vector3.yAxis
		end

		if moveDirection.Magnitude > 0 then
			local currentSpeed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and (speed * 2) or speed
			STATE.freecamPosition += moveDirection.Unit * currentSpeed * dt
		end

		currentCamera.CFrame = CFrame.new(STATE.freecamPosition) * rotation
		currentCamera.Focus = currentCamera.CFrame * CFrame.new(0, 0, -512)
	end)
end

local function cacheMovementDefaults()
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

local function setWalkSpeed(amount)
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

local function resetWalkSpeed()
	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	cacheMovementDefaults()

	if STATE.defaultWalkSpeed ~= nil then
		humanoid.WalkSpeed = STATE.defaultWalkSpeed
	end
end

local function setJumpHeight(amount)
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

local function resetJumpHeight()
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

local function stopFullbright()
	STATE.fullbrightEnabled = false

	if STATE.fullbrightConnection then
		STATE.fullbrightConnection:Disconnect()
		STATE.fullbrightConnection = nil
	end

	if STATE.fullbrightBackup then
		local lighting = game:GetService("Lighting")
		lighting.Brightness = STATE.fullbrightBackup.Brightness
		lighting.ClockTime = STATE.fullbrightBackup.ClockTime
		lighting.FogEnd = STATE.fullbrightBackup.FogEnd
		lighting.GlobalShadows = STATE.fullbrightBackup.GlobalShadows
		lighting.OutdoorAmbient = STATE.fullbrightBackup.OutdoorAmbient
		lighting.Ambient = STATE.fullbrightBackup.Ambient
	end
end

local function startFullbright()
	local lighting = game:GetService("Lighting")

	if not STATE.fullbrightBackup then
		STATE.fullbrightBackup = {
			Brightness = lighting.Brightness,
			ClockTime = lighting.ClockTime,
			FogEnd = lighting.FogEnd,
			GlobalShadows = lighting.GlobalShadows,
			OutdoorAmbient = lighting.OutdoorAmbient,
			Ambient = lighting.Ambient,
		}
	end

	stopFullbright()
	STATE.fullbrightEnabled = true

	STATE.fullbrightConnection = game:GetService("RunService").RenderStepped:Connect(function()
		if not STATE.fullbrightEnabled then
			return
		end

		lighting.Brightness = 5
		lighting.ClockTime = 12
		lighting.FogEnd = 100000
		lighting.GlobalShadows = false
		lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		lighting.Ambient = Color3.fromRGB(255, 255, 255)
	end)
end

local function stopCustomFov()
	STATE.customFovEnabled = false

	if STATE.fovConnection then
		STATE.fovConnection:Disconnect()
		STATE.fovConnection = nil
	end

	local camera = workspace.CurrentCamera
	if camera then
		camera.FieldOfView = STATE.defaultCameraFov
	end
end

local function startCustomFov(amount)
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

	STATE.fovConnection = game:GetService("RunService").RenderStepped:Connect(function()
		if not STATE.customFovEnabled then
			return
		end

		local camera = workspace.CurrentCamera
		if camera then
			camera.FieldOfView = STATE.customFovValue
		end
	end)
end

local function getTracerTargetPart(character)
	return character and (
		character:FindFirstChild("UpperTorso")
			or character:FindFirstChild("Torso")
			or character:FindFirstChild("HumanoidRootPart")
			or character:FindFirstChild("Head")
	) or nil
end

local function createTracerLine(player)
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

local function removeTracerLine(userId)
	local line = STATE.tracerFrames[userId]
	if line then
		line:Destroy()
		STATE.tracerFrames[userId] = nil
	end
end

local function clearAllTracers()
	for userId, line in pairs(STATE.tracerFrames) do
		if line then
			line:Destroy()
		end
		STATE.tracerFrames[userId] = nil
	end
end

local function updateTracerFrame(line, fromPos, toPos, color)
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

	STATE.tracerConnection = game:GetService("RunService").RenderStepped:Connect(function()
		if not STATE.tracersEnabled then
			return
		end

		local camera = workspace.CurrentCamera
		local localRoot = getTracerTargetPart(LocalPlayer.Character)

		if not camera or not localRoot then
			clearAllTracers()
			return
		end

		local localScreenPos, localOnScreen = camera:WorldToViewportPoint(localRoot.Position)
		if not localOnScreen or localScreenPos.Z <= 0 then
			for _, line in pairs(STATE.tracerFrames) do
				line.Visible = false
			end
			return
		end

		local tracerOrigin = Vector2.new(localScreenPos.X, localScreenPos.Y)
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

local function getCharacterRoot(character)
	return character and (
		character:FindFirstChild("HumanoidRootPart")
			or character:FindFirstChild("UpperTorso")
			or character:FindFirstChild("Torso")
	) or nil
end

local function setCharacterCollisionEnabled(character, enabled)
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

	STATE.flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
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

local function findPlayerByName(inputName)
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

local function cleanupHitboxPlayer(player)
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

local function getActiveHitboxMultiplierForPlayer(player)
	if not player or player == LocalPlayer then
		return nil
	end

	if STATE.hitboxPlayerMultipliers[player.UserId] ~= nil then
		return STATE.hitboxPlayerMultipliers[player.UserId]
	end

	return STATE.hitboxAllMultiplier
end

local function applyStoredHitboxToCharacter(player, character)
	if not player or player == LocalPlayer or not character then
		return
	end

	local multiplier = getActiveHitboxMultiplierForPlayer(player)
	if multiplier == nil then
		return
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp or not hrp:IsA("BasePart") then
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

local function restoreHitboxForPlayer(player)
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

local function refreshHitboxForPlayer(player)
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

local function refreshAllActiveHitboxes()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local multiplier = STATE.hitboxPlayerMultipliers[player.UserId] or STATE.hitboxAllMultiplier

			if STATE.hitboxIgnoreOwnTeam and player.Team == LocalPlayer.Team then
				restoreHitboxForPlayer(player)
			elseif multiplier then
				refreshHitboxForPlayer(player)
			else
				restoreHitboxForPlayer(player)
			end
		end
	end
end

local function applyStoredHitboxTransparency(player)
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

local function stopHitboxEnforcement()
	STATE.hitboxSystemEnabled = false

	if STATE.hitboxEnforcementConnection then
		STATE.hitboxEnforcementConnection:Disconnect()
		STATE.hitboxEnforcementConnection = nil
	end
end

local function startHitboxEnforcement()
	if STATE.hitboxEnforcementConnection then
		return
	end

	STATE.hitboxSystemEnabled = true
	STATE.hitboxEnforcementConnection = game:GetService("RunService").Heartbeat:Connect(function()
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

local function hookHitboxCharacter(player)
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

		if getActiveHitboxMultiplierForPlayer(player) ~= nil then
			refreshHitboxForPlayer(player)
			applyStoredHitboxTransparency(player)
		end
	end)

	if player.Character then
		task.defer(function()
			if getActiveHitboxMultiplierForPlayer(player) ~= nil then
				refreshHitboxForPlayer(player)
				applyStoredHitboxTransparency(player)
			end
		end)
	end
end

local function ensureHitboxTracking()
	if STATE.hitboxPlayerAddedConnection then
		return
	end

	STATE.hitboxPlayerAddedConnection = Players.PlayerAdded:Connect(function(player)
		if player == LocalPlayer then
			return
		end

		hookHitboxCharacter(player)

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

local function resetAllHitboxes()
	STATE.hitboxAllMultiplier = nil
	table.clear(STATE.hitboxPlayerMultipliers)

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

	table.clear(STATE.originalHumanoidRootPartSizes)
	table.clear(STATE.originalHumanoidRootPartCanCollide)
end

STATE.highlightAllEnabled = STATE.highlightAllEnabled or false
STATE.highlightMaxDistance = STATE.highlightMaxDistance or math.huge

local function removeHighlight(character)
	local highlight = STATE.highlightObjects[character]
	if highlight then
		highlight:Destroy()
		STATE.highlightObjects[character] = nil
	end
end

local function applyHighlightToCharacter(player, character)
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

local function updateHighlightVisibility()
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
	STATE.highlightConnections.tracking = game:GetService("RunService").RenderStepped:Connect(updateHighlightVisibility)
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

local function sanitizeCommandInput()
	local text = commandInput.Text
	local cleaned = text:gsub(";", ""):gsub("\t", "")

	if cleaned ~= text then
		local oldCursor = commandInput.CursorPosition
		commandInput.Text = cleaned
		commandInput.CursorPosition = math.clamp(oldCursor or (#cleaned + 1),1,#cleaned+1)
	end
end

local function destroyExecutorSystem()
	stopFly()
	stopTracers()
	stopFreecam()
	stopTpWalk()
	stopCustomFov()
	stopFullbright()
	stopNametagSystem()
	stopHitboxEnforcement()
	resetAllHighlights()
	resetAllHitboxes()
	stopWaypointRendering()
	destroyWaypointMarkers()

	STATE.clickTeleportKey = nil
	STATE.clickDeleteKey = nil
	STATE.clickTeleportActive = false
	STATE.clickDeleteActive = false

	if STATE.globalTrackPlayerAddedConnection then
		STATE.globalTrackPlayerAddedConnection:Disconnect()
		STATE.globalTrackPlayerAddedConnection = nil
	end

	for player, conn in pairs(STATE.globalCharacterConnections) do
		if conn then
			conn:Disconnect()
		end
		STATE.globalCharacterConnections[player] = nil
	end

	if STATE.hitboxPlayerRemovingConnection then
		STATE.hitboxPlayerRemovingConnection:Disconnect()
		STATE.hitboxPlayerRemovingConnection = nil
	end

	STATE.noclipEnabled = false
	if STATE.noclipConnection then
		STATE.noclipConnection:Disconnect()
		STATE.noclipConnection = nil
	end

	if STATE.inputTextConnection then
		STATE.inputTextConnection:Disconnect()
		STATE.inputTextConnection = nil
	end

	if STATE.inputFocusLostConnection then
		STATE.inputFocusLostConnection:Disconnect()
		STATE.inputFocusLostConnection = nil
	end

	if STATE.inputBeganConnection then
		STATE.inputBeganConnection:Disconnect()
		STATE.inputBeganConnection = nil
	end

	if STATE.inputEndedConnection then
		STATE.inputEndedConnection:Disconnect()
		STATE.inputEndedConnection = nil
	end

	if STATE.characterCleanupConnection then
		STATE.characterCleanupConnection:Disconnect()
		STATE.characterCleanupConnection = nil
	end

	if STATE.hitboxPlayerAddedConnection then
		STATE.hitboxPlayerAddedConnection:Disconnect()
		STATE.hitboxPlayerAddedConnection = nil
	end

	for player, conn in pairs(STATE.hitboxCharacterConnections) do
		if conn then
			conn:Disconnect()
		end
		STATE.hitboxCharacterConnections[player] = nil
	end

	if STATE.highlightConnections.playerAdded then
		STATE.highlightConnections.playerAdded:Disconnect()
		STATE.highlightConnections.playerAdded = nil
	end

	if STATE.highlightConnections.tracking then
		STATE.highlightConnections.tracking:Disconnect()
		STATE.highlightConnections.tracking = nil
	end
	table.clear(STATE.highlightConnections)

	for player, conn in pairs(STATE.highlightCharacterConnections) do
		if conn then
			conn:Disconnect()
		end
		STATE.highlightCharacterConnections[player] = nil
	end

	for player, conn in pairs(STATE.highlightTeamConnections) do
		if conn then
			conn:Disconnect()
		end
		STATE.highlightTeamConnections[player] = nil
	end

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
	end

	task.defer(function()
		if script then
			script:Destroy()
		end
	end)
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- PRINT SYSTEM
--////////////////////////////////////////////////////

local activePrintHelpers = {}
local printHelperCounter = 0

local function createPrintHelper(text, shouldFade)
	printHelperCounter += 1

	local entry = exampleHelperTemplate:Clone()
	entry.Name = "PrintHelper_" .. printHelperCounter
	entry.Visible = true
	entry.Parent = helperScrollingFrame
	entry.Size = UDim2.new(1, 0, 0, 28)
	entry.BackgroundTransparency = 0.45

	local label = entry:FindFirstChild("CommandLine")
	if label then
		label.RichText = true
		label.Text = string.format(
			"<font color=\"rgb(202,177,53)\">[EXEC]</font> <font color=\"rgb(227,227,227)\">%s</font>",
			tostring(text)
		)
	end

	helperBg.Visible = true
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

-- IMPORTANT:
-- save the CURRENT LOCAL print first, then override the LOCAL print itself
local originalPrint = print

local function executorPrint(...)
	local args = { ... }
	local parts = table.create(#args)

	for i = 1, #args do
		parts[i] = tostring(args[i])
	end

	local text = table.concat(parts, " ")

	-- normal console output
	originalPrint(...)

	-- executor UI output
	createPrintHelper(text)
end

-- override BOTH local print and global print
print = executorPrint
_G.print = executorPrint

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- COMMANDS
--////////////////////////////////////////////////////

local Commands = {}

local function addCommand(name, description, execute)
	Commands[#Commands + 1] = {
		Name = name,
		Description = description,
		Execute = execute
	}
end

addCommand("esp", "Displays a customizable nametag above every player displaying their username, health and distance from you in studs", function(distance)
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
end)

addCommand("unesp", "Turns off the customizable nametags above every player displaying their username, health and distance from you in studs.", function()
	print("[SUCCESS] Nametag system disabled")
	stopNametagSystem()
end)

addCommand("tpwalk", "Makes your character walk faster without speeding up any animations, usage: 'tpwalk 0.25' for a slight boost", function(multiplier)
	multiplier = tonumber(multiplier)
	if not multiplier then
		print("[FAIL] Invalid tpwalk multiplier value")
		return
	end

	print("[SUCCESS] Tpwalk enabled with multiplier:", multiplier)
	startTpWalk(multiplier)
end)

addCommand("untpwalk", "Removes any previously granted 'tpwalk' functions to the players character if there were any", function()
	print("[SUCCESS] Tpwalk disabled")
	stopTpWalk()
end)

addCommand("blink", "Teleports you x studs towards the direction your character is looking at.", function(distance)
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
end)

addCommand("hitbox", "Multiplies the hitbox area of the selected player or team, usage: 'hitbox username 2' or 'hitbox Engineering Department 2'", function(...)
	local args = {...}
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
end)

addCommand("resethitboxes", "Removes any previously expanded hitboxes to player characters if there were any", function()
	resetAllHitboxes()
	print("[SUCCESS] Reset all expanded hitboxes")
end)

addCommand("respawn", "Resets your roblox character - Sets your humanoid health to 0", function()
	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		print("[FAIL] Humanoid not found for respawn")
		return
	end

	humanoid.Health = 0
	print("[SUCCESS] Character respawned")
end)

addCommand("rejoin", "Rejoins the same server and re-executes the script if supported by your executor", function()
	executorPrint("[SUCCESS] Rejoining server...")

	local TeleportService = game:GetService("TeleportService")

	-- attempt to queue script for teleport
	if queue_on_teleport then
		queue_on_teleport([[
			loadstring(game:HttpGet("https://raw.githubusercontent.com/realuni/Roblox-Uni-s-.LuaU-Command-Executor/main/executor.lua"))()
		]])
	end

	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

addCommand("highlight", "Highlights the specified players making them visible through walls, and displaying their animations in real time", function(targetName, distance)
	targetName = tostring(targetName or "")
	if targetName == "" then
		print("[FAIL] Missing target name for highlight")
		return
	end

	if distance == nil or tostring(distance):match("^%s*$") then
		distance = math.huge
	else
		distance = tonumber(distance)
		if not distance then
			print("[FAIL] Invalid highlight distance value")
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
	print("[SUCCESS] Applied highlight to player:", targetPlayer.Name)
end)

addCommand("unhighlight", "Removes any previously added highlight effects to every player if there were any", function()
	resetAllHighlights()
	print("[SUCCESS] Removed all highlights")
end)

addCommand("help", "Shows all of the executable modules and briefly explains how they all work", function()
	print("[SUCCESS] Help list displayed")
	populateHelpList()
end)

addCommand("goto", "Teleports your player to the specified player, usage: 'goto username'", function(username)
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
end)

addCommand("view", "Teleports your player camera to the specified player, usage: 'view username'", function(username)
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
end)

addCommand("unview", "Teleports your player camera back to you, if you are spectating someone", function()
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
end)

addCommand("noclip", "Disables all collisions for your local player essentially letting you walk through walls", function()
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
end)

addCommand("clip", "Disables the noclip function", function()
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
end)

addCommand("sit", "Forces your player to sit on the nearest ground, to unsit simply jump once", function()
	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		print("[FAIL] Humanoid not found for sit")
		return
	end

	humanoid.Sit = true
	print("[SUCCESS] Character sitting")
end)

addCommand("fov", "Changes local fov (field of view), usage: 'fov 80'", function(amount)
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
end)

addCommand("resetfov", "Resets your local fov to the default one set by the owner of this experience", function()
	print("[SUCCESS] FOV reset to default")
	stopCustomFov()
end)

addCommand("fly", "Lets you fly around the game, usage: 'fly 100' For a decently fast flight, to unfly just execute the command 'unfly'", function(speed)
	if STATE.menuOpen then
		closeMenu()
	end

	if STATE.flyEnabled then
		print("[FAIL] Fly is already enabled")
		return
	end

	print("[SUCCESS] Fly enabled")
	startFly(speed)
end)

addCommand("unfly", "Stops your character from flying any longer unless you use the fly command again", function()
	if not STATE.flyEnabled then
		print("[FAIL] Fly is not currently enabled")
		return
	end

	print("[SUCCESS] Fly disabled")
	stopFly()
end)

addCommand("tracers", "Draws tracers, each one leading to different player, - tracer color is based on the players team color", function(distance)
	if STATE.tracersEnabled then
		print("[FAIL] Tracers are already enabled")
		return
	end

	print("[SUCCESS] Tracers enabled")
	startTracers(distance)
end)

addCommand("untracers", "Disables the tracers, each one leading to different player, - tracer color is based on the players team color", function()
	if not STATE.tracersEnabled then
		print("[FAIL] Tracers are not currently enabled")
		return
	end

	print("[SUCCESS] Tracers disabled")
	stopTracers()
end)

addCommand("freecam", "Lets you fly around in sort of a spectator mode, cool minecraft reference huh?", function(speed)
	if STATE.freecamEnabled then
		print("[FAIL] Freecam is already enabled")
		return
	end

	print("[SUCCESS] Freecam enabled")
	startFreecam(speed)
end)

addCommand("unfreecam", "Destroys your freecam and puts your camera back to your character", function()
	if not STATE.freecamEnabled then
		print("[FAIL] Freecam is not currently enabled")
		return
	end

	print("[SUCCESS] Freecam disabled")
	stopFreecam()
end)

addCommand("walkspeed", "Increases your walkspeed accordingly to what you specify within the command prompt", function(amount)
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
end)

addCommand("resetwalkspeed", "Resets your characters walkspeed to a default one set by the owner of this experience", function()
	print("[SUCCESS] Walkspeed reset to default")
	resetWalkSpeed()
end)

addCommand("jumpheight", "Increases your jumpheight accordingly to what you specify within the command prompt", function(amount)
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
end)

addCommand("resetjumpheight", "Resets your characters jumpheight to a default one set by the owner of this experience", function()
	print("[SUCCESS] Jumpheight reset to default")
	resetJumpHeight()
end)

addCommand("fullbright", "Illuminates your whole game, this is useful for playing at night!", function()
	if STATE.fullbrightEnabled then
		print("[FAIL] Fullbright is already enabled")
		return
	end

	print("[SUCCESS] Fullbright enabled")
	startFullbright()
end)

addCommand("unfullbright", "Resets the brightness to the default one set by the owner of this experience", function()
	if not STATE.fullbrightEnabled then
		print("[FAIL] Fullbright is not currently enabled")
		return
	end

	print("[SUCCESS] Fullbright disabled")
	stopFullbright()
end)

addCommand("esphighlight", "Combines both the esp and the highlight functions!", function(distance)
	if distance == nil or tostring(distance):match("^%s*$") then
		distance = math.huge
	else
		distance = tonumber(distance)
		if not distance then
			print("Invalid esphighlight distance")
			return
		end
	end

	startNametagSystem(distance)
	STATE.highlightMaxDistance = distance
	ensureHighlightTracking()
	STATE.highlightAllEnabled = true
	table.clear(STATE.highlightedPlayers)

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			applyHighlightToCharacter(player, player.Character)
		end
	end

	updateHighlightVisibility()
	print("Enabled esphighlight with distance:", distance == math.huge and "infinite" or distance)
end)

addCommand("unesphighlight", "Disables the combination of both the esp and the highlight functions!", function()
	stopNametagSystem()
	resetAllHighlights()
	print("Disabled esphighlight")
end)

addCommand("maxzoom", "Changes your camera's max zoom distance based on what you specify within the command prompt", function(amount)
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
end)

addCommand("defaultzoom", "Changes your camera's max zoom distance to the default settings set by the owner of this experience.", function()
	LocalPlayer.CameraMaxZoomDistance = STATE.defaultCameraMaxZoom
	print("[SUCCESS] Camera zoom reset to default:", STATE.defaultCameraMaxZoom)
end)

addCommand("teams", "Shows every team that exists in this experience", function()
	print("[SUCCESS] Teams list displayed")
	populateTeamsList()
end)

addCommand("destroy", "Destroys the entire system leaving no trace of use!", function()
	print("[SUCCESS] Executor system destroyed")
	destroyExecutorSystem()
end)

addCommand("hitboxtransparency", "Changes the transparency of player humanoid root parts (0-1), usage: hitboxtransparency {amount} {player/team/all}", function(...)
	local args = {...}
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
end)

addCommand("bind", "Binds a command to the specified key, usage: bind {key} {command}", function(...)
	local args = {...}
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

	table.remove(args, 1)
	local commandText = table.concat(args, " ")
	if commandText == "" then
		print("[FAIL] Missing command to bind")
		return
	end

	local lowerCommand = string.lower(commandText)

	if lowerCommand == "clickteleport" then
		STATE.ghostBinds[keyCode] = "clickteleport"
		print("[SUCCESS] Bound ghost command clickteleport to key:", keyName)
		return
	end

	if lowerCommand == "clickdelete" then
		STATE.ghostBinds[keyCode] = "clickdelete"
		print("[SUCCESS] Bound ghost command clickdelete to key:", keyName)
		return
	end

	if lowerCommand == "bind" or lowerCommand == "togglebind" or lowerCommand == "unbind" or lowerCommand == "clearbinds" then
		print("[FAIL] Cannot bind bind-related commands")
		return
	end

	STATE.keybinds[keyCode] = commandText
	saveBinds()
	print("[SUCCESS] Bound key", keyName, "to command:", commandText)
end)

addCommand("unbind", "Removes a keybind, usage: unbind {key}", function(key)
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

	if not STATE.keybinds[keyCode] and not STATE.toggleBinds[keyCode] and not STATE.ghostBinds[keyCode] then
		print("[FAIL] No bind found for key:", keyName)
		return
	end

	STATE.keybinds[keyCode] = nil
	STATE.toggleBinds[keyCode] = nil
	STATE.ghostBinds[keyCode] = nil
	saveBinds()

	print("[SUCCESS] Unbound key:", keyName)
end)

addCommand("binds", "Lets you view all of your previously created binds.", function()
	clearHelpEntries()
	exampleHelperTemplate.Visible = false

	local found = false

	local function createLine(text)
		local entry = exampleHelperTemplate:Clone()
		entry.Visible = true
		entry.Parent = helperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = string.format("<font color=\"rgb(227,227,227)\">%s</font>", text)
		end
	end

	for key, command in pairs(STATE.keybinds) do
		found = true
		createLine(key.Name .. " -> " .. command)
	end

	for key, ghost in pairs(STATE.ghostBinds) do
		found = true
		createLine(key.Name .. " -> " .. ghost .. " (ghost)")
	end

	for key, data in pairs(STATE.toggleBinds) do
		found = true
		createLine(key.Name .. " -> " .. data.onCommand .. " / " .. data.offCommand)
	end

	if not found then
		createLine("No binds set.")
	end

	helperBg.Visible = true
	print("[SUCCESS] Binds list displayed", false)
end)

addCommand("clearbinds", "Clears all of your previously created binds", function()
	table.clear(STATE.keybinds)
	table.clear(STATE.toggleBinds)
	table.clear(STATE.ghostBinds)
	saveBinds()

	print("[SUCCESS] All binds cleared")
end)

addCommand("togglebind", "Binds a toggleable command to the specified key", function(...)
	local args = {...}
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

	table.remove(args, 1)
	local commandText = table.concat(args, " ")
	if commandText == "" then
		print("[FAIL] Missing command to bind")
		return
	end

	local lowerCommand = string.lower(commandText)
	if lowerCommand == "bind" or lowerCommand == "togglebind" or lowerCommand == "unbind" or lowerCommand == "clearbinds" then
		print("[FAIL] Cannot bind bind-related commands")
		return
	end

	local togglePairs = {
		["fly"] = "unfly",
		["freecam"] = "unfreecam",
		["fullbright"] = "unfullbright",
		["tracers"] = "untracers",
		["esp"] = "unesp",
		["esphighlight"] = "unesphighlight",
		["tpwalk"] = "untpwalk",
		["noclip"] = "clip",
		["hitbox all"] = "resethitboxes",
		["highlight all"] = "unhighlight",
	}

	local offCommand = togglePairs[lowerCommand]
	local matchedCommand = lowerCommand

	if not offCommand then
		for onCmd, offCmd in pairs(togglePairs) do
			if string.sub(lowerCommand, 1, #onCmd) == onCmd then
				offCommand = offCmd
				matchedCommand = onCmd
				break
			end
		end
	end

	if not offCommand then
		print("[FAIL] Toggle command not supported. Use 'bind' for non-toggle commands.")
		return
	end

	STATE.toggleBinds[keyCode] = {
		onCommand = commandText,
		offCommand = offCommand,
		state = false
	}

	saveBinds()
	print("[SUCCESS] Toggle bind created:", keyName, "->", matchedCommand)
end)

addCommand("waypointcreate", "Creates a waypoint at your current position with the specified name", function(...)
	local args = {...}
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
end)

addCommand("waypointdelete", "Deletes the specified waypoint", function(...)
	local args = {...}
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
end)

addCommand("waypoints", "Shows all created waypoints", function()
	clearHelpEntries()
	exampleHelperTemplate.Visible = false

	local function createLine(text)
		local entry = exampleHelperTemplate:Clone()
		entry.Visible = true
		entry.Parent = helperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = string.format("<font color=\"rgb(227,227,227)\">%s</font>", text)
		end
	end

	local found = false
	for name in pairs(STATE.waypoints) do
		found = true
		createLine(name)
	end

	if not found then
		createLine("No waypoints created.")
	end

	helperBg.Visible = true
	print("[SUCCESS] Waypoints list displayed", false)
end)

addCommand("gotowaypoint", "Teleports you to the specified waypoint", function(...)
	local args = {...}
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
end)

addCommand("savewaypoints", "Manually saves all waypoints to file", function()
	if saveWaypoints() then
		print("[SUCCESS] Waypoints saved to file")
	else
		print("[FAIL] Could not save waypoints - executor API unavailable")
	end
end)

addCommand("showwaypoints", "Shows 3D markers for all waypoints with distance-based transparency", function()
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
end)

addCommand("hidewaypoints", "Hides all waypoint markers", function()
	if not STATE.waypointShowEnabled then
		print("[FAIL] Waypoints are already hidden")
		return
	end

	stopWaypointRendering()
	destroyWaypointMarkers()
	print("[SUCCESS] Hid all waypoint markers")
end)

addCommand("playerinfo", "Displays detailed information about the specified player", function(username)
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
end)

addCommand("clickteleport", "Ghost command - Teleports you to where you click when holding the bound key. Must be bound using the bind command.", function()
	print("[FAIL] This is a ghost command. You must bind it to a key first using: bind {key} clickteleport")
end)

addCommand("clickdelete", "Ghost command - Deletes the object you click when holding the bound key. Must be bound using the bind command.", function()
	print("[FAIL] This is a ghost command. You must bind it to a key first using: bind {key} clickdelete")
end)

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- HELPERS
--////////////////////////////////////////////////////

local COMMAND_DISPLAY_NAMES = {
	esp = "esp {distance}",
	tpwalk = "tpwalk {multiplier}",
	blink = "blink {distance}",
	hitbox = "hitbox {player/team} {multiplier}",
	highlight = "highlight {player/team/all} {distance}",
	goto = "goto {player}",
	view = "view {player}",
	fov = "fov {amount}",
	fly = "fly {speed}",
	tracers = "tracers {distance}",
	esphighlight = "esphighlight {distance}",
	unesphighlight = "unesphighlight",
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
}

local originalTexts = {
	[title1] = title1.Text,
	[title2] = "Welcome back, " .. LocalPlayer.Name .. ".",
	[title3] = title3.Text,
}

title2.Text = originalTexts[title2]

local function getCommandDisplayNameForHelp(cmd)
	return COMMAND_DISPLAY_NAMES[cmd.Name] or cmd.Name
end

clearHelpEntries = function()
	for _, child in ipairs(helperScrollingFrame:GetChildren()) do
		if child:IsA("Frame") and child ~= exampleHelperTemplate and string.sub(child.Name, 1, 12) ~= "PrintHelper_" then
			child:Destroy()
		end
	end
end

local function buildHelpEntryText(commandName, commandDescription)
	return string.format(
		"<font color=\"rgb(202,177,53)\">%s :</font> <font color=\"rgb(227,227,227)\">%s</font>",
		commandName,
		commandDescription
	)
end

populateHelpList = function()
	clearHelpEntries()
	exampleHelperTemplate.Visible = false

	for index = 1, #Commands do
		local cmd = Commands[index]
		local entry = exampleHelperTemplate:Clone()
		entry.Name = "HelpEntry_" .. index
		entry.Visible = true
		entry.Parent = helperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = buildHelpEntryText(getCommandDisplayNameForHelp(cmd), cmd.Description)
		end
	end

	helperBg.Visible = true
end

populatePlayerInfo = function(targetPlayer)
	clearHelpEntries()
	exampleHelperTemplate.Visible = false

	local function createLine(label, value)
		local entry = exampleHelperTemplate:Clone()
		entry.Visible = true
		entry.Parent = helperScrollingFrame
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

	helperBg.Visible = true
	print("[SUCCESS] Player info displayed", false)
end

populateTeamsList = function()
	clearHelpEntries()
	exampleHelperTemplate.Visible = false

	for index, team in ipairs(game:GetService("Teams"):GetTeams()) do
		local entry = exampleHelperTemplate:Clone()
		entry.Name = "TeamEntry_" .. index
		entry.Visible = true
		entry.Parent = helperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = string.format("<font color=\"rgb(227,227,227)\">%s</font>", team.Name)
		end
	end

	helperBg.Visible = true
end

hideHelpList = function()
	helperBg.Visible = false
	clearHelpEntries()
	exampleHelperTemplate.Visible = false
	exampleHelperTemplate.CommandLine.Text = "Command Name : Command Description"
end

local function tween(object, time, properties)
	local tw = TweenService:Create(object, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
	tw:Play()
	return tw
end

local function typewrite(label, fullText)
	label.Text = ""
	for i = 1, #fullText do
		label.Text = string.sub(fullText, 1, i)
		task.wait(CONFIG.TYPE_SPEED)
	end
end

local function fadeWelcomeOut()
	tween(welcome, CONFIG.FADE_TIME, {BackgroundTransparency = 1})
	tween(title1, CONFIG.FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1})
	tween(title2, CONFIG.FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1})
	tween(title3, CONFIG.FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1})

	task.wait(CONFIG.FADE_TIME)

	welcome.Visible = false
	title1.Visible = false
	title2.Visible = false
	title3.Visible = false
	STATE.welcomeFinished = true

	-- AUTO OPEN MENU AFTER REJOIN
	task.defer(function()
		if not STATE.menuOpen then
			openMenu()
		end
	end)
end


local function playWelcomeSequence()
	welcome.Visible = true
	title1.Visible = true
	title2.Visible = true
	title3.Visible = true

	welcome.BackgroundTransparency = 0.25
	title1.TextTransparency = 0
	title2.TextTransparency = 0
	title3.TextTransparency = 0
	title1.BackgroundTransparency = 1
	title2.BackgroundTransparency = 1
	title3.BackgroundTransparency = 1

	title1.Text = ""
	title2.Text = ""
	title3.Text = ""

	typewrite(title1, originalTexts[title1])
	task.wait(CONFIG.BETWEEN_TITLES_DELAY)
	typewrite(title2, originalTexts[title2])
	task.wait(CONFIG.BETWEEN_TITLES_DELAY)
	typewrite(title3, originalTexts[title3])
	task.wait(CONFIG.WELCOME_HOLD_TIME)

	fadeWelcomeOut()
end

local function clearSuggestionEntries()
	for _, child in ipairs(container:GetChildren()) do
		if child:IsA("Frame") and child ~= exampleSuggestionTemplate then
			child:Destroy()
		end
	end
end

local function resetSuggester()
	STATE.currentBestMatch = nil
	commandSuggester.Visible = false
	suggesterCommandName.Text = "Command Name"
	suggesterCommandDescription.Text = "Command Description Goes Here"
	clearSuggestionEntries()
	exampleSuggestionTemplate.Visible = false
	exampleSuggestionTemplate.CommandName.Text = "Command Name"
	exampleSuggestionTemplate.CommandName.TextColor3 = CONFIG.COLOR_NORMAL
end

local function resetInputAndSuggestions()
	commandInput.Text = ""
	commandInput.CursorPosition = -1
	resetSuggester()
end

local function normalize(str)
	return string.lower(tostring(str or ""))
end

local function getSearchText(str)
	return tostring(str or ""):gsub("^%s+", "")
end

local function scoreCommand(query, commandName)
	query = normalize(query)
	commandName = normalize(commandName)

	if query == "" then
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

	local score, qIndex, consecutive = 0, 1, 0

	for i = 1, #commandName do
		if qIndex <= #query and string.sub(commandName, i, i) == string.sub(query, qIndex, qIndex) then
			qIndex += 1
			consecutive += 1
			score += 20 + consecutive * 5
		else
			consecutive = 0
		end
	end

	return qIndex > #query and (300 + score - #commandName * 0.5) or -math.huge
end

local function getMatches(inputText)
	local ranked = {}

	for i = 1, #Commands do
		local cmd = Commands[i]
		local score = scoreCommand(inputText, cmd.Name)
		if score > -math.huge then
			ranked[#ranked + 1] = {Command = cmd, Score = score}
		end
	end

	table.sort(ranked, function(a, b)
		return a.Score == b.Score and #a.Command.Name < #b.Command.Name or a.Score > b.Score
	end)

	local results = {}
	for i = 1, math.min(CONFIG.MAX_SUGGESTIONS, #ranked) do
		results[i] = ranked[i].Command
	end

	return results
end

local function rebuildSuggestions(matches)
	clearSuggestionEntries()

	if #matches == 0 then
		commandSuggester.Visible = false
		STATE.currentBestMatch = nil
		exampleSuggestionTemplate.Visible = false
		return
	end

	STATE.currentBestMatch = matches[1]
	commandSuggester.Visible = true
	suggesterCommandName.Text = getCommandDisplayNameForHelp(STATE.currentBestMatch)
	suggesterCommandDescription.Text = STATE.currentBestMatch.Description
	exampleSuggestionTemplate.Visible = true

	for index = 1, #matches do
		local entry = index == 1 and exampleSuggestionTemplate or exampleSuggestionTemplate:Clone()
		if index ~= 1 then
			entry.Name = "Suggestion_" .. index
			entry.Visible = true
			entry.Parent = container
		end

		local entryLabel = entry:FindFirstChild("CommandName")
		if entryLabel then
			entryLabel.Text = getCommandDisplayNameForHelp(matches[index])
			entryLabel.TextColor3 =
				index == 1 and CONFIG.COLOR_SPOTLIGHT or CONFIG.COLOR_NORMAL
		end
	end
end

local function updateSuggestions()
	local text = getSearchText(commandInput.Text)
	if text == "" then
		resetSuggester()
		return
	end

	rebuildSuggestions(getMatches(string.split(text, " ")[1] or ""))
	suggesterCommandName.Text = STATE.currentBestMatch and getCommandDisplayNameForHelp(STATE.currentBestMatch) or "Command Name"
end

openMenu = function()
	STATE.menuOpen = true
	bg.Visible = true
	mainBg.BackgroundTransparency = 1

	resetInputAndSuggestions()
	hideHelpList()
	sanitizeCommandInput()
	tween(mainBg, 0.05, {BackgroundTransparency = 0.45})

	task.defer(function()
		if STATE.menuOpen then
			commandInput:CaptureFocus()
		end
	end)
end

closeMenu = function()
	STATE.menuOpen = false
	STATE.suppressRefocus = true
	commandInput:ReleaseFocus()

	tween(mainBg, 0.05, {BackgroundTransparency = 1}).Completed:Wait()

	bg.Visible = false
	STATE.suppressRefocus = false

	resetInputAndSuggestions()
	hideHelpList()
end

local function toggleMenu()
	if STATE.menuOpen then
		closeMenu()
	else
		openMenu()
	end

	task.defer(function()
		if commandInput.Text:find(";") then
			commandInput.Text = commandInput.Text:gsub(";", "")
			commandInput.CursorPosition = #commandInput.Text + 1
			updateSuggestions()
		end
	end)
end

local PERSISTENT_HELP_COMMANDS = {
	help = true,
	teams = true,
	binds = true,
	waypoints = true,
}

local TAB_FILL_COMMANDS = {
	esp = "esp ",
	tpwalk = "tpwalk ",
	blink = "blink ",
	hitbox = "hitbox ",
	highlight = "highlight ",
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
}

local function executeCommand(commandText)
	local cleaned = tostring(commandText or ""):gsub("^%s+", ""):gsub("%s+$", "")
	if cleaned == "" then
		commandInput.Text = ""
		commandInput.CursorPosition = -1
		updateSuggestions()
		return
	end

	local lowered = string.lower(cleaned)

	for i = 1, #Commands do
		local cmd = Commands[i]
		local cmdName = string.lower(cmd.Name)

		if lowered == cmdName or lowered:sub(1, #cmdName + 1) == cmdName .. " " then
			local argsText = cleaned:sub(#cmd.Name + 1):gsub("^%s+", "")
			local args = argsText ~= "" and string.split(argsText, " ") or nil

			if not PERSISTENT_HELP_COMMANDS[cmdName] then
				hideHelpList()
			end

			commandInput.Text = ""
			commandInput.CursorPosition = -1
			updateSuggestions()

			local ok, err
			if args then
				ok, err = pcall(cmd.Execute, table.unpack(args))
			else
				ok, err = pcall(cmd.Execute)
			end

			if not ok then
				warn("Command execution failed for '" .. cmd.Name .. "': " .. tostring(err))
			end

			task.defer(function()
				if STATE.menuOpen then
					commandInput:CaptureFocus()
				end
			end)

			return
		end
	end

	commandInput.Text = ""
	commandInput.CursorPosition = -1
	updateSuggestions()

	task.defer(function()
		if STATE.menuOpen then
			commandInput:CaptureFocus()
		end
	end)
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- INPUT HANDLING
--////////////////////////////////////////////////////

STATE.inputTextConnection = commandInput:GetPropertyChangedSignal("Text"):Connect(function()
	if STATE.menuOpen then
		sanitizeCommandInput()
		updateSuggestions()
	end
end)

STATE.inputFocusLostConnection = commandInput.FocusLost:Connect(function(enterPressed)
	if enterPressed and STATE.menuOpen then
		executeCommand(commandInput.Text)
		return
	end

	if STATE.menuOpen and not STATE.suppressRefocus then
		task.defer(function()
			if STATE.menuOpen then
				commandInput:CaptureFocus()
			end
		end)
	end
end)

STATE.inputBeganConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and not commandInput:IsFocused() then
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

		local boundCommand = STATE.keybinds[key]
		if boundCommand then
			executeCommand(boundCommand)
			return
		end
	end

	if input.KeyCode == Enum.KeyCode.Semicolon then
		if not STATE.welcomeFinished then
			return
		end

		toggleMenu()

		task.defer(function()
			sanitizeCommandInput()
			updateSuggestions()
		end)

		return
	end

	if not STATE.menuOpen then
		return
	end

	if input.KeyCode == Enum.KeyCode.Tab and commandInput:IsFocused() then
		local best = STATE.currentBestMatch
		if best then
			commandInput.Text = TAB_FILL_COMMANDS[best.Name] or best.Name
			commandInput.CursorPosition = #commandInput.Text + 1
			commandInput:CaptureFocus()
			updateSuggestions()
		end
		return
	end

	if gameProcessed then
		return
	end
end)

STATE.inputEndedConnection = UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == STATE.clickTeleportKey then
		stopClickTeleport()
	end

	if input.KeyCode == STATE.clickDeleteKey then
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

function startNametagSystem(renderDistance)
	STATE.nametagRenderDistance = renderDistance or math.huge

	if STATE.nametagSystemEnabled then
		return
	end

	STATE.nametagSystemEnabled = true

	local COLOR_HIGH = Color3.fromHex("#6eff69")
	local COLOR_MED = Color3.fromHex("#ff984a")
	local COLOR_LOW = Color3.fromHex("#ff6254")
	local SMOOTH_SPEED = 5

	local playerHPColors = {}
	local playerHitboxes = {}

	local function createBillboardGui(character)
		local head = character:WaitForChild("Head")
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

	local function setHitboxVisibility(character, isVisible)
		local adornments = playerHitboxes[character]
		if adornments then
			for i = 1, #adornments do
				local adorn = adornments[i]
				if adorn and adorn.Parent then
					adorn.Visible = isVisible
				end
			end
		end
	end

	local function createHitbox(character)
		if playerHitboxes[character] then
			for _, adorn in pairs(playerHitboxes[character]) do
				adorn:Destroy()
			end
		end

		playerHitboxes[character] = {}

		local root = character:FindFirstChild("HumanoidRootPart")
		if not root then
			return
		end

		local box = Instance.new("BoxHandleAdornment")
		box.Adornee = root
		box.AlwaysOnTop = true
		box.ZIndex = 10
		box.Size = root.Size
		box.Transparency = STATE.hitboxTransparency
		box.Color3 = root.Color
		box.Visible = true
		box.Parent = root

		playerHitboxes[character][1] = box
	end

	local function getHealthColor(health, maxHealth)
		local pct = health / maxHealth
		if pct > 0.75 then
			return COLOR_HIGH
		elseif pct > 0.5 then
			return COLOR_MED
		end
		return COLOR_LOW
	end

	local function lerpColor(c1, c2, a)
		return Color3.new(
			c1.R + (c2.R - c1.R) * a,
			c1.G + (c2.G - c1.G) * a,
			c1.B + (c2.B - c1.B) * a
		)
	end

	local renderConn = game:GetService("RunService").RenderStepped:Connect(function(dt)
		if not STATE.nametagSystemEnabled then
			return
		end

		local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not localRoot then
			return
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
				local humanoid = player.Character.Humanoid
				local head = player.Character:FindFirstChild("Head")
				if not head then
					continue
				end

				local distance = (head.Position - localRoot.Position).Magnitude
				local billboard = head:FindFirstChild("PlayerBillboardGui")
				local textLabel = billboard and billboard:FindFirstChildOfClass("TextLabel")

				if not playerHitboxes[player.Character] then
					createHitbox(player.Character)
				end

				if distance > STATE.nametagRenderDistance then
					if billboard then
						billboard.Enabled = false
					end
					setHitboxVisibility(player.Character, false)
					continue
				end

				if not textLabel then
					textLabel = createBillboardGui(player.Character)
					billboard = head:FindFirstChild("PlayerBillboardGui")
					playerHPColors[player] = COLOR_HIGH
				end

				if billboard then
					billboard.Enabled = true
				end

				setHitboxVisibility(player.Character, true)

				if humanoid.Health <= 0 then
					textLabel.Text = player.Name .. " - DEAD"
					setHitboxVisibility(player.Character, false)
					continue
				end

				local currentColor = lerpColor(
					playerHPColors[player] or COLOR_HIGH,
					getHealthColor(humanoid.Health, humanoid.MaxHealth),
					math.clamp(SMOOTH_SPEED * dt, 0, 1)
				)
				playerHPColors[player] = currentColor

				local teamColor = player.TeamColor.Color
				local teamColorHex = string.format(
					"#%02x%02x%02x",
					math.floor(teamColor.R * 255),
					math.floor(teamColor.G * 255),
					math.floor(teamColor.B * 255)
				)

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

				for _, adorn in pairs(playerHitboxes[player.Character] or {}) do
					if adorn.Adornee then
						adorn.Color3 = teamColor
						adorn.Size = adorn.Adornee.Size
					end
				end
			end
		end
	end)

	STATE.nametagConnections[#STATE.nametagConnections + 1] = renderConn
end

function stopNametagSystem()
	if not STATE.nametagSystemEnabled then
		return
	end

	STATE.nametagSystemEnabled = false

	for i = 1, #STATE.nametagConnections do
		local conn = STATE.nametagConnections[i]
		if conn then
			conn:Disconnect()
		end
	end
	table.clear(STATE.nametagConnections)

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

			for _, desc in ipairs(character:GetDescendants()) do
				if desc:IsA("BoxHandleAdornment") then
					desc:Destroy()
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

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- STARTUP
--////////////////////////////////////////////////////

local screenGui = bg:FindFirstAncestorOfClass("ScreenGui")
if screenGui then
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 999999
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

local function forceTopLayer(guiObject)
	for _, obj in ipairs(guiObject:GetDescendants()) do
		if obj:IsA("GuiObject") then
			obj.ZIndex = 1000
		end
	end
end

forceTopLayer(bg)

resetSuggester()
bg.Visible = false
helperBg.Visible = false
exampleHelperTemplate.Visible = false

startGlobalPlayerTracking()

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

task.spawn(playWelcomeSequence)

STATE.characterCleanupConnection = LocalPlayer.CharacterAdded:Connect(function()
	task.wait()

	cacheMovementDefaults()
	stopFly()
	stopTracers()
	stopFreecam()

	refreshWaypointMarkers()
end)
