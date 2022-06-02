# Viewmodel
Viewmodel class for handling viewmodels in FPS frameworks

## Documentation
| Function | Description |
| --- | --- |
|`Viewmodel.new(viewmodelInstance: Model): Viewmodel`|Constructs a new viewmodel object.|
|`Viewmodel:Update(deltaTime: number, viewmodelCFrame: CFrame)`|It is very important to always update every frame or else the viewmodel might still appear even though :Cull() has been called.|
|`Viewmodel:Cull(state: boolean)`|Toggles if the viewmodel will be culled or not. (true = culled, false = unculled)|
|`Viewmodel:LoadAnimation(key: string, animation: Animation): AnimationTrack`|Loads the animation to the viewmodel and returns the AnimationTrack so you can set it as a variable.|
|`Viewmodel:GetAnimation(key: string): AnimationTrack`|Returns the AnimationTrack assigned to the key if it exists in the dictionary.|
|`Viewmodel:UnloadAnimation(key: string)`|Unloads the animation.|
