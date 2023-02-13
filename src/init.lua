local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
assert(RunService:IsClient(), "Viewmodel is a Client only class.")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local CULL_CFRAME = CFrame.new(0, 1e29, 0)

--[=[
	@class Viewmodel
]=]
--[=[
	The Settings of the Viewmodel.
	@prop Settings ViewmodelSettings
	@within Viewmodel
]=]
--[=[
	The actual instance of the Viewmodel.
	@prop Instance Model
	@within Viewmodel
	@readonly
]=]
--[=[
	The animator of the Viewmodel instance.
	@prop Animator Animator
	@within Viewmodel
	@readonly
]=]
--[=[
	Determines if the Viewmodel should be visible to the Camera or not.
	If set to true the Viewmodel will be sent to the internal constant CULL_CFRAME.
	@prop Culled boolean
	@within Viewmodel
]=]
export type Viewmodel = {
	Settings: ViewmodelSettings;
	Instance: Model;
	Animator: Animator;
	Culled: boolean;
	Animations: {AnimationTrack};
	__oldCamCFrame: CFrame;

	Cull: (self: Viewmodel, state: boolean) -> ();
	LoadAnimation: (self: Viewmodel, key: string, animation: Animation) -> (AnimationTrack);
	GetAnimation: (self: Viewmodel, key: string) -> (AnimationTrack?);
	UnloadAnimation: (self: Viewmodel, key: string) -> ();
	Update: (self: Viewmodel, deltaTime: number, viewmodelCFrame: CFrame) -> ();
}

--[=[
	All settings inside ViewmodelSettings can be changed at run time to your liking.
	@interface ViewmodelSettings
	@within Viewmodel
	@field AnimateCamera boolean -- Animates FakeCamera movement to Camera if set to true
	@field UseCharacterShirt boolean -- Self explanatory
	@field LeftArmColor Color3? -- Set as nil for default
	@field RightArmColor Color3? -- Set as nil for default
]=]
export type ViewmodelSettings = {
	AnimateCamera: boolean;
	UseCharacterShirt: boolean;
	LeftArmColor: Color3?;
	RightArmColor: Color3?;
}

local Viewmodel: Viewmodel = {}
Viewmodel.__index = Viewmodel

local function checkViewmodelInstance(viewmodelInstance: Model, viewmodelSettings: ViewmodelSettings)
	assert(viewmodelInstance:FindFirstChild("HumanoidRootPart"))
	assert(viewmodelSettings or viewmodelInstance:FindFirstChild("Settings"))
	assert(viewmodelInstance:FindFirstChild("FakeCamera"))
	assert(viewmodelInstance:FindFirstChild("Left Arm"))
	assert(viewmodelInstance:FindFirstChild("Right Arm"))
	assert(viewmodelInstance:FindFirstChildWhichIsA("AnimationController") or viewmodelInstance:FindFirstChildWhichIsA("Humanoid"))
end

local function getAnimator(viewmodelInstance: Model, viewmodelSettings: ViewmodelSettings): Animator
	checkViewmodelInstance(viewmodelInstance, viewmodelSettings)
	local animatorContainer: AnimationController & Humanoid = 
		viewmodelInstance:FindFirstChildWhichIsA("AnimationController") or 
		viewmodelInstance:FindFirstChildWhichIsA("Humanoid")
	local animator = animatorContainer:FindFirstChildWhichIsA("Animator") or Instance.new("Animator", animatorContainer)
	return animator
end

local function cleanViewmodelInstance(viewmodelInstance: Model, viewmodelSettings: ViewmodelSettings)
	checkViewmodelInstance(viewmodelInstance, viewmodelSettings)
	viewmodelInstance.PrimaryPart = viewmodelInstance.HumanoidRootPart
	if viewmodelInstance:FindFirstChild("AnimSaves") then
		viewmodelInstance.AnimSaves:Destroy()
	end
	for _, obj in pairs(viewmodelInstance:GetDescendants()) do
		if obj:IsA("BasePart") or obj:IsA("UnionOperation") then
			obj.CanCollide = false
			obj.CastShadow = false
		end
	end
end

local function updateArms(viewmodelInstance: Model, viewmodelSettings: ViewmodelSettings)
	checkViewmodelInstance(viewmodelInstance, viewmodelSettings)
	local character = LocalPlayer.Character
	if character then
		local shirt: Shirt = character:FindFirstChildWhichIsA("Shirt")
		local leftArm: Part = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
		local rightArm: Part = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
		local vmLeftArm: Part = viewmodelInstance:FindFirstChild("Left Arm")
		local vmRightArm: Part = viewmodelInstance:FindFirstChild("Right Arm")
		
		vmLeftArm.Color = viewmodelSettings.LeftArmColor or leftArm.Color
		vmRightArm.Color = viewmodelSettings.RightArmColor or rightArm.Color
		
		if viewmodelSettings.UseCharacterShirt then
			local vmLeftArmShirt: Decal = vmLeftArm:FindFirstChild("Shirt")
			local vmRightArmShirt: Decal = vmRightArm:FindFirstChild("Shirt")

			if vmLeftArmShirt then
				if shirt then
					vmLeftArmShirt.Texture = shirt.ShirtTemplate
					vmLeftArmShirt.Color3 = shirt.Color3
				else
					vmLeftArmShirt.Transparency = 1
				end
			end

			if vmRightArmShirt then
				if shirt then
					vmRightArmShirt.Texture = shirt.ShirtTemplate
					vmRightArmShirt.Color3 = shirt.Color3
				else
					vmRightArmShirt.Transparency = 1
				end
			end
		end
	end
end

--[=[
	Sets the Culled property of the Viewmodel to the first argument.
	@return void
]=]
function Viewmodel:Cull(state: boolean)
	self.Culled = state
end

--[=[
	Loads the given animation into the Viewmodel's Animator.
	@return AnimationTrack
]=]
function Viewmodel:LoadAnimation(key: string, animation: Animation): AnimationTrack
	assert(self.Animations[key] == nil, string.format("Animation key %s is already taken, unload this key first before loading a new one.", key))
	assert(
		typeof(animation) == "Instance" and animation:IsA("Animation"), 
		string.format(
			"Animation argument is invalid (type %s - class %s)", 
			typeof(animation), (typeof(animation) == "Instance" and animation.ClassName))
	)
	
	local animationTrack = self.Animator:LoadAnimation(animation)
	self.Animations[key] = animationTrack
	return animationTrack
end

--[=[
	Retrieves the AnimationTrack that is assigned to the given key.
	@return AnimationTrack?
]=]
function Viewmodel:GetAnimation(key: string): AnimationTrack?
	return self.Animations[key]
end

--[=[
	Unloads the AnimationTrack from the Viewmodel's Animator.
	@return void
]=]
function Viewmodel:UnloadAnimation(key: string)
	assert(self.Animations[key], string.format("%s is not a valid member of this Viewmodel's animations"))
	
	local animationTrack: AnimationTrack = self.Animations[key]
	self.Animations[key] = nil
	animationTrack:Destroy()
end

--[=[
	Updater function of the viewmodel, must be run every RenderStep.
	@return void
]=]
function Viewmodel:Update(deltaTime: number, viewmodelCFrame: CFrame)
	self.Instance:PivotTo(self.Culled and CULL_CFRAME or viewmodelCFrame)
	if not self.Culled then
		updateArms(self.Instance, self.Settings)
		if self.Settings.AnimateCamera then
			local fakeCamera: Part = self.Instance.FakeCamera
			local newCamCFrame = fakeCamera.CFrame:ToObjectSpace(self.Instance.PrimaryPart.CFrame)
			if self.__oldCamCFrame then
				local _, _, z = newCamCFrame:ToOrientation()
				local x, y, _ = newCamCFrame:ToObjectSpace(self.__oldCamCFrame):ToEulerAnglesXYZ()
				Camera.CFrame = Camera.CFrame * CFrame.Angles(x, y, -z)
			end
			self.__oldCamCFrame = newCamCFrame
		end
	end
end

--[=[
	Constructor of the Class.
	If viewmodelSettings is not provided, it will look for Settings inside viewmodelInstance.
	@return Viewmodel
]=]
function Viewmodel.new(viewmodelInstance: Model, viewmodelSettings: ViewmodelSettings): Viewmodel
	checkViewmodelInstance(viewmodelInstance, viewmodelSettings)
	cleanViewmodelInstance(viewmodelInstance, viewmodelSettings)
	local self: Viewmodel = setmetatable({
		Settings = viewmodelSettings or require(viewmodelInstance.Settings);
		Instance = viewmodelInstance;
		Animator = getAnimator(viewmodelInstance, viewmodelSettings);
		Culled = false;
		Animations = {};
	}, Viewmodel)
	return self
end

return Viewmodel :: {
	new: (viewmodelInstance: Model, viewmodelSettings: ViewmodelSettings) -> Viewmodel
}
