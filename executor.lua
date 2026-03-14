
--// Made by reaIuni @ Roblox
--// Executable client-side command UI
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
		instance[key] = value
	end
	return instance
end

local function newInstance(className, props, parent)
	local obj = Instance.new(className)
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

local function createUICorner(radius, parent)
	return newInstance("UICorner", {
		CornerRadius = radius
	}, parent)
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
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor = BrickColor.new("Really black"),
}, main)

local mainBg = createFrame({
	Name = "MainBG",
	BorderSizePixel = 0,
	BackgroundTransparency = 0.4499,
	Size = UDim2.fromScale(0.9771, 0.1823),
	Position = UDim2.fromScale(0.011, 0.8215),
	BackgroundColor3 = Color3.fromRGB(28, 29, 34),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	BorderColor = BrickColor.new("Really black"),
}, bg)

createTextLabel({
	Name = "PromptLabel",
	Text = "LuaUExec@Cmdr$",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	TextSize = 14,
	TextWrapped = true,
	TextScaled = true,
	Size = UDim2.fromScale(0.0782, 0.5148),
	Position = UDim2.fromScale(0.007, 0.2317),
	FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json"),
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	TextColor3 = Color3.fromRGB(202, 177, 53),
	BorderColor = BrickColor.new("Really black"),
}, mainBg)

local function createTextBox(props, parent)
	return newInstance("TextBox", props, parent)
end

createTextBox({
	Name = "CommandInput",
	Text = "",
	PlaceholderText = "Type 'help' to view all of the commands",
	TextSize = 14,
	CursorPosition = -1,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ClearTextOnFocus = false,
	TextWrapped = true,
	TextScaled = true,
	Size = UDim2.fromScale(0.9146, 0.5148),
	Position = UDim2.fromScale(0.0852, 0.2317),
	FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	TextColor3 = Color3.fromRGB(227, 227, 227),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	BorderColor = BrickColor.new("Really black"),
}, mainBg)

local helperBg = createFrame({
	Name = "HelperBG",
	BorderSizePixel = 0,
	BackgroundTransparency = 1,
	Visible = false,
	Size = UDim2.fromScale(0.9771, 2.5499),
	Position = UDim2.fromScale(0.011, 1.0499),
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
	CanvasSize = UDim2.new(0, 0),
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

local exampleHelper = createFrame({
	Name = "ExampleHelper",
	BackgroundTransparency = 0.4499,
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
	TextSize = 17,
	RichText = true,
	Size = UDim2.new(1, -16, 1, 0),
	Position = UDim2.fromOffset(8, 0),
	FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json"),
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	TextColor3 = Color3.fromRGB(202, 177, 53),
	BorderColor = BrickColor.new("Really black"),
}, exampleHelper)

local commandSuggester = createFrame({
	Name = "CommandSuggester",
	BorderSizePixel = 0,
	BackgroundTransparency = 0.4499,
	Visible = false,
	Size = UDim2.fromScale(0.18, 0.0918),
	Position = UDim2.fromScale(0.0944, 0.1882),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	BackgroundColor3 = Color3.fromRGB(28, 29, 34),
	BorderColor = BrickColor.new("Really black"),
}, main)

createTextLabel({
	Name = "CommandName",
	Text = "player esp",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	TextSize = 14,
	TextWrapped = true,
	TextScaled = true,
	Size = UDim2.fromScale(0.9821, 0.1995),
	Position = UDim2.fromScale(0.0388, 0.0974),
	FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
	TextXAlignment = Enum.TextXAlignment.Left,
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
	TextSize = 17,
	TextWrapped = true,
	TextScaled = false,
	Position = UDim2.fromScale(0.0388, 0.3808),
	Size = UDim2.fromScale(0.9269, 0.4666),
	FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
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
	Size = UDim2.fromScale(1, 0.1784),
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
	TextSize = 14,
	TextWrapped = true,
	TextScaled = true,
	Size = UDim2.fromScale(0.9818, 0.5881),
	Position = UDim2.fromScale(0.0388, 0.1934),
	FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json"),
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	TextColor3 = Color3.fromRGB(159, 182, 202),
	BorderColor = BrickColor.new("Really black"),
}, exampleSuggestion)

local chatModule = createFrame({
	Name = "ChatModule",
	BorderSizePixel = 0,
	BackgroundTransparency = 1,
	Size = UDim2.fromScale(1, 1),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor = BrickColor.new("Really black"),
	Visible = false,
}, main)

local chatWindow = createFrame({
	Name = "Window",
	BorderSizePixel = 0,
	BackgroundTransparency = 0.99,
	Size = UDim2.fromScale(0.3443, 0.4755),
	Position = UDim2.fromScale(0.3189, 0.2848),
	BackgroundColor3 = Color3.fromRGB(28, 29, 34),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	BorderColor = BrickColor.new("Really black"),
}, chatModule)

local chatModuleTop = createFrame({
	Name = "ChatModuleTop",
	BorderSizePixel = 0,
	BackgroundTransparency = 0.4499,
	Size = UDim2.fromScale(1.0009, 0.0721),
	Position = UDim2.fromScale(-0.001, -0.0011),
	BackgroundColor3 = Color3.fromRGB(28, 29, 34),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	BorderColor = BrickColor.new("Really black"),
}, chatWindow)

createTextLabel({
	Name = "PromptLabel",
	Text = "RobloxChatSpy-Module.lua",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	TextSize = 14,
	TextWrapped = true,
	TextScaled = true,
	Size = UDim2.fromScale(0.4645, 0.5148),
	Position = UDim2.fromScale(0.0191, 0.2218),
	FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json"),
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	TextColor3 = Color3.fromRGB(202, 177, 53),
	BorderColor = BrickColor.new("Really black"),
}, chatModuleTop)

local closeButton = createTextButton({
	Name = "Close",
	Text = "EXIT",
	BackgroundTransparency = 0.6499,
	BorderSizePixel = 0,
	TextSize = 19,
	TextWrapped = true,
	Position = UDim2.fromScale(0.8828, 0.1767),
	Size = UDim2.fromOffset(68, 25),
	FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json"),
	TextColor3 = Color3.fromRGB(202, 177, 53),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderColor = BrickColor.new("Really black"),
}, chatModuleTop)
createUICorner(UDim.new(0, 4), closeButton)

local refreshButton = createTextButton({
	Name = "Refresh",
	Text = "REFRESH",
	BackgroundTransparency = 0.6499,
	BorderSizePixel = 0,
	TextSize = 19,
	TextWrapped = true,
	Position = UDim2.fromScale(0.7199, 0.1767),
	Size = UDim2.fromOffset(95, 25),
	FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json"),
	TextColor3 = Color3.fromRGB(202, 177, 53),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderColor = BrickColor.new("Really black"),
}, chatModuleTop)
createUICorner(UDim.new(0, 4), refreshButton)

local chatContent = createFrame({
	Name = "Content",
	BorderSizePixel = 0,
	BackgroundTransparency = 0.4499,
	Size = UDim2.fromOffset(656, 477),
	Position = UDim2.fromScale(0, 1.79),
	BackgroundColor3 = Color3.fromRGB(28, 29, 34),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	BorderColor = BrickColor.new("Really black"),
}, chatModuleTop)

local chatScrollingFrame = createScrollingFrame({
	Name = "ScrollingFrame",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 6,
	Active = true,
	Size = UDim2.fromScale(0.9719, 0.979),
	CanvasSize = UDim2.fromScale(0, 200),
	Position = UDim2.fromScale(0.019, 0.0209),
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(28, 29, 34),
	BorderColor = BrickColor.new("Really black"),
}, chatContent)

newInstance("UIListLayout", {
	Name = "UIListLayout",
	Padding = UDim.new(0, 4),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, chatScrollingFrame)

createTextLabel({
	Name = "PlayerUsername",
	Text = "USERNAME : MESSAGE",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	TextSize = 19,
	TextWrapped = true,
	Size = UDim2.fromScale(0.99, 0),
	Position = UDim2.fromScale(0, 0.002),
	FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json"),
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor3 = Color3.fromRGB(17, 17, 17),
	TextColor3 = Color3.fromRGB(202, 177, 53),
	BorderColor = BrickColor.new("Really black"),
}, chatScrollingFrame)

local uiParent

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
UI.CommandInput = UI.MainBG:WaitForChild("CommandInput")

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
}

CONFIG = {
	TYPE_SPEED = 0.02,
	FADE_TIME = 0.4,
	BETWEEN_TITLES_DELAY = 0.35,
	WELCOME_HOLD_TIME = 2,

	COLOR_NORMAL = Color3.fromRGB(159,182,202),
	COLOR_SPOTLIGHT = Color3.fromRGB(255,255,255),

	MAX_SUGGESTIONS = 25,

	CLICKTP_MAX_DISTANCE = 1000,
	CLICKTP_MIN_Y = -1000
}

CONFIG.HITBOX_REFRESH_RATE = 0.10
CONFIG.NAMETAG_REFRESH_RATE = 0.05
CONFIG.FULLBRIGHT_REAPPLY_RATE = 0.20

local Lighting = game:GetService("Lighting")
local Teams = game:GetService("Teams")
local Stats = game:GetService("Stats")

local function trimString(text)
	return tostring(text or ""):match("^%s*(.-)%s*$")
end

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


	--

	--

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
				if keyCode then
					STATE.toggleBinds[keyCode] = {
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
					STATE.ghostBinds[keyCode] = ghostCommand
				end
			end
		end

		return true
	end

	function saveBinds()
		if not writefile then
			return false
		end

		local data = {
			keybinds = {},
			togglebinds = {},
			ghostbinds = {}
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
		local savedAutoRotate

		function startFreecam(speed)
			if STATE.freecamEnabled then
				return
			end

			freecamSpeed = tonumber(speed) or 60
			STATE.freecamEnabled = true

			local camera = workspace.CurrentCamera
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")

			if not camera then
				return
			end

			if humanoid then
				savedWalkSpeed = humanoid.WalkSpeed
				savedJumpPower = humanoid.JumpPower
				savedAutoRotate = humanoid.AutoRotate

				humanoid.WalkSpeed = 0
				humanoid.JumpPower = 0
				humanoid.AutoRotate = false
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

			freecamConnection = RunService.RenderStepped:Connect(function(dt)
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

				camera.CFrame = CFrame.new(camPos) * rotation
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

			if camera then
				camera.CameraType = STATE.freecamOriginalType or Enum.CameraType.Custom
			end

			if humanoid then
				humanoid.WalkSpeed = savedWalkSpeed or 16
				humanoid.JumpPower = savedJumpPower or 50
				humanoid.AutoRotate = savedAutoRotate ~= false
			end

			UserInputService.MouseBehavior = Enum.MouseBehavior.Default

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
		local cleaned = text:gsub(";", ""):gsub("\t", "")

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

		STATE.clickTeleportKey = nil
		STATE.clickDeleteKey = nil
		STATE.clickTeleportActive = false
		STATE.clickDeleteActive = false
		STATE.noclipEnabled = false

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
		entry.BackgroundTransparency = 0.45

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
		createPrintHelper(text)
	end

	print = executorPrint
	_G.print = executorPrint
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- COMMANDS
--////////////////////////////////////////////////////
do
	local CommandHandlers = {}

	local function rebuildCommandRegistryCaches()
		table.clear(CommandsByName)
		table.clear(CommandNames)

		for i = 1, #Commands do
			local cmd = Commands[i]
			CommandsByName[cmd.LowerName] = cmd
			CommandNames[#CommandNames + 1] = cmd.LowerName
		end

		STATE.commandCategoryCache = nil
	end

	function addCommand(name, description, execute, category)
		local lowerName = string.lower(name)

		local cmd = {
			Name = name,
			LowerName = lowerName,
			Description = description,
			Execute = execute,
			Category = string.lower(category or "utility"),
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

		function CommandHandlers.highlight(targetName, distance)
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

		function CommandHandlers.esphighlight(distance)
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
		end

		function CommandHandlers.unesphighlight()
			stopNametagSystem()
			resetAllHighlights()
			print("Disabled esphighlight")
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
				loadstring(game:HttpGet("https://raw.githubusercontent.com/realuni/Roblox-Uni-s-.LuaU-Command-Executor/UI.Main/executor.lua"))()
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

			if lowerCommand == "bind" or lowerCommand == "togglebind" or lowerCommand == "unbind" or lowerCommand == "clearbinds" then
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

			if not STATE.keybinds[keyCode] and not STATE.toggleBinds[keyCode] and not STATE.ghostBinds[keyCode] then
				print("[FAIL] No bind found for key:", keyName)
				return
			end

			STATE.keybinds[keyCode] = nil
			STATE.toggleBinds[keyCode] = nil
			STATE.ghostBinds[keyCode] = nil
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

			for key, ghost in pairs(STATE.ghostBinds) do
				found = true
				createExampleHelperLine(key.Name .. " -> " .. ghost .. " (ghost)")
			end

			for key, data in pairs(STATE.toggleBinds) do
				found = true
				createExampleHelperLine(key.Name .. " -> " .. data.onCommand .. " / " .. data.offCommand)
			end

			if not found then
				createExampleHelperLine("No binds set.")
			end

			UI.HelperBG.Visible = true
			print("[SUCCESS] Binds list displayed")
		end

		function CommandHandlers.clearbinds()
			table.clear(STATE.keybinds)
			table.clear(STATE.toggleBinds)
			table.clear(STATE.ghostBinds)
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

				local src = httpget(game, "https://raw.githubusercontent.com/LorekeeperZinnia/Dex/master/main.lua")
				loader(src)()
			end)

			if not success then
				print("[FAIL] Could not load Dex:", err)
			end
		end
	end

	addCommand("esp", "Displays a customizable nametag above every player displaying their username, health and distance from you in studs", CommandHandlers.esp, "visual")
	addCommand("unesp", "Turns off the customizable nametags above every player displaying their username, health and distance from you in studs.", CommandHandlers.unesp, "visual")
	addCommand("tpwalk", "Makes your character walk faster without speeding up any animations, usage: 'tpwalk 0.25' for a slight boost", CommandHandlers.tpwalk, "movement")
	addCommand("untpwalk", "Removes any previously granted 'tpwalk' functions to the players character if there were any", CommandHandlers.untpwalk, "movement")
	addCommand("blink", "Teleports you x studs towards the direction your character is looking at.", CommandHandlers.blink, "movement")
	addCommand("hitbox", "Multiplies the hitbox area of the selected player or team, usage: 'hitbox username 2' or 'hitbox Engineering Department 2'", CommandHandlers.hitbox, "utility")
	addCommand("resethitboxes", "Removes any previously expanded hitboxes to player characters if there were any", CommandHandlers.resethitboxes, "utility")
	addCommand("respawn", "Resets your roblox character - Sets your humanoid health to 0", CommandHandlers.respawn, "utility")
	addCommand("rejoin", "Rejoins the same server and re-executes the script if supported by your executor", CommandHandlers.rejoin, "utility")
	addCommand("highlight", "Highlights the specified players making them visible through walls, and displaying their animations in real time", CommandHandlers.highlight, "visual")
	addCommand("unhighlight", "Removes any previously added highlight effects to every player if there were any", CommandHandlers.unhighlight, "visual")
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
	addCommand("walkspeed", "Increases your walkspeed accordingly to what you specify within the command prompt", CommandHandlers.walkspeed, "player")
	addCommand("resetwalkspeed", "Resets your characters walkspeed to a default one set by the owner of this experience", CommandHandlers.resetwalkspeed, "player")
	addCommand("jumpheight", "Increases your jumpheight accordingly to what you specify within the command prompt", CommandHandlers.jumpheight, "player")
	addCommand("resetjumpheight", "Resets your characters jumpheight to a default one set by the owner of this experience", CommandHandlers.resetjumpheight, "player")
	addCommand("fullbright", "Illuminates your whole game, this is useful for playing at night!", CommandHandlers.fullbright, "visual")
	addCommand("unfullbright", "Resets the brightness to the default one set by the owner of this experience", CommandHandlers.unfullbright, "visual")
	addCommand("esphighlight", "Combines both the esp and the highlight functions!", CommandHandlers.esphighlight, "visual")
	addCommand("unesphighlight", "Disables the combination of both the esp and the highlight functions!", CommandHandlers.unesphighlight, "visual")
	addCommand("maxzoom", "Changes your camera's max zoom distance based on what you specify within the command prompt", CommandHandlers.maxzoom, "player")
	addCommand("defaultzoom", "Changes your camera's max zoom distance to the default settings set by the owner of this experience.", CommandHandlers.defaultzoom, "player")
	addCommand("teams", "Shows every team that exists in this experience", CommandHandlers.teams, "utility")
	addCommand("destroy", "Destroys the entire system leaving no trace of use!", CommandHandlers.destroy, "system")
	addCommand("hitboxtransparency", "Changes the transparency of player humanoid root parts (0-1), usage: hitboxtransparency {amount} {player/team/all}", CommandHandlers.hitboxtransparency, "visual")
	addCommand("bind", "Binds a command to the specified key, usage: bind {key} {command}", CommandHandlers.bind, "binds")
	addCommand("unbind", "Removes a keybind, usage: unbind {key}", CommandHandlers.unbind, "binds")
	addCommand("binds", "Lets you view all of your previously created binds.", CommandHandlers.binds, "binds")
	addCommand("clearbinds", "Clears all of your previously created binds", CommandHandlers.clearbinds, "binds")
	addCommand("togglebind", "Binds a toggleable command to the specified key", CommandHandlers.togglebind, "binds")
	addCommand("waypointcreate", "Creates a waypoint at your current position with the specified name", CommandHandlers.waypointcreate, "utility")
	addCommand("waypointdelete", "Deletes the specified waypoint", CommandHandlers.waypointdelete, "utility")
	addCommand("waypoints", "Shows all created waypoints", CommandHandlers.waypoints, "utility")
	addCommand("gotowaypoint", "Teleports you to the specified waypoint", CommandHandlers.gotowaypoint, "utility")
	addCommand("savewaypoints", "Manually saves all waypoints to file", CommandHandlers.savewaypoints, "utility")
	addCommand("showwaypoints", "Shows 3D markers for all waypoints with distance-based transparency", CommandHandlers.showwaypoints, "utility")
	addCommand("hidewaypoints", "Hides all waypoint markers", CommandHandlers.hidewaypoints, "utility")
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
	}

	local originalTexts = {
		[UI.Title1] = UI.Title1.Text,
		[UI.Title2] = "Welcome back, " .. LocalPlayer.Name .. ".",
		[UI.Title3] = UI.Title3.Text,
	}

	UI.Title2.Text = originalTexts[UI.Title2]

	 function getCommandDisplayNameForHelp(cmd)
		return COMMAND_DISPLAY_NAMES[cmd.Name] or cmd.Name
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
		"movement",
		"visual",
		"player",
		"waypoints",
		"binds",
		"utility",
		"system",
	}

	STATE.helpCategoryTitles = {
		movement = "MOVEMENT",
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

		for i = 1, #Commands do
			local cmd = Commands[i]
			local category = string.lower(cmd.Category or "utility")

			if not grouped[category] then
				grouped[category] = {}
			end

			grouped[category][#grouped[category] + 1] = cmd
		end

		for _, categoryList in pairs(grouped) do
			table.sort(categoryList, function(a, b)
				return a.LowerName < b.LowerName
			end)
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

	function scoreCommand(query, cmd)
		query = string.lower(tostring(query or ""))
		local commandName = cmd.LowerName

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
			return 300 + score - #commandName * 0.5
		end

		return -math.huge
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
		UI.BG.Visible = true
		UI.MainBg.BackgroundTransparency = 1

		resetInputAndSuggestions()
		hideHelpList()
		sanitizeCommandInput()
		tween(UI.MainBg, 0.05, {BackgroundTransparency = 0.45})

		task.defer(function()
			if STATE.menuOpen then
				UI.CommandInput:CaptureFocus()
			end
		end)
	end

	closeMenu = function()
		STATE.menuOpen = false
		STATE.suppressRefocus = true
		UI.CommandInput:ReleaseFocus()

		tween(UI.MainBg, 0.05, {BackgroundTransparency = 1}).Completed:Wait()

		UI.BG.Visible = false
		STATE.suppressRefocus = false

		resetInputAndSuggestions()
		hideHelpList()
	end

	 function toggleMenu()
		if STATE.menuOpen then
			closeMenu()
		else
			openMenu()
		end

		task.defer(function()
			if UI.CommandInput.Text:find(";") then
				UI.CommandInput.Text = UI.CommandInput.Text:gsub(";", "")
				UI.CommandInput.CursorPosition = #UI.CommandInput.Text + 1
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

	TAB_FILL_COMMANDS = {
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
		gravity = "gravity ",
		hipheight = "hipheight ",
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
		end

		task.defer(function()
			if STATE.menuOpen then
				UI.CommandInput:CaptureFocus()
			end
		end)
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
	if not gameProcessed and not UI.CommandInput:IsFocused() then
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

		local boundCommands = STATE.keybinds[key]
		if boundCommands then
			for _, cmd in ipairs(boundCommands) do
				executeCommand(cmd)
			end
			return
		end
	end

	if input.KeyCode == Enum.KeyCode.Semicolon then
		if not STATE.WelcomeFinished then
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

	if input.KeyCode == Enum.KeyCode.Tab and UI.CommandInput:IsFocused() then
		local best = STATE.currentBestMatch
		if best then
			UI.CommandInput.Text = TAB_FILL_COMMANDS[best.Name] or best.Name
			UI.CommandInput.CursorPosition = #UI.CommandInput.Text + 1
			UI.CommandInput:CaptureFocus()
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
		UI.OuterChatModule.Visible = false
		UI.ChatModule.Visible = false
		startGlobalPlayerTracking()
		startChatlogsSystem()
		initializeCoreGuiStates()
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
						-- keep current custom hipheight after respawn only if user had changed it
						-- nothing to do here unless you want to persist a custom amount
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
