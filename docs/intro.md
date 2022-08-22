# Getting Started

## Installation
### Via Wally
```toml
Viewmodel = "synthranger/viewmodel@0.1.0"
```
### Manual Installation
Just paste `src/init.lua` into your project and rename it as Viewmodel and you're done!

## Example Usage
For a full example, check out the samples folder in the repo.
```lua
local Viewmodel = require(path.to.Viewmodel)
local newVM = Viewmodel.new(viewmodelInstance, {
	AnimateCamera = true;
	UseCharacterShirt = true;
	LeftArmColor = nil;
	RightArmColor = nil;
})

RunService.RenderStepped:Connect(function(dt)
    newVM:Update(dt, Camera.CFrame)
end)

newVM:Cull(true) -- hides viewmodel from Camera
task.wait(1)
newVM:Cull(false)

newVM:LoadAnimation("Wave", waveAnim):Play() -- :LoadAnimation() returns the loaded AnimationTrack
newVM:GetAnimation("Wave"):Stop()
task.wait(5)
newVM:UnloadAnimation("Wave")
```