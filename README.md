# Viewmodel
Viewmodel class for handling viewmodels in FPS frameworks

## Documentation
```lua
    Viewmodel.new(viewmodelInstance: Model): Viewmodel
```
Constructs a new viewmodel object.

```lua
    Viewmodel:Update(deltaTime: number, viewmodelCFrame: CFrame)
```
It is very important to always update every frame or else the viewmodel might still appear even thought :Cull() has been called.

```lua
    Viewmodel:Cull(state: boolean)
```
Toggles if the viewmodel will be culled or not. (true = culled, false = unculled)

```lua
    Viewmodel:LoadAnimation(key: string, animation: Animation): AnimationTrack
```
Loads the animation to the viewmodel and returns the AnimationTrack so you can set it as a variable.

```lua
    Viewmodel:GetAnimation(key: string): AnimationTrack?
```
Returns the AnimationTrack assigned to the key if it exists in the dictionary.

```lua
    Viewmodel:UnloadAnimation(key: string)
```
Unloads the animation.
