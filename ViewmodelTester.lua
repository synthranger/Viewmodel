-- EXAMPLE

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local Util = require(game.ReplicatedFirst:WaitForChild("Utility"))

local Client = game.ReplicatedStorage.Client
local Viewmodel = require(Client.Modules.Viewmodel)
local Spring = require(Client.Modules.Spring)

local SwaySpring = Spring.new()

local v_M4A1 = Client.ViewmodelTesterAssets:WaitForChild("v_M4A1")
local M4A1Viewmodel = Viewmodel.new(v_M4A1)

local function useSoundsForAnimation(animationTrack: AnimationTrack, soundDict: {[number]: Sound}): {[number]: RBXScriptConnection}
	local connections = {}
	for _, sound in pairs(soundDict) do
		table.insert(connections, animationTrack:GetMarkerReachedSignal(sound.Name):Connect(function()
			Util.General.ClonePlay(sound, LocalPlayer.PlayerGui)
		end))
	end
	return connections
end

local function isFirstPerson(): boolean
	local character = LocalPlayer.Character
	if character and (character.Head.CFrame.p - workspace.CurrentCamera.CFrame.p).magnitude < 1 then
		return true
	else
		return false
	end
end

v_M4A1.Parent = workspace.CurrentCamera
M4A1Viewmodel:LoadAnimation("Idle", Client.ViewmodelTesterAssets:WaitForChild("Idle")):Play(0)
local TacReloadAnim = M4A1Viewmodel:LoadAnimation("TacReload", Client.ViewmodelTesterAssets:WaitForChild("TacReload"))

useSoundsForAnimation(TacReloadAnim, Client.ViewmodelTesterAssets.Sounds:GetChildren())

UserInputService.InputBegan:Connect(function(input: InputObject, gp: boolean)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.R and not TacReloadAnim.IsPlaying then
		TacReloadAnim:Play()
	end
end)

RunService.RenderStepped:Connect(function(deltaTime)
	local scaledDeltaTime = deltaTime * 60
	
	local firstPerson = isFirstPerson()
	M4A1Viewmodel:Cull(not firstPerson)
	
	local swaySpringPosition = SwaySpring:Update(deltaTime)
	
	local nextCFrame = workspace.CurrentCamera.CFrame
	M4A1Viewmodel:Update(deltaTime, nextCFrame)
	
	local joint: BasePart = M4A1Viewmodel.Instance:FindFirstChild("Joint")
	if joint then
		local jointCFrame = joint.CFrame
		jointCFrame = jointCFrame * CFrame.new(swaySpringPosition.Y, swaySpringPosition.X, 0)
		jointCFrame = jointCFrame * CFrame.Angles(swaySpringPosition.X, swaySpringPosition.Y, swaySpringPosition.Z)
		joint.CFrame = jointCFrame
	end
	
	local mouseDelta = UserInputService:GetMouseDelta()
	local swayForce = Vector3.new(-mouseDelta.Y, -mouseDelta.X, -mouseDelta.X / 2) / 250
	SwaySpring:Displace(Util.Vector.Clamp(swayForce, -0.05, 0.05))
end)
