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
commandExecutor.Name = "CommandExecutor"
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
				commandInput.Name = "CommandInput"
				commandInput.Text = ""
				commandInput.BackgroundTransparency = 0.999
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

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- SEARCH FUNCTIONS
--////////////////////////////////////////////////////

local populateHelpList
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
	hitboxEnforcementConnection = RunService.RenderStepped:Connect(function()
		if not hitboxSystemEnabled then
			return
		end
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				if hitboxIgnoreOwnTeam and player.Team == LocalPlayer.Team then
					restoreHitboxForPlayer(player)
				else
					refreshHitboxForPlayer(player)
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
		hitboxCharacterConnections[player] = nil
	end

	hitboxCharacterConnections[player] = player.CharacterAdded:Connect(function(character)
		originalHumanoidRootPartSizes[player] = nil
		originalHumanoidRootPartCanCollide[player] = nil

		task.defer(function()
			if character and character.Parent then
				refreshHitboxForPlayer(player)
			end
		end)
	end)

	if player.Character then
		task.defer(function()
			refreshHitboxForPlayer(player)
		end)
	end
end

local function ensureHitboxTracking()
	if not hitboxPlayerAddedConnection then
		hitboxPlayerAddedConnection = Players.PlayerAdded:Connect(function(player)
			if player == LocalPlayer then
				return
			end

			hookHitboxCharacter(player)
			player:GetPropertyChangedSignal("Team"):Connect(function()

				if not hitboxSystemEnabled then
					return
				end

				if hitboxIgnoreOwnTeam then
					refreshAllActiveHitboxes()
				end

			end)

			task.defer(function()
				refreshAllActiveHitboxes()
			end)
		end)
		-- detect local team changes
		LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function()

			if not hitboxSystemEnabled then
				return
			end

			if hitboxIgnoreOwnTeam then
				refreshAllActiveHitboxes()
			end

		end)
	end

	if not hitboxPlayerRemovingConnection then
		hitboxPlayerRemovingConnection = Players.PlayerRemoving:Connect(function(player)
			cleanupHitboxPlayer(player)
		end)
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			hookHitboxCharacter(player)
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
					print("Invalid distance")
					return
				end
			end

			print("Nametag render distance:", distance == math.huge and "infinite" or distance, "studs")
			startNametagSystem(distance)
		end,
	},
	{
		Name = "unesp",
		Description = "Turns off the customizable nametags above every player displaying their username, health and distance from you in studs.",
		Execute = function()
			print("Executed command: unesp")
			stopNametagSystem()
		end,
	},
	{
		Name = "tpwalk",
		Description = "Makes your character walk faster without speeding up any animations, usage: 'tpwalk 0.25' for a slight boost",
		Execute = function(multiplier)
			multiplier = tonumber(multiplier)

			if not multiplier then
				print("Invalid tpwalk multiplier")
				return
			end

			startTpWalk(multiplier)
		end,
	},
	{
		Name = "untpwalk",
		Description = "Removes any previously granted 'tpwalk' functions to the players character if there were any",
		Execute = function()
			stopTpWalk()
		end,
	},
	{
		Name = "blink",
		Description = "Teleports you x studs towards the direction your character is looking at.",
		Execute = function(distance)
			distance = tonumber(distance)

			if not distance then
				print("Invalid blink distance")
				return
			end

			local character = LocalPlayer.Character
			if not character then
				return
			end

			local rootPart = character:FindFirstChild("HumanoidRootPart")
			if not rootPart then
				return
			end

			local lookVector = rootPart.CFrame.LookVector
			local flatForward = Vector3.new(lookVector.X, 0, lookVector.Z)

			if flatForward.Magnitude <= 0 then
				return
			end

			flatForward = flatForward.Unit

			rootPart.CFrame = CFrame.new(
				rootPart.Position + (flatForward * distance),
				rootPart.Position + (flatForward * distance) + flatForward
			)
		end,
	},
	{
		Name = "hitbox",
		Description = "Multiplies the hitbox area of the selected player or team, usage: 'hitbox username 2' or 'hitbox Engineering Department 2'",
		Execute = function(...)

			local args = {...}

			if #args < 2 then
				print("Usage: hitbox {player/team} {multiplier}")
				return
			end

			local multiplier = tonumber(args[#args])

			if not multiplier then
				print("Invalid hitbox multiplier")
				return
			end

			table.remove(args, #args)

			local targetName = table.concat(args, " ")

			if targetName == "" then
				print("Missing target name or team")
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

					print("Applied hitbox multiplier to team:", team.Name, multiplier)
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

				print("Applied hitbox multiplier to all players:", multiplier)
				return
			end

			-- APPLY TO SINGLE PLAYER
			local targetPlayer = findPlayerByName(targetName)

			if not targetPlayer then
				print("Player or team not found:", targetName)
				return
			end

			hitboxSystemEnabled = true
			applyHitboxToPlayer(targetPlayer, multiplier)

			print("Applied persistent hitbox multiplier to", targetPlayer.Name, multiplier)

		end,
	},
	{
		Name = "resethitboxes",
		Description = "Removes any previously expanded hitboxes to player characters if there were any",
		Execute = function()
			resetAllHitboxes()
			print("Reset all expanded hitboxes")
		end,
	},
	{
		Name = "respawn",
		Description = "Resets your roblox character - Sets your humanoid health to 0",
		Execute = function()

			local character = LocalPlayer.Character
			if not character then
				return
			end

			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				return
			end

			humanoid.Health = 0

		end,
	},
	{
		Name = "rejoin",
		Description = "After executing this command, you rejoin the exact same server",
		Execute = function()

			local TeleportService = game:GetService("TeleportService")

			local placeId = game.PlaceId
			local jobId = game.JobId

			TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)

		end,
	},
	{
		Name = "highlight",
		Description = "Highlights the specified players making them visible through walls, and displaying their animations in real time",
		Execute = function(targetName, distance)

			targetName = tostring(targetName or "")

			if targetName == "" then
				print("Missing target name")
				return
			end

			if distance == nil or tostring(distance):match("^%s*$") then
				distance = math.huge
			else
				distance = tonumber(distance)
				if not distance then
					print("Invalid highlight distance")
					return
				end
			end

			highlightMaxDistance = distance
			ensureHighlightTracking()

			if string.lower(targetName) == "all" then

				highlightAllEnabled = true

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer then
						highlightPlayer(player)
					end
				end

				print("Applied highlights to all players with distance:", distance == math.huge and "infinite" or distance)
				return
			end

			local targetPlayer = findPlayerByName(targetName)

			if not targetPlayer then
				print("Player not found:", targetName)
				return
			end

			highlightPlayer(targetPlayer)

			print("Applied highlight to", targetPlayer.Name)

		end
	},
	{
		Name = "unhighlight",
		Description = "Removes any previously added highlight effects to every player if there were any",
		Execute = function()
			resetAllHighlights()
			print("Removed all highlights")
		end,
	},
	{
		Name = "help",
		Description = "Shows all of the executable modules and briefly explains how they all work",
		Execute = function()
			populateHelpList()
		end,
	},
	{
		Name = "goto",
		Description = "Teleports your player to the specified player, usage: 'goto username'",
		Execute = function(username)

			local target = findPlayerByName(username)

			if not target then
				print("Player not found:", username)
				return
			end

			local character = LocalPlayer.Character
			local targetCharacter = target.Character

			if not character or not targetCharacter then return end

			local root = character:FindFirstChild("HumanoidRootPart")
			local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")

			if not root or not targetRoot then return end

			root.CFrame = targetRoot.CFrame + Vector3.new(0,3,0)

		end,
	},
	{
		Name = "view",
		Description = "Teleports your player camera to the specified player, usage: 'view username'",
		Execute = function(username)

			local target = findPlayerByName(username)

			if not target then
				print("Player not found:", username)
				return
			end

			local camera = workspace.CurrentCamera

			if target.Character then
				local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					camera.CameraSubject = humanoid
					viewingPlayer = target
				end
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
				end
			end

			viewingPlayer = nil

		end,
	},
	{
		Name = "noclip",
		Description = "Disables all collisions for your local player essentially letting you walk through walls",
		Execute = function()

			if noclipEnabled then return end

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

		end,
	},
	{
		Name = "clip",
		Description = "Disables the noclip function",
		Execute = function()

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

		end,
	},
	{
		Name = "sit",
		Description = "Forces your player to sit on the nearest ground, to unsit simply jump once",
		Execute = function()

			local character = LocalPlayer.Character
			if not character then return end

			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.Sit = true
			end

		end,
	},
	{
		Name = "fov",
		Description = "Changes local fov (field of view), usage: 'fov 80'",
		Execute = function(amount)
			startCustomFov(amount)
		end,
	},
	{
		Name = "resetfov",
		Description = "Resets your local fov to the default one set by the owner of this experience",
		Execute = function()
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

			startFly(speed)
		end,
	},
	{
		Name = "unfly",
		Description = "Stops your character from flying any longer unless you use the fly command again",
		Execute = function()
			stopFly()
		end,
	},
	{
		Name = "tracers",
		Description = "Draws tracers, each one leading to different player, - tracer color is based on the players team color",
		Execute = function(distance)
			startTracers(distance)
		end,
	},
	{
		Name = "untracers",
		Description = "Disables the tracers, each one leading to different player, - tracer color is based on the players team color",
		Execute = function()
			stopTracers()
		end,
	},
	{
		Name = "freecam",
		Description = "Lets you fly around in sort of a spectator mode, cool minecraft reference huh?",
		Execute = function(speed)
			startFreecam(speed)
		end,
	},
	{
		Name = "unfreecam",
		Description = "Destroys your freecam and puts your camera back to your character",
		Execute = function()
			stopFreecam()
		end,
	},
	{
		Name = "walkspeed",
		Description = "Increases your walkspeed accordingly to what you specify within the command prompt",
		Execute = function(amount)
			setWalkSpeed(amount)
		end,
	},
	{
		Name = "resetwalkspeed",
		Description = "Resets your characters walkspeed to a default one set by the owner of this experience",
		Execute = function()
			resetWalkSpeed()
		end,
	},
	{
		Name = "jumpheight",
		Description = "Increases your jumpheight accordingly to what you specify within the command prompt",
		Execute = function(amount)
			setJumpHeight(amount)
		end,
	},
	{
		Name = "resetjumpheight",
		Description = "Resets your characters jumpheight to a default one set by the owner of this experience",
		Execute = function()
			resetJumpHeight()
		end,
	},
	{
		Name = "fullbright",
		Description = "Illuminates your whole game, this is useful for playing at night!",
		Execute = function()
			startFullbright()
		end,
	},
	{
		Name = "unfullbright",
		Description = "Resets the brightness to the default one set by the owner of this experience",
		Execute = function()
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

			amount = tonumber(amount)

			if not amount then
				print("Invalid zoom amount")
				return
			end

			LocalPlayer.CameraMaxZoomDistance = amount

			print("Max zoom distance set to:", amount)

		end,
	},
	{
		Name = "defaultzoom",
		Description = "Changes your camera's max zoom distance to the default settings set by the owner of this experience.",
		Execute = function()

			LocalPlayer.CameraMaxZoomDistance = defaultCameraMaxZoom

			print("Camera zoom reset to default:", defaultCameraMaxZoom)

		end,
	},
	{
		Name = "teams",
		Description = "Shows every team that exists in this experience",
		Execute = function()
			populateTeamsList()
		end,
	},

	{
		Name = "destroy",
		Description = "Destroys the entire system leaving no trace of use!",
		Execute = function()
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

			amount = math.clamp(amount, 0, 1)
			hitboxTransparency = amount

			local Players = game:GetService("Players")
			local Teams = game:GetService("Teams")

			-- if no target specified → default to all
			if #args == 1 then
				args[2] = "all"
			end

			table.remove(args, 1)
			local targetName = table.concat(args, " ")
			local lowerTarget = string.lower(targetName)

			-- APPLY TO ALL
			if lowerTarget == "all" then

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer then

						local character = player.Character
						if not character then continue end

						local root = character:FindFirstChild("HumanoidRootPart")
						if not root then continue end

						root.Transparency = hitboxTransparency

						if player.Team and player.Team.TeamColor then
							root.Color = player.Team.TeamColor.Color
						else
							root.Color = Color3.new(1,1,1)
						end
					end
				end

				print("Hitbox transparency set to", amount, "for all players")
				return
			end

			-- APPLY TO TEAM
			for _, team in ipairs(Teams:GetTeams()) do
				if string.lower(team.Name) == lowerTarget then

					for _, player in ipairs(Players:GetPlayers()) do
						if player.Team == team and player ~= LocalPlayer then

							local character = player.Character
							if not character then continue end

							local root = character:FindFirstChild("HumanoidRootPart")
							if not root then continue end

							root.Transparency = hitboxTransparency
							root.Color = team.TeamColor.Color
						end
					end

					print("Hitbox transparency set to", amount, "for team:", team.Name)
					return
				end
			end

			-- APPLY TO SINGLE PLAYER
			local targetPlayer = findPlayerByName(targetName)

			if not targetPlayer then
				print("Player or team not found:", targetName)
				return
			end

			local character = targetPlayer.Character
			if not character then return end

			local root = character:FindFirstChild("HumanoidRootPart")
			if not root then return end

			root.Transparency = hitboxTransparency

			if targetPlayer.Team and targetPlayer.Team.TeamColor then
				root.Color = targetPlayer.Team.TeamColor.Color
			else
				root.Color = Color3.new(1,1,1)
			end

			print("Hitbox transparency set to", amount, "for player:", targetPlayer.Name)

		end,
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
		return "highlight {player/all} {distance}"
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
	else
		return cmd.Name
	end
end

local function clearHelpEntries()
	for _, child in ipairs(helperScrollingFrame:GetChildren()) do
		if child:IsA("Frame") and child ~= exampleHelperTemplate then
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
					displayName = "highlight {player/all} {distance}"

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

				elseif cmd.Name == "destroy" then
					displayName = "destroy"
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
			suggesterCommandName.Text = "highlight {player/all} {distance}"

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

			if string.lower(cmd.Name) ~= "help" then
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

	print("tpwalk enabled with multiplier:", multiplier)
end

function stopTpWalk()
	tpWalkEnabled = false

	if tpWalkConnection then
		tpWalkConnection:Disconnect()
		tpWalkConnection = nil
	end

	print("tpwalk disabled")
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
task.spawn(playWelcomeSequence)

characterCleanupConnection = LocalPlayer.CharacterAdded:Connect(function()
	task.wait()
	cacheMovementDefaults()
	stopFly()
	stopTracers()
	stopFreecam()
end)
