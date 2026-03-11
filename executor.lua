
--// Made by reaIuni @ Roblox
--// Executable client-side command UI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- UI CREATION
--////////////////////////////////////////////////////

local commandExecutor = Instance.new("ScreenGui")
commandExecutor.Name = "CommandExecutor"

-- FORCE UI ABOVE EVERYTHING
commandExecutor.IgnoreGuiInset = true
commandExecutor.DisplayOrder = 999999
commandExecutor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
commandExecutor.IgnoreGuiInset = true
commandExecutor.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
commandExecutor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
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

local hitboxTransparencyAll = nil
local hitboxTransparencyPlayers = {}
local hitboxTransparencyTeams = {}
local hitboxTransparency = 0.9
local highlightObjects = {}
local highlightConnections = {}
local hitboxEnforcementConnection = nil
local hitboxSystemEnabled = false
local inputTextConnection = nil
local inputFocusLostConnection = nil
local inputBeganConnection = nil
local characterCleanupConnection = nil
local defaultCameraMaxZoom = LocalPlayer.CameraMaxZoomDistance
local highlightMaxDistance = math.huge
local highlightRenderConnection = nil
local freecamSavedWalkSpeed = nil
local freecamSavedJumpHeight = nil
local freecamSavedAutoRotate = nil
local freecamMouseConnection = nil
local freecamOriginalCameraType = nil
local freecamOriginalCameraSubject = nil
local freecamOriginalCameraCFrame = nil
local freecamOriginalCameraFocus = nil
local freecamOriginalMouseBehavior = nil
local freecamOriginalMouseIconEnabled = nil
local freecamPosition = nil
local freecamYaw = 0
local freecamPitch = 0
local freecamSensitivity = 0.0025
local freecamEnabled = false
local defaultWalkSpeed = nil
local defaultJumpHeight = nil
local fullbrightEnabled = false
local fullbrightBackup = nil
local fullbrightConnection = nil
local freecamConnection = nil
local tracersMaxDistance = math.huge
local tracerConnection = nil
local tracerFrames = {}
local defaultCameraFov = workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or 70
local flyEnabled = false
local flySpeed = 50
local flyConnection = nil
local flyBodyVelocity = nil
local flyBodyGyro = nil
local tracersEnabled = false
local TYPE_SPEED = 0.03
local BETWEEN_TITLES_DELAY = 0.2
local WELCOME_HOLD_TIME = 2
local FADE_TIME = 0.35
local MAX_SUGGESTIONS = 10
local COLOR_SPOTLIGHT = Color3.fromRGB(159, 182, 202)
local COLOR_NORMAL = Color3.fromRGB(106, 122, 135)
local menuOpen = false
local currentBestMatch = nil
local suppressRefocus = false
local welcomeFinished = false
local nametagSystemEnabled = false
local nametagConnections = {}
local startNametagSystem
local stopNametagSystem
local tpWalkEnabled = false
local tpWalkConnection = nil
local startTpWalk
local stopTpWalk
local originalHitboxSizes = {}
local originalHumanoidRootPartSizes = {}
local hitboxAllMultiplier = nil
local hitboxPlayerMultipliers = {}
local hitboxIgnoreOwnTeam = false
local hitboxCharacterConnections = {}
local hitboxPlayerAddedConnection = nil
local hitboxPlayerRemovingConnection = nil
local highlightedPlayers = {}
local highlightAllEnabled = false
local highlightCharacterConnections = {}
local highlightPlayerAddedConnection = nil
local originalHumanoidRootPartCanCollide = {}
local highlightTeamConnections = {}
local noclipEnabled = false
local noclipConnection = nil
local viewingPlayer = nil
local fovConnection = nil
local customFovValue = defaultCameraFov
local customFovEnabled = false
local customFovEnabled = false
local toggleBinds = {}
local keybinds = {}
local ghostBinds = {}
local clickTeleportConnection = nil
local clickTeleportKey = nil
local clickTeleportActive = false
local CLICKTP_MAX_DISTANCE = 2000
local CLICKTP_MIN_Y = -1000 -- anti void protection
local waypoints = {}
local WAYPOINT_FILE = "waypoints.json"
local BINDS_FILE = "binds.json"
local HttpService = game:GetService("HttpService")
local waypointMarkers = {}
local waypointBillboards = {}
local waypointRenderConnection = nil
local waypointShowEnabled = false
local startClickTeleport
local stopClickTeleport
local performClickTeleport

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- WAYPOINT STORAGE SYSTEM
--////////////////////////////////////////////////////

local function loadBinds()

	if not readfile or not isfile then
		return false
	end

	if not isfile(BINDS_FILE) then
		return false
	end

	local success, json = pcall(function()
		return readfile(BINDS_FILE)
	end)

	if not success or not json then
		return false
	end

	local success2, data = pcall(function()
		return HttpService:JSONDecode(json)
	end)

	if not success2 or not data then
		return false
	end

	-- LOAD NORMAL BINDS
	if data.keybinds then
		for keyName,command in pairs(data.keybinds) do
			local keyCode = Enum.KeyCode[keyName]
			if keyCode then
				keybinds[keyCode] = command
			end
		end
	end

	-- LOAD TOGGLE BINDS
	if data.togglebinds then
		for keyName,info in pairs(data.togglebinds) do
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

	return true
end

local function saveBinds()

	if not writefile then
		return false
	end

	local data = {
		keybinds = {},
		togglebinds = {}
	}

	-- NORMAL BINDS
	for key,command in pairs(keybinds) do
		data.keybinds[key.Name] = command
	end

	-- TOGGLE BINDS
	for key,info in pairs(toggleBinds) do
		data.togglebinds[key.Name] = {
			onCommand = info.onCommand,
			offCommand = info.offCommand
		}
	end

	local json = HttpService:JSONEncode(data)

	local success = pcall(function()
		writefile(BINDS_FILE, json)
	end)

	return success
end

local function saveWaypoints()
	-- Check if writefile is available (executor API)
	if not writefile then
		return false
	end

	-- Convert waypoints table to JSON
	local waypointData = {}
	for name, position in pairs(waypoints) do
		waypointData[name] = {
			x = position.X,
			y = position.Y,
			z = position.Z
		}
	end

	local jsonData = HttpService:JSONEncode(waypointData)

	-- Write to file
	local success, err = pcall(function()
		writefile(WAYPOINT_FILE, jsonData)
	end)

	return success
end

local function loadWaypoints()
	-- Check if readfile is available (executor API)
	if not readfile or not isfile then
		return false
	end

	-- Check if file exists
	if not isfile(WAYPOINT_FILE) then
		return false
	end

	-- Read file
	local success, jsonData = pcall(function()
		return readfile(WAYPOINT_FILE)
	end)

	if not success or not jsonData then
		return false
	end

	-- Parse JSON
	local success2, waypointData = pcall(function()
		return HttpService:JSONDecode(jsonData)
	end)

	if not success2 or not waypointData then
		return false
	end

	-- Load waypoints into table
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

local function createWaypointMarker(name, position)
	-- Create cylinder part
	local cylinder = Instance.new("Part")
	cylinder.Name = "WaypointMarker_" .. name
	cylinder.Size = Vector3.new(2048, 11, 6)
	cylinder.CFrame = CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90))
	cylinder.Material = Enum.Material.Neon
	cylinder.Color = Color3.fromRGB(212, 62, 62)
	cylinder.Transparency = 0
	cylinder.CanCollide = false
	cylinder.Anchored = true
	cylinder.Parent = workspace

	-- Create billboard part for text
	local billboardPart = Instance.new("Part")
	billboardPart.Name = "WaypointBillboard_" .. name
	billboardPart.Size = Vector3.new(1, 1, 1)
	billboardPart.Position = position
	billboardPart.Transparency = 1
	billboardPart.CanCollide = false
	billboardPart.Anchored = true
	billboardPart.Parent = workspace

	-- Create billboard gui
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "WaypointBillboardGui"
	billboardGui.Size = UDim2.new(0, 400, 0, 50)
	billboardGui.StudsOffset = Vector3.new(0, 3, 0)
	billboardGui.AlwaysOnTop = true
	billboardGui.Parent = billboardPart

	-- Create text label
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
	-- Destroy all cylinder markers
	for _, cylinder in pairs(waypointMarkers) do
		if cylinder and cylinder.Parent then
			cylinder:Destroy()
		end
	end
	table.clear(waypointMarkers)

	-- Destroy all billboard parts
	for _, billboardPart in pairs(waypointBillboards) do
		if billboardPart and billboardPart.Parent then
			billboardPart:Destroy()
		end
	end
	table.clear(waypointBillboards)
end
local function updateWaypointVisibility()
	if not waypointShowEnabled then
		return
	end

	local character = LocalPlayer.Character
	if not character then
		return
	end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then
		return
	end
	-- Update cylinder transparency based on distance
	for name, cylinder in pairs(waypointMarkers) do
		if not cylinder or not cylinder.Parent then
			continue
		end

		local distance = (cylinder.Position - root.Position).Magnitude

		-- Calculate transparency based on distance
		local transparency
		if distance <= 50 then
			transparency = 1
		elseif distance >= 400 then
			transparency = 0
		else
			-- Smooth transition from 0.95 at 50 studs to 0 at 400 studs
			local progress = (distance - 50) / (400 - 50)
			transparency = 0.95 * (1 - progress)
		end

		cylinder.Transparency = transparency
	end

	-- Update billboard text with distance
	for name, billboardPart in pairs(waypointBillboards) do
		if not billboardPart or not billboardPart.Parent then
			continue
		end

		local billboardGui = billboardPart:FindFirstChild("WaypointBillboardGui")
		if not billboardGui then
			continue
		end

		local textLabel = billboardGui:FindFirstChildOfClass("TextLabel")
		if not textLabel then
			continue
		end

		local distance = (billboardPart.Position - root.Position).Magnitude

		-- Format text with waypoint name in red and distance in white
		local waypointColorHex = string.format("#%02x%02x%02x", 212, 62, 62)
		textLabel.Text = string.format(
			"<font color=\"%s\">%s</font> - <font color=\"rgb(255,255,255)\">%.1f</font>",
			waypointColorHex,
			name,
			distance
		)
	end
end
local function startWaypointRendering()
	if waypointRenderConnection then
		return
	end

	local RunService = game:GetService("RunService")
	waypointRenderConnection = RunService.RenderStepped:Connect(function()
		if not waypointShowEnabled then
			return
		end

		updateWaypointVisibility()
	end)
end

local function stopWaypointRendering()
	waypointShowEnabled = false

	if waypointRenderConnection then
		waypointRenderConnection:Disconnect()
		waypointRenderConnection = nil
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

local function getCubeHitboxSize(originalSize, multiplier)
	local largestAxis = math.max(originalSize.X, originalSize.Y, originalSize.Z)
	local scaledSize = largestAxis * (1 + multiplier)
	return Vector3.new(scaledSize, scaledSize, scaledSize)
end

local function freezeCharacterForFreecam()
	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")

	if not humanoid then
		return
	end

	freecamSavedWalkSpeed = humanoid.WalkSpeed
	freecamSavedJumpHeight = humanoid.JumpHeight
	freecamSavedAutoRotate = humanoid.AutoRotate

	humanoid.WalkSpeed = 0
	humanoid.JumpHeight = 0
	humanoid.AutoRotate = false
	humanoid:Move(Vector3.zero, true)

	if root then
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end
end

local function unfreezeCharacterFromFreecam()
	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")

	if not humanoid then
		return
	end

	if freecamSavedWalkSpeed ~= nil then
		humanoid.WalkSpeed = freecamSavedWalkSpeed
	end

	if freecamSavedJumpHeight ~= nil then
		humanoid.JumpHeight = freecamSavedJumpHeight
	end

	if freecamSavedAutoRotate ~= nil then
		humanoid.AutoRotate = freecamSavedAutoRotate
	end

	humanoid:Move(Vector3.zero, true)

	if root then
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end
end

local function stopFreecam()
	freecamEnabled = false

	if freecamConnection then
		freecamConnection:Disconnect()
		freecamConnection = nil
	end

	if freecamMouseConnection then
		freecamMouseConnection:Disconnect()
		freecamMouseConnection = nil
	end

	local camera = workspace.CurrentCamera
	if camera then
		camera.CameraType = freecamOriginalCameraType or Enum.CameraType.Custom
		camera.CameraSubject = freecamOriginalCameraSubject
		camera.CFrame = freecamOriginalCameraCFrame or camera.CFrame
		camera.Focus = freecamOriginalCameraFocus or camera.Focus
	end

	UserInputService.MouseBehavior = freecamOriginalMouseBehavior or Enum.MouseBehavior.Default

	if freecamOriginalMouseIconEnabled == nil then
		UserInputService.MouseIconEnabled = true
	else
		UserInputService.MouseIconEnabled = freecamOriginalMouseIconEnabled
	end

	unfreezeCharacterFromFreecam()
end

local function startFreecam(speed)
	stopFreecam()

	if menuOpen then
		closeMenu()
	end

	speed = tonumber(speed)
	if not speed then
		speed = 50
	end

	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	freecamEnabled = true
	freezeCharacterForFreecam()

	freecamOriginalCameraType = camera.CameraType
	freecamOriginalCameraSubject = camera.CameraSubject
	freecamOriginalCameraCFrame = camera.CFrame
	freecamOriginalCameraFocus = camera.Focus
	freecamOriginalMouseBehavior = UserInputService.MouseBehavior
	freecamOriginalMouseIconEnabled = UserInputService.MouseIconEnabled

	freecamPosition = camera.CFrame.Position

	local lookVector = camera.CFrame.LookVector
	freecamPitch = math.asin(lookVector.Y)
	freecamYaw = math.atan2(-lookVector.X, -lookVector.Z)

	camera.CameraType = Enum.CameraType.Scriptable
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	UserInputService.MouseIconEnabled = false

	freecamMouseConnection = UserInputService.InputChanged:Connect(function(input, gameProcessed)
		if not freecamEnabled then
			return
		end
		-- CLICK TELEPORT EXECUTION
		if clickTeleportActive and input.UserInputType == Enum.UserInputType.MouseButton1 then
			if UserInputService:IsKeyDown(clickTeleportKey) then
				performClickTeleport()
			end
		end
		if gameProcessed then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement then
			freecamYaw -= input.Delta.X * freecamSensitivity
			freecamPitch -= input.Delta.Y * freecamSensitivity
			freecamPitch = math.clamp(freecamPitch, math.rad(-89), math.rad(89))
		end
	end)

	freecamConnection = game:GetService("RunService").RenderStepped:Connect(function(dt)
		if not freecamEnabled then
			return
		end

		local currentCamera = workspace.CurrentCamera
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

		local rotation = CFrame.fromOrientation(freecamPitch, freecamYaw, 0)
		local forward = rotation.LookVector
		local right = rotation.RightVector
		local up = Vector3.new(0, 1, 0)

		local moveDirection = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			moveDirection += forward
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			moveDirection -= forward
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			moveDirection -= right
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			moveDirection += right
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			moveDirection += up
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.C) then
			moveDirection -= up
		end

		local currentSpeed = speed
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
			currentSpeed = speed * 2
		end

		if moveDirection.Magnitude > 0 then
			moveDirection = moveDirection.Unit
			freecamPosition += moveDirection * currentSpeed * dt
		end

		local cameraCFrame = CFrame.new(freecamPosition) * rotation
		currentCamera.CFrame = cameraCFrame
		currentCamera.Focus = cameraCFrame * CFrame.new(0, 0, -512)
	end)
end

local function cacheMovementDefaults()
	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	if defaultWalkSpeed == nil then
		defaultWalkSpeed = humanoid.WalkSpeed
	end

	if defaultJumpHeight == nil then
		defaultJumpHeight = humanoid.JumpHeight
	end
end

local function setWalkSpeed(amount)
	amount = tonumber(amount)
	if not amount then
		print("Invalid walkspeed amount")
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
	humanoid.WalkSpeed = amount
end

local function resetWalkSpeed()
	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	cacheMovementDefaults()

	if defaultWalkSpeed ~= nil then
		humanoid.WalkSpeed = defaultWalkSpeed
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

	if defaultJumpHeight ~= nil then
		humanoid.JumpHeight = defaultJumpHeight
	end
end

local function stopFullbright()
	fullbrightEnabled = false

	if fullbrightConnection then
		fullbrightConnection:Disconnect()
		fullbrightConnection = nil
	end

	if fullbrightBackup then
		local lighting = game:GetService("Lighting")
		lighting.Brightness = fullbrightBackup.Brightness
		lighting.ClockTime = fullbrightBackup.ClockTime
		lighting.FogEnd = fullbrightBackup.FogEnd
		lighting.GlobalShadows = fullbrightBackup.GlobalShadows
		lighting.OutdoorAmbient = fullbrightBackup.OutdoorAmbient
		lighting.Ambient = fullbrightBackup.Ambient
	end
end

local function startFullbright()
	local lighting = game:GetService("Lighting")

	if not fullbrightBackup then
		fullbrightBackup = {
			Brightness = lighting.Brightness,
			ClockTime = lighting.ClockTime,
			FogEnd = lighting.FogEnd,
			GlobalShadows = lighting.GlobalShadows,
			OutdoorAmbient = lighting.OutdoorAmbient,
			Ambient = lighting.Ambient,
		}
	end

	stopFullbright()
	fullbrightEnabled = true

	local RunService = game:GetService("RunService")

	fullbrightConnection = RunService.RenderStepped:Connect(function()
		if not fullbrightEnabled then
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
	customFovEnabled = false

	if fovConnection then
		fovConnection:Disconnect()
		fovConnection = nil
	end

	local camera = workspace.CurrentCamera
	if camera then
		camera.FieldOfView = defaultCameraFov
	end
end

local function startCustomFov(amount)
	amount = tonumber(amount)
	if not amount then
		print("Invalid fov amount")
		return
	end

	customFovValue = amount
	customFovEnabled = true

	if fovConnection then
		fovConnection:Disconnect()
		fovConnection = nil
	end

	local RunService = game:GetService("RunService")

	fovConnection = RunService.RenderStepped:Connect(function()
		if not customFovEnabled then
			return
		end

		local camera = workspace.CurrentCamera
		if camera then
			camera.FieldOfView = customFovValue
		end
	end)
end

local function getTracerTargetPart(character)
	if not character then
		return nil
	end

	return character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")
		or character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("Head")
end


local function createTracerLine(player)
	local line = Instance.new("Frame")
	line.Name = "Tracer_" .. tostring(player.UserId)
	line.AnchorPoint = Vector2.new(0.5, 0.5)
	line.BorderSizePixel = 0
	line.BackgroundColor3 = player.TeamColor.Color
	line.Visible = false
	line.ZIndex = 999
	line.Parent = commandExecutor

	tracerFrames[player.UserId] = line
	return line
end

local function removeTracerLine(userId)
	local line = tracerFrames[userId]
	if line then
		line:Destroy()
		tracerFrames[userId] = nil
	end
end

local function clearAllTracers()
	for userId, line in pairs(tracerFrames) do
		if line then
			line:Destroy()
		end
		tracerFrames[userId] = nil
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
	line.Position = UDim2.fromOffset(
		(fromPos.X + toPos.X) * 0.5,
		(fromPos.Y + toPos.Y) * 0.5
	)
	line.Rotation = math.deg(math.atan2(delta.Y, delta.X))
end

function stopTracers()
	tracersEnabled = false
	tracersMaxDistance = math.huge

	if tracerConnection then
		tracerConnection:Disconnect()
		tracerConnection = nil
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

	tracersEnabled = true
	tracersMaxDistance = distance

	local RunService = game:GetService("RunService")
	local camera = workspace.CurrentCamera

	tracerConnection = RunService.RenderStepped:Connect(function()
		if not tracersEnabled then
			return
		end

		local localCharacter = LocalPlayer.Character
		local localRoot = getTracerTargetPart(localCharacter)

		if not localRoot then
			clearAllTracers()
			return
		end

		local localScreenPos, localOnScreen = camera:WorldToViewportPoint(localRoot.Position)

		if not localOnScreen or localScreenPos.Z <= 0 then
			for _, line in pairs(tracerFrames) do
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

				local line = tracerFrames[player.UserId]
				if not line then
					line = createTracerLine(player)
				end

				if not character or not humanoid or humanoid.Health <= 0 or not targetPart then
					line.Visible = false
					continue
				end

				local distanceToPlayer = (targetPart.Position - localRoot.Position).Magnitude
				if distanceToPlayer > tracersMaxDistance then
					line.Visible = false
					continue
				end

				local targetScreenPos, targetOnScreen = camera:WorldToViewportPoint(targetPart.Position)
				if not targetOnScreen or targetScreenPos.Z <= 0 then
					line.Visible = false
					continue
				end

				updateTracerFrame(
					line,
					tracerOrigin,
					Vector2.new(targetScreenPos.X, targetScreenPos.Y),
					player.TeamColor.Color
				)
			end
		end

		for userId, line in pairs(tracerFrames) do
			if not stillExists[userId] then
				removeTracerLine(userId)
			end
		end
	end)
end

local function getCharacterRoot(character)
	if not character then
		return nil
	end

	return character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")
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
	flyEnabled = false

	if flyConnection then
		flyConnection:Disconnect()
		flyConnection = nil
	end

	if flyBodyVelocity then
		flyBodyVelocity:Destroy()
		flyBodyVelocity = nil
	end

	if flyBodyGyro then
		flyBodyGyro:Destroy()
		flyBodyGyro = nil
	end

	local character = LocalPlayer.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart")

		if not noclipEnabled then
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
end

function startFly(speed)
	if menuOpen then
		closeMenu()
	end

	stopFly()

	speed = tonumber(speed)
	if not speed then
		speed = 50
	end

	flySpeed = speed
	flyEnabled = true

	local RunService = game:GetService("RunService")
	local camera = workspace.CurrentCamera

	local character = LocalPlayer.Character
	if not character then
		return
	end

	local root = getCharacterRoot(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not root or not humanoid then
		flyEnabled = false
		return
	end

	humanoid.PlatformStand = true
	setCharacterCollisionEnabled(character, false)

	flyBodyVelocity = Instance.new("BodyVelocity")
	flyBodyVelocity.Name = "ExecutorFlyVelocity"
	flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	flyBodyVelocity.P = 100000
	flyBodyVelocity.Velocity = Vector3.zero
	flyBodyVelocity.Parent = root

	flyBodyGyro = Instance.new("BodyGyro")
	flyBodyGyro.Name = "ExecutorFlyGyro"
	flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	flyBodyGyro.P = 100000
	flyBodyGyro.CFrame = camera.CFrame
	flyBodyGyro.Parent = root

	flyConnection = RunService.RenderStepped:Connect(function()
		if not flyEnabled then
			return
		end

		local currentCharacter = LocalPlayer.Character
		if not currentCharacter then
			stopFly()
			return
		end

		local currentRoot = getCharacterRoot(currentCharacter)
		local currentHumanoid = currentCharacter:FindFirstChildOfClass("Humanoid")
		if not currentRoot or not currentHumanoid or currentHumanoid.Health <= 0 then
			stopFly()
			return
		end

		if flyBodyVelocity == nil or flyBodyGyro == nil then
			stopFly()
			return
		end

		currentHumanoid.PlatformStand = true
		setCharacterCollisionEnabled(currentCharacter, false)

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
			moveDirection = moveDirection.Unit * flySpeed
		end

		flyBodyVelocity.Velocity = moveDirection
		flyBodyGyro.CFrame = CFrame.new(currentRoot.Position, currentRoot.Position + camCFrame.LookVector)
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

	if hitboxCharacterConnections[player] then
		hitboxCharacterConnections[player]:Disconnect()
		hitboxCharacterConnections[player] = nil
	end

	originalHumanoidRootPartSizes[player] = nil
	originalHumanoidRootPartCanCollide[player] = nil
	hitboxPlayerMultipliers[player.UserId] = nil
end

local function getActiveHitboxMultiplierForPlayer(player)
	if not player or player == LocalPlayer then
		return nil
	end

	if hitboxPlayerMultipliers[player.UserId] ~= nil then
		return hitboxPlayerMultipliers[player.UserId]
	end

	return hitboxAllMultiplier
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

	if not originalHumanoidRootPartSizes[player] then
		originalHumanoidRootPartSizes[player] = hrp.Size
	end

	if originalHumanoidRootPartCanCollide[player] == nil then
		originalHumanoidRootPartCanCollide[player] = hrp.CanCollide
	end

	hrp.Size = getCubeHitboxSize(originalHumanoidRootPartSizes[player], multiplier)
	hrp.CanCollide = false

	-- enforce hitbox appearance
	hrp.Transparency = hitboxTransparency or 0.95
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

	if originalHumanoidRootPartSizes[player] then
		hrp.Size = originalHumanoidRootPartSizes[player]
	end

	if originalHumanoidRootPartCanCollide[player] ~= nil then
		hrp.CanCollide = originalHumanoidRootPartCanCollide[player]
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

	if not humanoid or not hrp or not hrp:IsA("BasePart") then
		return
	end

	if humanoid.Health <= 0 then
		return
	end

	local multiplier = getActiveHitboxMultiplierForPlayer(player)

	if multiplier == nil then
		restoreHitboxForPlayer(player)
		return
	end

	if not originalHumanoidRootPartSizes[player] then
		originalHumanoidRootPartSizes[player] = hrp.Size
	end

	if originalHumanoidRootPartCanCollide[player] == nil then
		originalHumanoidRootPartCanCollide[player] = hrp.CanCollide
	end

	hrp.Size = getCubeHitboxSize(originalHumanoidRootPartSizes[player], multiplier)
	hrp.CanCollide = false

	-- enforce hitbox appearance
	hrp.Transparency = hitboxTransparency or 0.95
	hrp.Material = Enum.Material.SmoothPlastic

	if player.Team and player.Team.TeamColor then
		hrp.Color = player.Team.TeamColor.Color
	end
end

local function refreshAllActiveHitboxes()

	for _, player in ipairs(Players:GetPlayers()) do

		if player ~= LocalPlayer then

			local multiplier = hitboxPlayerMultipliers[player.UserId] or hitboxAllMultiplier

			-- IGNORE OWN TEAM (REALTIME)
			if hitboxIgnoreOwnTeam and player.Team == LocalPlayer.Team then
				restoreHitboxForPlayer(player)
				continue
			end

			-- APPLY HITBOX
			if multiplier then
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

	local team = player.Team

	local transparency = nil

	-- PLAYER SPECIFIC
	if hitboxTransparencyPlayers[player.UserId] ~= nil then
		transparency = hitboxTransparencyPlayers[player.UserId]
	end

	-- TEAM
	if team and hitboxTransparencyTeams[team.Name] ~= nil then
		transparency = hitboxTransparencyTeams[team.Name]
	end

	-- GLOBAL
	if transparency == nil and hitboxTransparencyAll ~= nil then
		transparency = hitboxTransparencyAll
	end

	if transparency == nil then
		root.Transparency = hitboxTransparency
		return
	end

	root.Transparency = transparency

	if player.Team and player.Team.TeamColor then
		root.Color = player.Team.TeamColor.Color
	end

end

local function stopHitboxEnforcement()
	hitboxSystemEnabled = false

	if hitboxEnforcementConnection then
		hitboxEnforcementConnection:Disconnect()
		hitboxEnforcementConnection = nil
	end
end

local function startHitboxEnforcement()
	if hitboxEnforcementConnection then
		return
	end
	hitboxSystemEnabled = true
	local RunService = game:GetService("RunService")
	hitboxEnforcementConnection = RunService.Heartbeat:Connect(function()

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then

				refreshHitboxForPlayer(player)

				-- enforce transparency every frame
				local character = player.Character
				if character then
					local hrp = character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.Transparency = hitboxTransparency or 0.95
					end
				end
			end
		end
	end)
end

local function hookHitboxCharacter(player)

	if not player or player == LocalPlayer then
		return
	end

	if hitboxCharacterConnections[player] then
		hitboxCharacterConnections[player]:Disconnect()
	end

	hitboxCharacterConnections[player] = player.CharacterAdded:Connect(function(character)

		originalHumanoidRootPartSizes[player] = nil
		originalHumanoidRootPartCanCollide[player] = nil

		task.wait(0.2)

		local multiplier = getActiveHitboxMultiplierForPlayer(player)

		if multiplier then
			refreshHitboxForPlayer(player)
			applyStoredHitboxTransparency(player)
		end

	end)

	-- If character already exists
	if player.Character then

		task.defer(function()

			local multiplier = getActiveHitboxMultiplierForPlayer(player)

			if multiplier then
				refreshHitboxForPlayer(player)
				applyStoredHitboxTransparency(player)
			end

		end)

	end

end

local function ensureHitboxTracking()

	if hitboxPlayerAddedConnection then
		return
	end

	-- PLAYER JOIN
	hitboxPlayerAddedConnection = Players.PlayerAdded:Connect(function(player)

		if player == LocalPlayer then
			return
		end

		hookHitboxCharacter(player)

		-- Apply hitbox if global multiplier exists
		task.defer(function()

			local multiplier = getActiveHitboxMultiplierForPlayer(player)

			if multiplier then
				refreshHitboxForPlayer(player)
				applyStoredHitboxTransparency(player)
			end

		end)

	end)

	-- PLAYER LEAVE
	if not hitboxPlayerRemovingConnection then
		hitboxPlayerRemovingConnection = Players.PlayerRemoving:Connect(function(player)
			cleanupHitboxPlayer(player)
		end)
	end

	-- EXISTING PLAYERS
	for _,player in ipairs(Players:GetPlayers()) do

		if player ~= LocalPlayer then

			hookHitboxCharacter(player)

			task.defer(function()

				local multiplier = getActiveHitboxMultiplierForPlayer(player)

				if multiplier then
					refreshHitboxForPlayer(player)
					applyStoredHitboxTransparency(player)
				end

			end)

		end

	end

	startHitboxEnforcement()

end

function applyHitboxToPlayer(player, multiplier)

	if hitboxIgnoreOwnTeam and player.Team == LocalPlayer.Team then
		hitboxPlayerMultipliers[player.UserId] = nil
		refreshHitboxForPlayer(player)
		return
	end

	hitboxPlayerMultipliers[player.UserId] = multiplier
	refreshHitboxForPlayer(player)

	-- FORCE TRANSPARENCY AFTER SIZE CHANGE
	applyStoredHitboxTransparency(player)

end

local function resetAllHitboxes()
	hitboxAllMultiplier = nil
	table.clear(hitboxPlayerMultipliers)

	stopHitboxEnforcement()

	for player, originalSize in pairs(originalHumanoidRootPartSizes) do
		if player and player.Parent then
			local character = player.Character
			if character then
				local hrp = character:FindFirstChild("HumanoidRootPart")
				if hrp and hrp:IsA("BasePart") then
					hrp.Size = originalSize

					if originalHumanoidRootPartCanCollide[player] ~= nil then
						hrp.CanCollide = originalHumanoidRootPartCanCollide[player]
					end
				end
			end
		end
	end

	table.clear(originalHumanoidRootPartSizes)
	table.clear(originalHumanoidRootPartCanCollide)
end

highlightAllEnabled = highlightAllEnabled or false
highlightMaxDistance = highlightMaxDistance or math.huge

local function removeHighlight(character)
	if highlightObjects[character] then
		highlightObjects[character]:Destroy()
		highlightObjects[character] = nil
	end
end

local function applyHighlightToCharacter(player, character)

	if not character then return end
	if player == LocalPlayer then return end

	if highlightObjects[character] then
		return
	end

	local highlight = Instance.new("Highlight")
	highlight.Name = "ExecutorHighlight"
	highlight.FillTransparency = 0.6
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

	-- TEAM COLOR
	local teamColor = player.TeamColor.Color
	highlight.FillColor = teamColor
	highlight.OutlineColor = teamColor

	highlight.Parent = character

	highlightObjects[character] = highlight
end

local function updateHighlightVisibility()

	local localCharacter = LocalPlayer.Character
	if not localCharacter then return end

	local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")
	if not localRoot then return end

	for character, highlight in pairs(highlightObjects) do

		if not character or not character.Parent then
			if highlight then
				highlight:Destroy()
			end
			highlightObjects[character] = nil
			continue
		end

		local player = game.Players:GetPlayerFromCharacter(character)

		if player then
			local teamColor = player.TeamColor.Color
			highlight.FillColor = teamColor
			highlight.OutlineColor = teamColor
		end

		local root = character:FindFirstChild("HumanoidRootPart")

		if not root then
			highlight.Enabled = false
			continue
		end

		local distance = (root.Position - localRoot.Position).Magnitude

		if distance <= highlightMaxDistance then
			highlight.Enabled = true
		else
			highlight.Enabled = false
		end

	end

end

function highlightPlayer(player)

	if player == LocalPlayer then return end

	local character = player.Character
	if character then
		applyHighlightToCharacter(player, character)
	end

end

function ensureHighlightTracking()

	if highlightConnections.tracking then
		return
	end

	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")

	-- character spawn tracking
	local function trackPlayer(player)

		player.CharacterAdded:Connect(function(character)
			task.wait()

			if highlightAllEnabled then
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

	highlightConnections.playerAdded = Players.PlayerAdded:Connect(function(player)
		trackPlayer(player)
	end)

	-- render loop like ESP
	highlightConnections.tracking = RunService.RenderStepped:Connect(function()
		updateHighlightVisibility()
	end)

end

function resetAllHighlights()

	highlightAllEnabled = false

	for character, highlight in pairs(highlightObjects) do
		if highlight then
			highlight:Destroy()
		end
	end

	table.clear(highlightObjects)

end

local function sanitizeCommandInput()
	local text = commandInput.Text
	local cleaned = text:gsub(";", ""):gsub("\t", "")

	if cleaned ~= text then
		local oldCursor = commandInput.CursorPosition
		commandInput.Text = cleaned

		if oldCursor and oldCursor > 0 then
			commandInput.CursorPosition = math.clamp(oldCursor - 1, 1, #cleaned + 1)
		else
			commandInput.CursorPosition = #cleaned + 1
		end
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

	if hitboxPlayerRemovingConnection then
		hitboxPlayerRemovingConnection:Disconnect()
		hitboxPlayerRemovingConnection = nil
	end

	noclipEnabled = false
	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end

	if inputTextConnection then
		inputTextConnection:Disconnect()
		inputTextConnection = nil
	end

	if inputFocusLostConnection then
		inputFocusLostConnection:Disconnect()
		inputFocusLostConnection = nil
	end

	if inputBeganConnection then
		inputBeganConnection:Disconnect()
		inputBeganConnection = nil
	end

	if characterCleanupConnection then
		characterCleanupConnection:Disconnect()
		characterCleanupConnection = nil
	end

	if hitboxPlayerAddedConnection then
		hitboxPlayerAddedConnection:Disconnect()
		hitboxPlayerAddedConnection = nil
	end

	for player, conn in pairs(hitboxCharacterConnections) do
		if conn then
			conn:Disconnect()
		end
		hitboxCharacterConnections[player] = nil
	end

	if highlightPlayerAddedConnection then
		highlightPlayerAddedConnection:Disconnect()
		highlightPlayerAddedConnection = nil
	end

	if highlightRenderConnection then
		highlightRenderConnection:Disconnect()
		highlightRenderConnection = nil
	end

	for player, conn in pairs(highlightCharacterConnections) do
		if conn then
			conn:Disconnect()
		end
		highlightCharacterConnections[player] = nil
	end

	for player, conn in pairs(highlightTeamConnections) do
		if conn then
			conn:Disconnect()
		end
		highlightTeamConnections[player] = nil
	end

	local character = LocalPlayer.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if defaultWalkSpeed ~= nil then
				humanoid.WalkSpeed = defaultWalkSpeed
			end
			if defaultJumpHeight ~= nil then
				humanoid.UseJumpPower = false
				humanoid.JumpHeight = defaultJumpHeight
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
	printHelperCounter = printHelperCounter + 1
	local helperId = printHelperCounter

	local entry = exampleHelperTemplate:Clone()
	entry.Name = "PrintHelper_" .. helperId
	entry.Visible = true
	entry.Parent = helperScrollingFrame
	entry.Size = UDim2.new(1, 0, 0, 28)
	entry.BackgroundTransparency = 0.45

	local label = entry:FindFirstChild("CommandLine")
	if label then
		label.RichText = true
		label.Text = string.format(
			"<font color=\"rgb(202,177,53)\">[EXEC]</font> <font color=\"rgb(227,227,227)\">%s</font>",
			text
		)
	end

	helperBg.Visible = true

	activePrintHelpers[helperId] = entry

	-- Only fade out if shouldFade is true (default behavior)
	if shouldFade ~= false then
		-- Fade out after 5 seconds
		task.spawn(function()
			task.wait(5)

			if activePrintHelpers[helperId] and activePrintHelpers[helperId].Parent then
				-- Quickly fade out
				local fadeTween = TweenService:Create(activePrintHelpers[helperId], 
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 1}
				)
				fadeTween:Play()

				-- Wait for fade to complete
				fadeTween.Completed:Wait()

				-- Destroy the frame so it's completely removed
				if activePrintHelpers[helperId] and activePrintHelpers[helperId].Parent then
					activePrintHelpers[helperId]:Destroy()
				end
			end

			-- Clean up tracking
			activePrintHelpers[helperId] = nil
		end)
	end

	return helperId
end

-- Override global print function
local originalPrint = print
_G.print = function(...)
	local args = {...}
	local text = ""
	for i, arg in ipairs(args) do
		if i > 1 then
			text = text .. " "
		end
		text = text .. tostring(arg)
	end

	-- Call original print for console output
	originalPrint(...)

	-- Create visual print helper
	createPrintHelper(text)
end

-- Create local print variable that points to our override
-- This ensures Commands table captures the correct print function
local print = _G.print

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- COMMANDS
--////////////////////////////////////////////////////

local Commands = {
	{
		Name = "esp",
		Description = "Displays a customizable nametag above every player displaying their username, health and distance from you in studs",
		Execute = function(distance)
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
		end,
	},
	{
		Name = "unesp",
		Description = "Turns off the customizable nametags above every player displaying their username, health and distance from you in studs.",
		Execute = function()
			print("[SUCCESS] Nametag system disabled")
			stopNametagSystem()
		end,
	},
	{
		Name = "tpwalk",
		Description = "Makes your character walk faster without speeding up any animations, usage: 'tpwalk 0.25' for a slight boost",
		Execute = function(multiplier)
			multiplier = tonumber(multiplier)

			if not multiplier then
				print("[FAIL] Invalid tpwalk multiplier value")
				return
			end

			print("[SUCCESS] Tpwalk enabled with multiplier:", multiplier)
			startTpWalk(multiplier)
		end,
	},
	{
		Name = "untpwalk",
		Description = "Removes any previously granted 'tpwalk' functions to the players character if there were any",
		Execute = function()
			print("[SUCCESS] Tpwalk disabled")
			stopTpWalk()
		end,
	},
	{
		Name = "blink",
		Description = "Teleports you x studs towards the direction your character is looking at.",
		Execute = function(distance)
			distance = tonumber(distance)

			if not distance then
				print("[FAIL] Invalid blink distance value")
				return
			end

			local character = LocalPlayer.Character
			if not character then
				print("[FAIL] Character not found for blink")
				return
			end

			local rootPart = character:FindFirstChild("HumanoidRootPart")
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

			rootPart.CFrame = CFrame.new(
				rootPart.Position + (flatForward * distance),
				rootPart.Position + (flatForward * distance) + flatForward
			)

			print("[SUCCESS] Teleported", distance, "studs forward")
		end,
	},
	{
		Name = "hitbox",
		Description = "Multiplies the hitbox area of the selected player or team, usage: 'hitbox username 2' or 'hitbox Engineering Department 2'",
		Execute = function(...)

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

			table.remove(args, #args)

			local targetName = table.concat(args, " ")

			if targetName == "" then
				print("[FAIL] Missing target name or team")
				return
			end

			ensureHitboxTracking()

			local Players = game:GetService("Players")
			local Teams = game:GetService("Teams")

			local lowerTarget = string.lower(targetName)

			-- APPLY TO TEAM
			for _, team in ipairs(Teams:GetTeams()) do
				if string.lower(team.Name) == lowerTarget then

					for _, player in ipairs(Players:GetPlayers()) do
						if player.Team == team and player ~= LocalPlayer then
							applyHitboxToPlayer(player, multiplier)
						end
					end

					hitboxSystemEnabled = true
					refreshAllActiveHitboxes()

					print("[SUCCESS] Applied hitbox multiplier", multiplier, "to team:", team.Name)
					return
				end
			end

			-- APPLY TO ALL
			if lowerTarget == "all" then

				hitboxAllMultiplier = multiplier

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer then
						hitboxPlayerMultipliers[player.UserId] = nil
					end
				end

				hitboxSystemEnabled = true
				refreshAllActiveHitboxes()

				print("[SUCCESS] Applied hitbox multiplier", multiplier, "to all players")
				return
			end

			-- APPLY TO SINGLE PLAYER
			local targetPlayer = findPlayerByName(targetName)

			if not targetPlayer then
				print("[FAIL] Player or team not found:", targetName)
				return
			end

			hitboxSystemEnabled = true
			applyHitboxToPlayer(targetPlayer, multiplier)

			print("[SUCCESS] Applied hitbox multiplier", multiplier, "to player:", targetPlayer.Name)

		end,
	},
	{
		Name = "resethitboxes",
		Description = "Removes any previously expanded hitboxes to player characters if there were any",
		Execute = function()
			resetAllHitboxes()
			print("[SUCCESS] Reset all expanded hitboxes")
		end,
	},
	{
		Name = "respawn",
		Description = "Resets your roblox character - Sets your humanoid health to 0",
		Execute = function()

			local character = LocalPlayer.Character
			if not character then
				print("[FAIL] Character not found for respawn")
				return
			end

			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				print("[FAIL] Humanoid not found for respawn")
				return
			end

			humanoid.Health = 0
			print("[SUCCESS] Character respawned")

		end,
	},
	{
		Name = "rejoin",
		Description = "After executing this command, you rejoin the exact same server",
		Execute = function()

			local TeleportService = game:GetService("TeleportService")

			local placeId = game.PlaceId
			local jobId = game.JobId

			print("[SUCCESS] Rejoining server...")
			TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)

		end,
	},
	{
		Name = "highlight",
		Description = "Highlights the specified players making them visible through walls, and displaying their animations in real time",
		Execute = function(targetName, distance)

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

			highlightMaxDistance = distance
			ensureHighlightTracking()

			local Players = game:GetService("Players")
			local Teams = game:GetService("Teams")

			local lowerTarget = string.lower(targetName)

			-- APPLY TO ALL
			if lowerTarget == "all" then

				highlightAllEnabled = true

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer then
						highlightPlayer(player)
					end
				end

				print("[SUCCESS] Applied highlights to all players with distance:", distance == math.huge and "infinite" or distance)
				return
			end

			-- APPLY TO TEAM
			for _, team in ipairs(Teams:GetTeams()) do
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

			-- APPLY TO SINGLE PLAYER
			local targetPlayer = findPlayerByName(targetName)

			if not targetPlayer then
				print("[FAIL] Player or team not found:", targetName)
				return
			end

			highlightPlayer(targetPlayer)

			print("[SUCCESS] Applied highlight to player:", targetPlayer.Name)

		end
	},
	{
		Name = "unhighlight",
		Description = "Removes any previously added highlight effects to every player if there were any",
		Execute = function()
			resetAllHighlights()
			print("[SUCCESS] Removed all highlights")
		end,
	},
	{
		Name = "help",
		Description = "Shows all of the executable modules and briefly explains how they all work",
		Execute = function()
			print("[SUCCESS] Help list displayed")
			populateHelpList()
		end,
	},
	{
		Name = "goto",
		Description = "Teleports your player to the specified player, usage: 'goto username'",
		Execute = function(username)

			if not username or username == "" then
				print("[FAIL] Missing username for goto command")
				return
			end

			local target = findPlayerByName(username)

			if not target then
				print("[FAIL] Player not found:", username)
				return
			end

			local character = LocalPlayer.Character
			local targetCharacter = target.Character

			if not character then
				print("[FAIL] Your character not found for goto")
				return
			end

			if not targetCharacter then
				print("[FAIL] Target character not found:", target.Name)
				return
			end

			local root = character:FindFirstChild("HumanoidRootPart")
			local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")

			if not root then
				print("[FAIL] Your HumanoidRootPart not found")
				return
			end

			if not targetRoot then
				print("[FAIL] Target HumanoidRootPart not found")
				return
			end

			root.CFrame = targetRoot.CFrame + Vector3.new(0,3,0)
			print("[SUCCESS] Teleported to player:", target.Name)

		end,
	},
	{
		Name = "view",
		Description = "Teleports your player camera to the specified player, usage: 'view username'",
		Execute = function(username)

			if not username or username == "" then
				print("[FAIL] Missing username for view command")
				return
			end

			local target = findPlayerByName(username)

			if not target then
				print("[FAIL] Player not found:", username)
				return
			end

			local camera = workspace.CurrentCamera

			if target.Character then
				local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					camera.CameraSubject = humanoid
					viewingPlayer = target
					print("[SUCCESS] Now viewing player:", target.Name)
				else
					print("[FAIL] Target humanoid not found")
				end
			else
				print("[FAIL] Target character not found")
			end

		end,
	},
	{
		Name = "unview",
		Description = "Teleports your player camera back to you, if you are spectating someone",
		Execute = function()

			local camera = workspace.CurrentCamera
			local character = LocalPlayer.Character

			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					camera.CameraSubject = humanoid
					print("[SUCCESS] Camera returned to your character")
				else
					print("[FAIL] Your humanoid not found")
				end
			else
				print("[FAIL] Your character not found")
			end

			viewingPlayer = nil

		end,
	},
	{
		Name = "noclip",
		Description = "Disables all collisions for your local player essentially letting you walk through walls",
		Execute = function()

			if noclipEnabled then
				print("[FAIL] Noclip is already enabled")
				return
			end

			local RunService = game:GetService("RunService")

			noclipEnabled = true

			noclipConnection = RunService.Stepped:Connect(function()

				local character = LocalPlayer.Character
				if not character then return end

				for _, part in ipairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end

			end)

			print("[SUCCESS] Noclip enabled")

		end,
	},
	{
		Name = "clip",
		Description = "Disables the noclip function",
		Execute = function()

			if not noclipEnabled then
				print("[FAIL] Noclip is not currently enabled")
				return
			end

			noclipEnabled = false

			if noclipConnection then
				noclipConnection:Disconnect()
				noclipConnection = nil
			end

			local character = LocalPlayer.Character
			if not character then return end

			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end

			print("[SUCCESS] Noclip disabled")

		end,
	},
	{
		Name = "sit",
		Description = "Forces your player to sit on the nearest ground, to unsit simply jump once",
		Execute = function()

			local character = LocalPlayer.Character
			if not character then
				print("[FAIL] Character not found for sit")
				return
			end

			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.Sit = true
				print("[SUCCESS] Character sitting")
			else
				print("[FAIL] Humanoid not found for sit")
			end

		end,
	},
	{
		Name = "fov",
		Description = "Changes local fov (field of view), usage: 'fov 80'",
		Execute = function(amount)
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
		end,
	},
	{
		Name = "resetfov",
		Description = "Resets your local fov to the default one set by the owner of this experience",
		Execute = function()
			print("[SUCCESS] FOV reset to default")
			stopCustomFov()
		end,
	},
	{
		Name = "fly",
		Description = "Lets you fly around the game, usage: 'fly 100' For a decently fast flight, to unfly just execute the command 'unfly'",
		Execute = function(speed)
			if menuOpen then
				closeMenu()
			end

			if flyEnabled then
				print("[FAIL] Fly is already enabled")
				return
			end

			print("[SUCCESS] Fly enabled")
			startFly(speed)
		end,
	},
	{
		Name = "unfly",
		Description = "Stops your character from flying any longer unless you use the fly command again",
		Execute = function()
			if not flyEnabled then
				print("[FAIL] Fly is not currently enabled")
				return
			end

			print("[SUCCESS] Fly disabled")
			stopFly()
		end,
	},
	{
		Name = "tracers",
		Description = "Draws tracers, each one leading to different player, - tracer color is based on the players team color",
		Execute = function(distance)
			if tracersEnabled then
				print("[FAIL] Tracers are already enabled")
				return
			end

			print("[SUCCESS] Tracers enabled")
			startTracers(distance)
		end,
	},
	{
		Name = "untracers",
		Description = "Disables the tracers, each one leading to different player, - tracer color is based on the players team color",
		Execute = function()
			if not tracersEnabled then
				print("[FAIL] Tracers are not currently enabled")
				return
			end

			print("[SUCCESS] Tracers disabled")
			stopTracers()
		end,
	},
	{
		Name = "freecam",
		Description = "Lets you fly around in sort of a spectator mode, cool minecraft reference huh?",
		Execute = function(speed)
			if freecamEnabled then
				print("[FAIL] Freecam is already enabled")
				return
			end

			print("[SUCCESS] Freecam enabled")
			startFreecam(speed)
		end,
	},
	{
		Name = "unfreecam",
		Description = "Destroys your freecam and puts your camera back to your character",
		Execute = function()
			if not freecamEnabled then
				print("[FAIL] Freecam is not currently enabled")
				return
			end

			print("[SUCCESS] Freecam disabled")
			stopFreecam()
		end,
	},
	{
		Name = "walkspeed",
		Description = "Increases your walkspeed accordingly to what you specify within the command prompt",
		Execute = function(amount)
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
		end,
	},
	{
		Name = "resetwalkspeed",
		Description = "Resets your characters walkspeed to a default one set by the owner of this experience",
		Execute = function()
			print("[SUCCESS] Walkspeed reset to default")
			resetWalkSpeed()
		end,
	},
	{
		Name = "jumpheight",
		Description = "Increases your jumpheight accordingly to what you specify within the command prompt",
		Execute = function(amount)
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
		end,
	},
	{
		Name = "resetjumpheight",
		Description = "Resets your characters jumpheight to a default one set by the owner of this experience",
		Execute = function()
			print("[SUCCESS] Jumpheight reset to default")
			resetJumpHeight()
		end,
	},
	{
		Name = "fullbright",
		Description = "Illuminates your whole game, this is useful for playing at night!",
		Execute = function()
			if fullbrightEnabled then
				print("[FAIL] Fullbright is already enabled")
				return
			end

			print("[SUCCESS] Fullbright enabled")
			startFullbright()
		end,
	},
	{
		Name = "unfullbright",
		Description = "Resets the brightness to the default one set by the owner of this experience",
		Execute = function()
			if not fullbrightEnabled then
				print("[FAIL] Fullbright is not currently enabled")
				return
			end

			print("[SUCCESS] Fullbright disabled")
			stopFullbright()
		end,
	},
	{
		Name = "esphighlight",
		Description = "Combines both the esp and the highlight functions!",
		Execute = function(distance)
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

			highlightMaxDistance = distance
			ensureHighlightTracking()

			highlightAllEnabled = true
			table.clear(highlightedPlayers)

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					applyHighlightToCharacter(player, player.Character)
				end
			end

			updateHighlightVisibility()

			print("Enabled esphighlight with distance:", distance == math.huge and "infinite" or distance)
		end,
	},
	{
		Name = "unesphighlight",
		Description = "Disables the combination of both the esp and the highlight functions!",
		Execute = function()
			stopNametagSystem()
			resetAllHighlights()
			print("Disabled esphighlight")
		end,
	},
	{
		Name = "maxzoom",
		Description = "Changes your camera's max zoom distance based on what you specify within the command prompt",
		Execute = function(amount)

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

		end,
	},
	{
		Name = "defaultzoom",
		Description = "Changes your camera's max zoom distance to the default settings set by the owner of this experience.",
		Execute = function()

			LocalPlayer.CameraMaxZoomDistance = defaultCameraMaxZoom

			print("[SUCCESS] Camera zoom reset to default:", defaultCameraMaxZoom)

		end,
	},
	{
		Name = "teams",
		Description = "Shows every team that exists in this experience",
		Execute = function()
			print("[SUCCESS] Teams list displayed")
			populateTeamsList()
		end,
	},

	{
		Name = "destroy",
		Description = "Destroys the entire system leaving no trace of use!",
		Execute = function()
			print("[SUCCESS] Executor system destroyed")
			destroyExecutorSystem()
		end,
	},
	{
		Name = "hitboxtransparency",
		Description = "Changes the transparency of player humanoid root parts (0-1), usage: hitboxtransparency {amount} {player/team/all}",
		Execute = function(...)

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

			amount = math.clamp(amount,0,1)

			local Players = game:GetService("Players")
			local Teams = game:GetService("Teams")

			if #args == 1 then
				args[2] = "all"
			end

			table.remove(args,1)
			local targetName = table.concat(args," ")
			local lowerTarget = string.lower(targetName)

			-- ALL
			if lowerTarget == "all" then

				hitboxTransparencyAll = amount
				table.clear(hitboxTransparencyPlayers)
				table.clear(hitboxTransparencyTeams)

				for _,player in ipairs(Players:GetPlayers()) do
					applyStoredHitboxTransparency(player)
				end

				print("Hitbox transparency set to",amount,"for all players")
				return
			end

			-- TEAM
			for _,team in ipairs(Teams:GetTeams()) do
				if string.lower(team.Name) == lowerTarget then

					hitboxTransparencyTeams[team.Name] = amount

					for _,player in ipairs(Players:GetPlayers()) do
						if player.Team == team then
							applyStoredHitboxTransparency(player)
						end
					end

					print("Hitbox transparency set to",amount,"for team:",team.Name)
					return
				end
			end

			-- PLAYER
			local targetPlayer = findPlayerByName(targetName)

			if not targetPlayer then
				print("Player or team not found:",targetName)
				return
			end

			hitboxTransparencyPlayers[targetPlayer.UserId] = amount
			applyStoredHitboxTransparency(targetPlayer)

			print("Hitbox transparency set to",amount,"for player:",targetPlayer.Name)

		end
	},
	{
		Name = "bind",
		Description = "Binds a command to the specified key, usage: bind {key} {command}",
		Execute = function(...)

			local args = {...}

			if #args < 2 then
				print("[FAIL] Usage: bind {key} {command}")
				return
			end

			local keyName = string.upper(args[1])
			table.remove(args,1)

			local commandText = table.concat(args," ")

			if commandText == "" then
				print("[FAIL] Missing command to bind")
				return
			end

			local keyCode = Enum.KeyCode[keyName]

			if not keyCode then
				print("[FAIL] Invalid key:",keyName)
				return
			end

			-- GHOST COMMANDS
			local lower = string.lower(commandText)

			if lower == "clickteleport" or lower == "clickdelete" then
				ghostBinds[keyCode] = lower
				print("[SUCCESS] Bound ghost command "..lower.." to key:", keyName)
				return
			end

			-- Prevent binding bind-related commands
			local lowerCommand = string.lower(commandText)
			if lowerCommand == "bind" or lowerCommand == "togglebind" or lowerCommand == "unbind" or lowerCommand == "clearbinds" then
				print("[FAIL] Cannot bind bind-related commands")
				return
			end

			local keyCode = Enum.KeyCode[keyName]

			if not keyCode then
				print("[FAIL] Invalid key:",keyName)
				return
			end

			keybinds[keyCode] = commandText
			saveBinds()

			print("[SUCCESS] Bound key",keyName,"to command:",commandText)

		end,
	},
	{
		Name = "unbind",
		Description = "Removes a keybind, usage: unbind {key}",
		Execute = function(key)

			if not key or key == "" then
				print("[FAIL] Usage: unbind {key}")
				return
			end

			local keyName = string.upper(key)
			local keyCode = Enum.KeyCode[keyName]

			if not keyCode then
				print("[FAIL] Invalid key:",keyName)
				return
			end

			if not keybinds[keyCode] and not toggleBinds[keyCode] then
				print("[FAIL] No bind found for key:",keyName)
				return
			end

			keybinds[keyCode] = nil
			toggleBinds[keyCode] = nil
			saveBinds()

			print("[SUCCESS] Unbound key:",keyName)

		end,
	},
	{
		Name = "binds",
		Description = "Lets you view all of your previously created binds.",
		Execute = function()

			clearHelpEntries()
			exampleHelperTemplate.Visible = false

			local found = false

			local function createLine(text)

				local entry = exampleHelperTemplate:Clone()
				entry.Visible = true
				entry.Parent = helperScrollingFrame
				entry.Size = UDim2.new(1,0,0,28)

				local label = entry:FindFirstChild("CommandLine")
				if label then
					label.RichText = true
					label.Text = string.format(
						"<font color=\"rgb(227,227,227)\">%s</font>",
						text
					)
				end

			end

			for key,command in pairs(keybinds) do
				found = true
				createLine(key.Name.." -> "..command)
			end

			for key,ghost in pairs(ghostBinds) do
				found = true
				createLine(key.Name.." -> "..ghost.." (ghost)")
			end

			for key,data in pairs(toggleBinds) do
				found = true
				createLine(key.Name.." -> "..data.onCommand.." / "..data.offCommand)
			end

			if not found then
				createLine("No binds set.")
			end

			helperBg.Visible = true
			print("[SUCCESS] Binds list displayed", false)  -- Don't fade this frame

		end,
	},
	{
		Name = "clearbinds",
		Description = "Clears all of your previously created binds",
		Execute = function()

			table.clear(keybinds)
			table.clear(toggleBinds)
			saveBinds()

			print("[SUCCESS] All binds cleared")

		end,
	},
	{
		Name = "togglebind",
		Description = "Binds a toggleable command to the specified key",
		Execute = function(...)

			local args = {...}

			if #args < 2 then
				print("[FAIL] Usage: togglebind {key} {command}")
				return
			end

			local keyName = string.upper(args[1])
			local keyCode = Enum.KeyCode[keyName]

			if not keyCode then
				print("[FAIL] Invalid key:",keyName)
				return
			end

			table.remove(args,1)

			local commandText = table.concat(args," ")

			if commandText == "" then
				print("[FAIL] Missing command to bind")
				return
			end

			-- Prevent binding bind-related commands
			local lowerCommand = string.lower(commandText)
			if lowerCommand == "bind" or lowerCommand == "togglebind" or lowerCommand == "unbind" or lowerCommand == "clearbinds" then
				print("[FAIL] Cannot bind bind-related commands")
				return
			end

			-- Map of commands to their off commands
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
				["highlight all"] = "unhighlight all",
				["hitboxtransparency all"] = "resethitboxes",
			}

			-- Try to find matching command (exact or partial)
			local offCommand = nil
			local matchedCommand = nil

			-- First try exact match
			if togglePairs[lowerCommand] then
				offCommand = togglePairs[lowerCommand]
				matchedCommand = lowerCommand
			else
				-- Try partial match (e.g., "highlight" matches "highlight all")
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

			toggleBinds[keyCode] = {
				onCommand = commandText,
				offCommand = offCommand,
				state = false,
				saveBinds()
			}

			print("[SUCCESS] Toggle bind created:",keyName,"->",matchedCommand)

		end,
	},
	{
		Name = "waypointcreate",
		Description = "Creates a waypoint at your current position with the specified name",
		Execute = function(...)
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

			-- Check if waypoint already exists
			if waypoints[waypointName] then
				print("[FAIL] Waypoint already exists:", waypointName)
				return
			end

			-- Get character position
			local character = LocalPlayer.Character
			if not character then
				print("[FAIL] Character not found")
				return
			end

			local root = character:FindFirstChild("HumanoidRootPart")
			if not root then
				print("[FAIL] HumanoidRootPart not found")
				return
			end

			-- Save waypoint
			waypoints[waypointName] = root.Position

			-- Save to file
			if saveWaypoints() then
				print("[SUCCESS] Waypoint created and saved:", waypointName)
			else
				print("[SUCCESS] Waypoint created (not saved - executor API unavailable):", waypointName)
			end
		end,
	},
	{
		Name = "waypointdelete",
		Description = "Deletes the specified waypoint",
		Execute = function(...)
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

			-- Check if waypoint exists
			if not waypoints[waypointName] then
				print("[FAIL] Waypoint not found:", waypointName)
				return
			end

			-- Delete waypoint
			waypoints[waypointName] = nil

			-- Save to file
			if saveWaypoints() then
				print("[SUCCESS] Waypoint deleted and saved:", waypointName)
			else
				print("[SUCCESS] Waypoint deleted (not saved - executor API unavailable):", waypointName)
			end
		end,
	},
	{
		Name = "waypoints",
		Description = "Shows all created waypoints",
		Execute = function()
			clearHelpEntries()
			exampleHelperTemplate.Visible = false

			local function createLine(text)
				local entry = exampleHelperTemplate:Clone()
				entry.Visible = true
				entry.Parent = helperScrollingFrame
				entry.Size = UDim2.new(1,0,0,28)

				local label = entry:FindFirstChild("CommandLine")
				if label then
					label.RichText = true
					label.Text = string.format(
						"<font color=\"rgb(227,227,227)\">%s</font>",
						text
					)
				end
			end

			local found = false
			for name, position in pairs(waypoints) do
				found = true
				createLine(name)
			end

			if not found then
				createLine("No waypoints created.")
			end

			helperBg.Visible = true
			print("[SUCCESS] Waypoints list displayed", false)  -- Don't fade this frame
		end,
	},
	{
		Name = "gotowaypoint",
		Description = "Teleports you to the specified waypoint",
		Execute = function(...)
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

			-- Check if waypoint exists
			if not waypoints[waypointName] then
				print("[FAIL] Waypoint not found:", waypointName)
				return
			end

			-- Get character
			local character = LocalPlayer.Character
			if not character then
				print("[FAIL] Character not found")
				return
			end

			local root = character:FindFirstChild("HumanoidRootPart")
			if not root then
				print("[FAIL] HumanoidRootPart not found")
				return
			end

			-- Teleport to waypoint
			root.CFrame = CFrame.new(waypoints[waypointName])

			print("[SUCCESS] Teleported to waypoint:", waypointName)
		end,
	},
	{
		Name = "savewaypoints",
		Description = "Manually saves all waypoints to file",
		Execute = function()
			if saveWaypoints() then
				print("[SUCCESS] Waypoints saved to file")
			else
				print("[FAIL] Could not save waypoints - executor API unavailable")
			end
		end,
	},
	{
		Name = "showwaypoints",
		Description = "Shows 3D markers for all waypoints with distance-based transparency",
		Execute = function()
			if waypointShowEnabled then
				print("[FAIL] Waypoints are already shown")
				return
			end

			-- Destroy existing markers first
			destroyWaypointMarkers()

			-- Create new markers for all waypoints
			for name, position in pairs(waypoints) do
				local cylinder, billboardPart = createWaypointMarker(name, position)
				waypointMarkers[name] = cylinder
				waypointBillboards[name] = billboardPart
			end

			waypointShowEnabled = true
			startWaypointRendering()

			print("[SUCCESS] Showing waypoint markers for", #waypoints, "waypoints")
		end,
	},
	{
		Name = "hidewaypoints",
		Description = "Hides all waypoint markers",
		Execute = function()
			if not waypointShowEnabled then
				print("[FAIL] Waypoints are already hidden")
				return
			end

			stopWaypointRendering()
			destroyWaypointMarkers()

			print("[SUCCESS] Hid all waypoint markers")
		end,
	},
	{
		Name = "playerinfo",
		Description = "Displays detailed information about the specified player",
		Execute = function(username)

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

		end,
	},
	clickteleport = {
		Name = "clickteleport",
		Description = "Teleport to clicked position (ghost command – requires bind)",
		Ghost = true,
		Execute = function()
			print("[FAIL] clickteleport is a ghost command and must be bound to a key.")
		end
	},

	clickdelete = {
		Name = "clickdelete",
		Description = "Delete clicked object (ghost command – requires bind)",
		Ghost = true,
		Execute = function()
			print("[FAIL] clickdelete is a ghost command and must be bound to a key.")
		end
	},
}

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- HELPERS
--////////////////////////////////////////////////////

local function getCommandDisplayNameForHelp(cmd)
	if cmd.Name == "esp" then
		return "esp {distance}"
	elseif cmd.Name == "hitboxtransparency" then
		return "hitboxtransparency {amount}"
	elseif cmd.Name == "destroy" then
		return "destroy"
	elseif cmd.Name == "tpwalk" then
		return "tpwalk {multiplier}"
	elseif cmd.Name == "blink" then
		return "blink {distance}"
	elseif cmd.Name == "hitbox" then
		return "hitbox {player/team} {multiplier}"
	elseif cmd.Name == "highlight" then
		return "highlight {player/team/all} {distance}"
	elseif cmd.Name == "goto" then
		return "goto {player}"
	elseif cmd.Name == "view" then
		return "view {player}"
	elseif cmd.Name == "fov" then
		return "fov {amount}"
	elseif cmd.Name == "fly" then
		return "fly {speed}"
	elseif cmd.Name == "tracers" then
		return "tracers {distance}"
	elseif cmd.Name == "esphighlight" then
		return "esphighlight {distance}"
	elseif cmd.Name == "freecam" then
		return "freecam {speed}"
	elseif cmd.Name == "walkspeed" then
		return "walkspeed {amount}"
	elseif cmd.Name == "jumpheight" then
		return "jumpheight {amount}"
	elseif cmd.Name == "maxzoom" then
		return "maxzoom {amount}"
	elseif cmd.Name == "hitboxtransparency" then
		return "hitboxtransparency {amount} {player/team/all}"
	elseif cmd.Name == "togglebind" then
		return "togglebind {key} {command}"
	elseif cmd.Name == "bind" then
		return "bind {key} {command}"
	elseif cmd.Name == "unbind" then
		return "unbind {key}"
	elseif cmd.Name == "waypointcreate" then
		return "waypointcreate {name}"
	elseif cmd.Name == "waypointdelete" then
		return "waypointdelete {name}"
	elseif cmd.Name == "gotowaypoint" then
		return "gotowaypoint {name}"
	else
		return cmd.Name
	end
end

clearHelpEntries = function()
	for _, child in ipairs(helperScrollingFrame:GetChildren()) do
		-- Only preserve print helper frames (they start with "PrintHelper_")
		-- Destroy everything else including HelpEntry, TeamEntry, etc.
		if child:IsA("Frame") and child ~= exampleHelperTemplate and not (string.sub(child.Name, 1, 13) == "PrintHelper_") then
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

	for index, cmd in ipairs(Commands) do
		local entry = exampleHelperTemplate:Clone()
		entry.Name = "HelpEntry_" .. index
		entry.Visible = true
		entry.Parent = helperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)

		local label = entry:FindFirstChild("CommandLine")
		if label then
			label.RichText = true
			label.Text = buildHelpEntryText(
				getCommandDisplayNameForHelp(cmd),
				cmd.Description
			)
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
		entry.Size = UDim2.new(1,0,0,28)

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

	-- BASIC INFO
	createLine("Display Name", targetPlayer.DisplayName)
	createLine("Username", targetPlayer.Name)
	createLine("UserId", targetPlayer.UserId)

	-- ACCOUNT AGE → JOIN DATE
	local accountAgeDays = targetPlayer.AccountAge
	local joinDate = os.date("%Y-%m-%d", os.time() - (accountAgeDays * 86400))
	createLine("Join Date", joinDate)

	-- TEAM
	if targetPlayer.Team then
		createLine("Team", targetPlayer.Team.Name)
	else
		createLine("Team", "None")
	end

	-- CHARACTER DATA
	local character = targetPlayer.Character
	local localCharacter = LocalPlayer.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart")

		if humanoid then
			createLine("Health", math.floor(humanoid.Health))
		else
			createLine("Health", "Unknown")
		end

		if root and localCharacter then
			local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")

			if localRoot then
				local distance = (root.Position - localRoot.Position).Magnitude
				createLine("Distance", string.format("%.1f studs", distance))
			end
		end
	end

	helperBg.Visible = true
	print("[SUCCESS] Player info displayed", false)

end

populateTeamsList = function()

	clearHelpEntries()

	exampleHelperTemplate.Visible = false

	local Teams = game:GetService("Teams")

	for index, team in ipairs(Teams:GetTeams()) do

		local entry = exampleHelperTemplate:Clone()
		entry.Name = "TeamEntry_" .. index
		entry.Visible = true
		entry.Parent = helperScrollingFrame
		entry.Size = UDim2.new(1, 0, 0, 28)

		local label = entry:FindFirstChild("CommandLine")

		if label then
			label.RichText = true

			label.Text = string.format(
				"<font color=\"rgb(227,227,227)\">%s</font>",
				team.Name
			)
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

local originalTexts = {
	[title1] = title1.Text,
	[title2] = "Welcome back, " .. LocalPlayer.Name .. ".",
	[title3] = title3.Text,
}

title2.Text = originalTexts[title2]

local function tween(object, time, properties)
	local info = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tw = TweenService:Create(object, info, properties)
	tw:Play()
	return tw
end

local function typewrite(label, fullText)
	label.Text = ""
	for i = 1, #fullText do
		label.Text = string.sub(fullText, 1, i)
		task.wait(TYPE_SPEED)
	end
end

local function fadeWelcomeOut()
	local tweens = {}

	table.insert(tweens, tween(welcome, FADE_TIME, {BackgroundTransparency = 1}))
	table.insert(tweens, tween(title1, FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1}))
	table.insert(tweens, tween(title2, FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1}))
	table.insert(tweens, tween(title3, FADE_TIME, {TextTransparency = 1, BackgroundTransparency = 1}))

	task.wait(FADE_TIME)

	welcome.Visible = false
	title1.Visible = false
	title2.Visible = false
	title3.Visible = false

	welcomeFinished = true
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
	task.wait(BETWEEN_TITLES_DELAY)

	typewrite(title2, originalTexts[title2])
	task.wait(BETWEEN_TITLES_DELAY)

	typewrite(title3, originalTexts[title3])
	task.wait(WELCOME_HOLD_TIME)

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
	currentBestMatch = nil
	commandSuggester.Visible = false
	suggesterCommandName.Text = "Command Name"
	suggesterCommandDescription.Text = "Command Description Goes Here"
	clearSuggestionEntries()
	exampleSuggestionTemplate.Visible = false
	exampleSuggestionTemplate.CommandName.Text = "Command Name"
	exampleSuggestionTemplate.CommandName.TextColor3 = COLOR_NORMAL
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
	str = tostring(str or "")
	str = str:gsub("^%s+", "")
	return str
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
		return 300 + score - (#commandName * 0.5)
	end

	return -math.huge
end

local function getMatches(inputText)
	local ranked = {}

	for _, cmd in ipairs(Commands) do
		local score = scoreCommand(inputText, cmd.Name)
		if score > -math.huge then
			table.insert(ranked, {
				Command = cmd,
				Score = score,
			})
		end
	end

	table.sort(ranked, function(a, b)
		if a.Score == b.Score then
			return #a.Command.Name < #b.Command.Name
		end
		return a.Score > b.Score
	end)

	local results = {}
	for i = 1, math.min(MAX_SUGGESTIONS, #ranked) do
		table.insert(results, ranked[i].Command)
	end

	return results
end

local function rebuildSuggestions(matches)
	clearSuggestionEntries()

	if #matches == 0 then
		commandSuggester.Visible = false
		currentBestMatch = nil
		exampleSuggestionTemplate.Visible = false
		return
	end

	currentBestMatch = matches[1]
	commandSuggester.Visible = true

	suggesterCommandName.Text = currentBestMatch.Name
	suggesterCommandDescription.Text = currentBestMatch.Description

	exampleSuggestionTemplate.Visible = true

	for index, cmd in ipairs(matches) do
		local entry
		if index == 1 then
			entry = exampleSuggestionTemplate
		else
			entry = exampleSuggestionTemplate:Clone()
			entry.Name = "Suggestion_" .. index
			entry.Visible = true
			entry.Parent = container
		end

		local entryLabel = entry:FindFirstChild("CommandName")
		if entryLabel then
			local displayName = cmd.Name

			if cmd.Name == "esp" then
				displayName = "esp {distance}"

			elseif cmd.Name == "tpwalk" then
				displayName = "tpwalk {multiplier}"

			elseif cmd.Name == "blink" then
				displayName = "blink {distance}"

			elseif cmd.Name == "hitbox" then
				displayName = "hitbox {player/team} {multiplier}"

			elseif cmd.Name == "highlight" then
				displayName = "highlight {player/team/all} {distance}"

			elseif cmd.Name == "esphighlight" then
				displayName = "esphighlight {distance}"

			elseif cmd.Name == "unesphighlight" then
				displayName = "unesphighlight"

			elseif cmd.Name == "goto" then
				displayName = "goto {player}"

			elseif cmd.Name == "view" then
				displayName = "view {player}"

			elseif cmd.Name == "noclip" then
				displayName = "noclip"

			elseif cmd.Name == "clip" then
				displayName = "clip"

			elseif cmd.Name == "sit" then
				displayName = "sit"

			elseif cmd.Name == "unview" then
				displayName = "unview"

			elseif cmd.Name == "resethitboxes" then
				displayName = "resethitboxes"

			elseif cmd.Name == "unhighlight" then
				displayName = "unhighlight"

			elseif cmd.Name == "fov" then
				displayName = "fov {amount}"

			elseif cmd.Name == "resetfov" then
				displayName = "resetfov"

			elseif cmd.Name == "fly" then
				displayName = "fly {speed}"

			elseif cmd.Name == "unfly" then
				displayName = "unfly"

			elseif cmd.Name == "tracers" then
				displayName = "tracers {distance}"

			elseif cmd.Name == "untracers" then
				displayName = "untracers"

			elseif cmd.Name == "unfreecam" then
				displayName = "unfreecam"

			elseif cmd.Name == "walkspeed" then
				displayName = "walkspeed {amount}"

			elseif cmd.Name == "resetwalkspeed" then
				displayName = "resetwalkspeed"

			elseif cmd.Name == "jumpheight" then
				displayName = "jumpheight {amount}"

			elseif cmd.Name == "resetjumpheight" then
				displayName = "resetjumpheight"

			elseif cmd.Name == "fullbright" then
				displayName = "fullbright"

			elseif cmd.Name == "unfullbright" then
				displayName = "unfullbright"

			elseif cmd.Name == "freecam" then
				displayName = "freecam {speed}"

			elseif cmd.Name == "unfreecam" then
				displayName = "unfreecam"

			elseif cmd.Name == "maxzoom" then
				displayName = "maxzoom {amount}"

			elseif cmd.Name == "defaultzoom" then
				displayName = "defaultzoom"

			elseif cmd.Name == "hitboxtransparency" then
				displayName = "hitboxtransparency {amount} {player/team/all}"

			elseif cmd.Name == "togglebind" then
				displayName = "togglebind {key} {command}"

			elseif cmd.Name == "bind" then
				displayName = "bind {key} {command}"

			elseif cmd.Name == "unbind" then
				displayName = "unbind {key}"

			elseif cmd.Name == "destroy" then
				displayName = "destroy"

			elseif cmd.Name == "waypointcreate" then
				displayName = "waypointcreate {name}"

			elseif cmd.Name == "waypointdelete" then
				displayName = "waypointdelete {name}"

			elseif cmd.Name == "gotowaypoint" then
				displayName = "gotowaypoint {name}"

			elseif cmd.Name == "playerinfo" then
				displayName = "playerinfo {player}"
			end

			entryLabel.Text = displayName
			entryLabel.TextColor3 = (index == 1) and COLOR_SPOTLIGHT or COLOR_NORMAL
		end
	end
end

local function updateSuggestions()
	local rawText = commandInput.Text
	local text = getSearchText(rawText)
	local commandWord = string.split(text," ")[1] or ""

	if text == "" then
		resetSuggester()
		return
	end

	local matches = getMatches(commandWord)
	rebuildSuggestions(matches)

	if matches[1] and matches[1].Name == "esp" then
		suggesterCommandName.Text = "esp {distance}"

	elseif matches[1] and matches[1].Name == "hitboxtransparency" then
		suggesterCommandName.Text = "hitboxtransparency {amount} {player/team/all}"

	elseif matches[1] and matches[1].Name == "maxzoom" then
		suggesterCommandName.Text = "maxzoom {amount}"

	elseif matches[1] and matches[1].Name == "defaultzoom" then
		suggesterCommandName.Text = "defaultzoom"

	elseif matches[1] and matches[1].Name == "tpwalk" then
		suggesterCommandName.Text = "tpwalk {multiplier}"

	elseif matches[1] and matches[1].Name == "blink" then
		suggesterCommandName.Text = "blink {distance}"

	elseif matches[1] and matches[1].Name == "hitbox" then
		suggesterCommandName.Text = "hitbox {player/team} {multiplier}"

	elseif matches[1] and matches[1].Name == "highlight" then
		suggesterCommandName.Text = "highlight {player/team/all} {distance}"

	elseif matches[1] and matches[1].Name == "esphighlight" then
		suggesterCommandName.Text = "esphighlight {distance}"

	elseif matches[1] and matches[1].Name == "unesphighlight" then
		suggesterCommandName.Text = "unesphighlight"

	elseif matches[1] and matches[1].Name == "goto" then
		suggesterCommandName.Text = "goto {player}"

	elseif matches[1] and matches[1].Name == "view" then
		suggesterCommandName.Text = "view {player}"

	elseif matches[1] and matches[1].Name == "noclip" then
		suggesterCommandName.Text = "noclip"

	elseif matches[1] and matches[1].Name == "clip" then
		suggesterCommandName.Text = "clip"

	elseif matches[1] and matches[1].Name == "sit" then
		suggesterCommandName.Text = "sit"

	elseif matches[1] and matches[1].Name == "unview" then
		suggesterCommandName.Text = "unview"

	elseif matches[1] and matches[1].Name == "unhighlight" then
		suggesterCommandName.Text = "unhighlight"

	elseif matches[1] and matches[1].Name == "fov" then
		suggesterCommandName.Text = "fov {amount}"

	elseif matches[1] and matches[1].Name == "resetfov" then
		suggesterCommandName.Text = "resetfov"

	elseif matches[1] and matches[1].Name == "fly" then
		suggesterCommandName.Text = "fly {speed}"

	elseif matches[1] and matches[1].Name == "unfly" then
		suggesterCommandName.Text = "unfly"

	elseif matches[1] and matches[1].Name == "tracers" then
		suggesterCommandName.Text = "tracers {distance}"

	elseif matches[1] and matches[1].Name == "untracers" then
		suggesterCommandName.Text = "untracers"

	elseif matches[1] and matches[1].Name == "unfreecam" then
		suggesterCommandName.Text = "unfreecam"

	elseif matches[1] and matches[1].Name == "walkspeed" then
		suggesterCommandName.Text = "walkspeed {amount}"

	elseif matches[1] and matches[1].Name == "resetwalkspeed" then
		suggesterCommandName.Text = "resetwalkspeed"

	elseif matches[1] and matches[1].Name == "jumpheight" then
		suggesterCommandName.Text = "jumpheight {amount}"

	elseif matches[1] and matches[1].Name == "resetjumpheight" then
		suggesterCommandName.Text = "resetjumpheight"

	elseif matches[1] and matches[1].Name == "fullbright" then
		suggesterCommandName.Text = "fullbright"

	elseif matches[1] and matches[1].Name == "unfullbright" then
		suggesterCommandName.Text = "unfullbright"

	elseif matches[1] and matches[1].Name == "freecam" then
		suggesterCommandName.Text = "freecam {speed}"

	elseif matches[1] and matches[1].Name == "unfreecam" then
		suggesterCommandName.Text = "unfreecam"

	elseif matches[1] and matches[1].Name == "destroy" then
		suggesterCommandName.Text = "destroy"

	elseif matches[1] and matches[1].Name == "togglebind" then
		suggesterCommandName.Text = "togglebind {key} {command}"

	elseif matches[1] and matches[1].Name == "bind" then
		suggesterCommandName.Text = "bind {key} {command}"

	elseif matches[1] and matches[1].Name == "unbind" then
		suggesterCommandName.Text = "unbind {key}"

	elseif matches[1] and matches[1].Name == "waypointcreate" then
		suggesterCommandName.Text = "waypointcreate {name}"

	elseif matches[1] and matches[1].Name == "waypointdelete" then
		suggesterCommandName.Text = "waypointdelete {name}"

	elseif matches[1] and matches[1].Name == "gotowaypoint" then
		suggesterCommandName.Text = "gotowaypoint {name}"

	elseif matches[1] and matches[1].Name == "playerinfo" then
		suggesterCommandName.Text = "playerinfo {player}"
	end
end

local function openMenu()
	menuOpen = true

	bg.Visible = true
	mainBg.BackgroundTransparency = 1

	resetInputAndSuggestions()
	hideHelpList()
	sanitizeCommandInput()

	tween(mainBg, 0.05, {BackgroundTransparency = 0.45})

	task.defer(function()
		if menuOpen then
			commandInput:CaptureFocus()
		end
	end)
end

closeMenu = function()
	menuOpen = false

	suppressRefocus = true
	commandInput:ReleaseFocus()

	local fade = tween(mainBg, 0.05, {BackgroundTransparency = 1})
	fade.Completed:Wait()

	bg.Visible = false
	suppressRefocus = false

	resetInputAndSuggestions()
	hideHelpList()
end

local function toggleMenu()
	if menuOpen then
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

local function executeCommand(commandText)
	local cleaned = tostring(commandText or "")
	cleaned = cleaned:gsub("^%s+", "")
	cleaned = cleaned:gsub("%s+$", "")

	if cleaned == "" then
		commandInput.Text = ""
		commandInput.CursorPosition = -1
		updateSuggestions()
		return
	end

	local lowered = string.lower(cleaned)

	for _, cmd in ipairs(Commands) do
		local cmdName = string.lower(cmd.Name)

		if lowered == cmdName or lowered:sub(1, #cmdName + 1) == (cmdName .. " ") then
			local argsText = cleaned:sub(#cmd.Name + 1)
			argsText = argsText:gsub("^%s+", "")

			local args = {}
			if argsText ~= "" then
				args = string.split(argsText, " ")
			end

			-- Don't hide the list for help, teams, binds, or waypoints commands
			-- These frames should stay visible until menu closes or another command runs
			if string.lower(cmd.Name) ~= "help" and string.lower(cmd.Name) ~= "teams" and string.lower(cmd.Name) ~= "binds" and string.lower(cmd.Name) ~= "waypoints" then
				hideHelpList()
			end

			commandInput.Text = ""
			commandInput.CursorPosition = -1
			updateSuggestions()

			local ok, err = pcall(function()
				cmd.Execute(table.unpack(args))
			end)

			if not ok then
				warn("Command execution failed for '" .. cmd.Name .. "': " .. tostring(err))
			end

			task.defer(function()
				if menuOpen then
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
		if menuOpen then
			commandInput:CaptureFocus()
		end
	end)
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- INPUT HANDLING
--////////////////////////////////////////////////////

inputTextConnection = commandInput:GetPropertyChangedSignal("Text"):Connect(function()
	if not menuOpen then
		return
	end

	sanitizeCommandInput()
	updateSuggestions()
end)

inputFocusLostConnection = commandInput.FocusLost:Connect(function(enterPressed)
	if enterPressed and menuOpen then
		executeCommand(commandInput.Text)
		return
	end

	if menuOpen and not suppressRefocus then
		task.defer(function()
			if menuOpen then
				commandInput:CaptureFocus()
			end
		end)
	end
end)

inputBeganConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)

	-- KEYBINDS
	if not gameProcessed and (not commandInput or not commandInput:IsFocused()) then

		-- GHOST CLICK COMMANDS
		if input.UserInputType == Enum.UserInputType.MouseButton1 then

			if clickTeleportActive and clickTeleportKey and UserInputService:IsKeyDown(clickTeleportKey) then
				performClickTeleport()
				return
			end

			local deleteKey = nil
			for key,ghost in pairs(ghostBinds) do
				if ghost == "clickdelete" and UserInputService:IsKeyDown(key) then
					deleteKey = key
					break
				end
			end

			if deleteKey then
				performClickDelete()
				return
			end

		end

		local key = input.KeyCode

		-- TOGGLE BINDS
		local toggle = toggleBinds[key]
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

		-- GHOST BINDS
		local ghost = ghostBinds[key]
		if ghost then

			if ghost == "clickteleport" then
				startClickTeleport(key)
			end

			return
		end

-- NORMAL BINDS
local boundCommand = keybinds[key]
if boundCommand then
	executeCommand(boundCommand)
	return
end

	end
	if input.KeyCode == Enum.KeyCode.Semicolon then
		if not welcomeFinished then
			return
		end

		toggleMenu()

		task.defer(function()
			if commandInput then
				sanitizeCommandInput()
				updateSuggestions()
			end
		end)

		return
	end

	if not menuOpen then
		return
	end

	if input.KeyCode == Enum.KeyCode.Tab and commandInput:IsFocused() then
		if currentBestMatch then
			local fillText = currentBestMatch.Name

			if currentBestMatch.Name == "esp" then
				fillText = "esp "
			elseif currentBestMatch.Name == "tpwalk" then
				fillText = "tpwalk "
			elseif currentBestMatch.Name == "blink" then
				fillText = "blink "
			elseif currentBestMatch.Name == "hitbox" then
				fillText = "hitbox "
			elseif currentBestMatch.Name == "highlight" then
				fillText = "highlight "
			elseif currentBestMatch.Name == "goto" then
				fillText = "goto "
			elseif currentBestMatch.Name == "view" then
				fillText = "view "
			elseif currentBestMatch.Name == "fov" then
				fillText = "fov "
			elseif currentBestMatch.Name == "fly" then
				fillText = "fly "
			elseif currentBestMatch.Name == "tracers" then
				fillText = "tracers "
			elseif currentBestMatch.Name == "freecam" then
				fillText = "freecam "
			elseif currentBestMatch.Name == "walkspeed" then
				fillText = "walkspeed "
			elseif currentBestMatch.Name == "jumpheight" then
				fillText = "jumpheight "
			elseif currentBestMatch.Name == "maxzoom" then
				fillText = "maxzoom "
			elseif currentBestMatch.Name == "esphighlight" then
				fillText = "esphighlight "
			elseif currentBestMatch.Name == "playerinfo" then
				fillText = "playerinfo "
			end

			commandInput.Text = fillText
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

UserInputService.InputEnded:Connect(function(input)

	if input.KeyCode == clickTeleportKey then
		stopClickTeleport()
	end

end)

--////////////////////////////////////////////////////
-- TPWALK SYSTEM
--////////////////////////////////////////////////////

function startTpWalk(multiplier)
	if tpWalkConnection then
		tpWalkConnection:Disconnect()
		tpWalkConnection = nil
	end

	tpWalkEnabled = true

	local RunService = game:GetService("RunService")

	tpWalkConnection = RunService.RenderStepped:Connect(function(dt)
		if not tpWalkEnabled then
			return
		end

		local character = LocalPlayer.Character
		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local rootPart = character:FindFirstChild("HumanoidRootPart")

		if not humanoid or not rootPart then
			return
		end

		if humanoid.Health <= 0 then
			return
		end

		local moveDirection = humanoid.MoveDirection
		if moveDirection.Magnitude <= 0 then
			return
		end

		local extraSpeed = humanoid.WalkSpeed * multiplier
		local offset = moveDirection.Unit * extraSpeed * dt

		character:PivotTo(character:GetPivot() + offset)
	end)

	-- Print is now handled by the command system
end

function stopTpWalk()
	tpWalkEnabled = false

	if tpWalkConnection then
		tpWalkConnection:Disconnect()
		tpWalkConnection = nil
	end

	-- Print is now handled by the command system
end

--////////////////////////////////////////////////////
-- NAMETAG / HITBOX SYSTEM
--////////////////////////////////////////////////////

function startNametagSystem(renderDistance)
	if nametagSystemEnabled then
		return
	end

	nametagSystemEnabled = true

	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local RunService = game:GetService("RunService")

	local COLOR_HIGH = Color3.fromHex("#6eff69")
	local COLOR_MED = Color3.fromHex("#ff984a")
	local COLOR_LOW = Color3.fromHex("#ff6254")

	local SMOOTH_SPEED = 5
	renderDistance = renderDistance or math.huge

	local playerHPColors = {}
	local playerHitboxes = {}
	local monitoredParts = {}

	local function createBillboardGui(character)
		local head = character:WaitForChild("Head")

		if head:FindFirstChild("PlayerBillboardGui") then
			head.PlayerBillboardGui:Destroy()
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
		if not adornments then
			return
		end

		for _, adorn in ipairs(adornments) do
			if adorn and adorn.Parent then
				adorn.Visible = isVisible
			end
		end
	end

	local function createHitbox(character)
		if playerHitboxes[character] then
			for _, adorn in pairs(playerHitboxes[character]) do
				adorn:Destroy()
			end
		end

		if monitoredParts[character] then
			for _, conn in pairs(monitoredParts[character]) do
				conn:Disconnect()
			end
		end

		playerHitboxes[character] = {}
		monitoredParts[character] = {}

		local root = character:FindFirstChild("HumanoidRootPart")
		if not root then return end

		local box = Instance.new("BoxHandleAdornment")
		box.Adornee = root
		box.AlwaysOnTop = true
		box.ZIndex = 10
		box.Size = root.Size
		box.Transparency = hitboxTransparency
		box.Color3 = root.Color
		box.Visible = true
		box.Parent = root

		playerHitboxes[character] = {box}
	end

	local function getHealthColor(health, maxHealth)
		local pct = health / maxHealth

		if pct > 0.75 then
			return COLOR_HIGH
		elseif pct > 0.5 then
			return COLOR_MED
		else
			return COLOR_LOW
		end
	end

	local function lerpColor(c1, c2, a)
		return Color3.new(
			c1.R + (c2.R - c1.R) * a,
			c1.G + (c2.G - c1.G) * a,
			c1.B + (c2.B - c1.B) * a
		)
	end

	local renderConn
	renderConn = RunService.RenderStepped:Connect(function(dt)
		if not nametagSystemEnabled then
			return
		end

		local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not localRoot then
			return
		end

		for _, player in pairs(Players:GetPlayers()) do
			if player == LocalPlayer then
				continue
			end

			if player.Character and player.Character:FindFirstChild("Humanoid") then
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

				if distance > renderDistance then
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

				local targetColor = getHealthColor(humanoid.Health, humanoid.MaxHealth)
				local currentColor = playerHPColors[player] or COLOR_HIGH

				currentColor = lerpColor(currentColor, targetColor, math.clamp(SMOOTH_SPEED * dt, 0, 1))
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

	table.insert(nametagConnections, renderConn)
end


function stopNametagSystem()

	if not nametagSystemEnabled then
		return
	end

	-- stop system immediately
	nametagSystemEnabled = false

	-- disconnect loops
	for _,conn in ipairs(nametagConnections) do
		if conn then
			conn:Disconnect()
		end
	end

	table.clear(nametagConnections)

	local Players = game:GetService("Players")

	for _,player in ipairs(Players:GetPlayers()) do

		local character = player.Character
		if not character then continue end

		-- remove billboard
		local head = character:FindFirstChild("Head")
		if head then
			local gui = head:FindFirstChild("PlayerBillboardGui")
			if gui then
				gui:Destroy()
			end
		end

		-- remove ALL hitbox adornments
		for _,desc in ipairs(character:GetDescendants()) do
			if desc:IsA("BoxHandleAdornment") then
				desc:Destroy()
			end
		end

	end

end

--////////////////////////////////////////////////////
-- GLOBAL PLAYER TRACKING SYSTEM
--////////////////////////////////////////////////////

local function onCharacterSpawn(player, character)

	task.wait()

	-- HITBOX SYSTEM
	if hitboxSystemEnabled then
		refreshHitboxForPlayer(player)
		applyStoredHitboxTransparency(player)
	end

	-- HIGHLIGHT SYSTEM
	if highlightAllEnabled then
		applyHighlightToCharacter(player, character)
	end

end


local function trackPlayer(player)

	if player == LocalPlayer then
		return
	end

	-- Character spawn tracking
	player.CharacterAdded:Connect(function(character)
		onCharacterSpawn(player, character)
	end)

	-- If character already exists
	if player.Character then
		onCharacterSpawn(player, player.Character)
	end

end


local function startGlobalPlayerTracking()

	-- Track already existing players
	for _, player in ipairs(Players:GetPlayers()) do
		trackPlayer(player)
	end

	-- Track new players
	Players.PlayerAdded:Connect(function(player)
		trackPlayer(player)
	end)

end

--////////////////////////////////////////////////////
-- CLICK TELEPORT SYSTEM (GHOST COMMAND)
--////////////////////////////////////////////////////

function performClickTeleport()

	local mouse = LocalPlayer:GetMouse()
	local character = LocalPlayer.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local camera = workspace.CurrentCamera
	if not camera then return end

	local ray = camera:ScreenPointToRay(mouse.X, mouse.Y)

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {character}

	local result = workspace:Raycast(ray.Origin, ray.Direction * CLICKTP_MAX_DISTANCE, params)
	if not result then return end

	local pos = result.Position

	if pos.Y < CLICKTP_MIN_Y then
		print("[FAIL] Teleport blocked (void protection)")
		return
	end

	root.CFrame = CFrame.new(pos + Vector3.new(0,3,0))

end

function performClickDelete()

	local mouse = LocalPlayer:GetMouse()
	local camera = workspace.CurrentCamera
	if not camera then return end

	local ray = camera:ScreenPointToRay(mouse.X, mouse.Y)

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude

	local character = LocalPlayer.Character
	if character then
		params.FilterDescendantsInstances = {character}
	end

	local result = workspace:Raycast(ray.Origin, ray.Direction * 2000, params)
	if not result then return end

	local target = result.Instance
	if not target then return end

	-- PROTECTION: prevent deleting player characters
	local model = target:FindFirstAncestorOfClass("Model")

	if model then
		local humanoid = model:FindFirstChildOfClass("Humanoid")
		if humanoid then
			print("[FAIL] Cannot delete humanoid objects")
			return
		end
	end

	-- extra protection: don't delete humanoid parts
	if target:FindFirstAncestorWhichIsA("Humanoid") then
		print("[FAIL] Cannot delete humanoid objects")
		return
	end

	target:Destroy()

end


function startClickTeleport(keyCode)
	clickTeleportKey = keyCode
	clickTeleportActive = true
end


function stopClickTeleport()
	clickTeleportActive = false
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- STARTUP
--////////////////////////////////////////////////////

-- FORCE UI ABOVE EVERYTHING
local screenGui = bg:FindFirstAncestorOfClass("ScreenGui")

if screenGui then
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 999999
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

-- FORCE HIGH ZINDEX FOR ALL UI
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

-- Load saved waypoints on startup
if loadWaypoints() then
	print("[SUCCESS] Loaded saved waypoints from file")
else
	print("[INFO] No saved waypoints found or executor API unavailable")
end

-- Load saved binds
if loadBinds() then
	print("[SUCCESS] Loaded saved binds from file")
else
	print("[INFO] No saved binds found or executor API unavailable")
end

task.spawn(playWelcomeSequence)

characterCleanupConnection = LocalPlayer.CharacterAdded:Connect(function()
	task.wait()
	cacheMovementDefaults()
	stopFly()
	stopTracers()
	stopFreecam()
end)
```

I have added 2 commands:
```
clickteleport = {
	Name = "clickteleport",
	Description = "Teleport to clicked position (ghost command – requires bind)",
	Ghost = true,
	Execute = function()
		print("[FAIL] clickteleport is a ghost command and must be bound to a key.")
	end
},

clickdelete = {
	Name = "clickdelete",
	Description = "Delete clicked object (ghost command – requires bind)",
	Ghost = true,
	Execute = function()
		print("[FAIL] clickdelete is a ghost command and must be bound to a key.")
	end
},
