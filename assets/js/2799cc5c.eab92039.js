"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[663],{99947:function(e){e.exports=JSON.parse('{"functions":[{"name":"Cull","desc":"Sets the Culled property of the Viewmodel to the first argument.","params":[{"name":"state","desc":"","lua_type":"boolean"}],"returns":[{"desc":"","lua_type":"void"}],"function_type":"method","source":{"line":144,"path":"src/init.lua"}},{"name":"LoadAnimation","desc":"Loads the given animation into the Viewmodel\'s Animator.","params":[{"name":"key","desc":"","lua_type":"string"},{"name":"animation","desc":"","lua_type":"Animation"}],"returns":[{"desc":"","lua_type":"AnimationTrack"}],"function_type":"method","source":{"line":152,"path":"src/init.lua"}},{"name":"GetAnimation","desc":"Retrieves the AnimationTrack that is assigned to the given key.","params":[{"name":"key","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"AnimationTrack?"}],"function_type":"method","source":{"line":170,"path":"src/init.lua"}},{"name":"UnloadAnimation","desc":"Unloads the AnimationTrack from the Viewmodel\'s Animator.","params":[{"name":"key","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"void"}],"function_type":"method","source":{"line":178,"path":"src/init.lua"}},{"name":"Update","desc":"Updater function of the viewmodel, must be run every RenderStep.","params":[{"name":"deltaTime","desc":"","lua_type":"number"},{"name":"viewmodelCFrame","desc":"","lua_type":"CFrame"}],"returns":[{"desc":"","lua_type":"void"}],"function_type":"method","source":{"line":190,"path":"src/init.lua"}},{"name":"new","desc":"Constructor of the Class.\\nIf viewmodelSettings is not provided, it will look for Settings inside viewmodelInstance.","params":[{"name":"viewmodelInstance","desc":"","lua_type":"Model"},{"name":"viewmodelSettings","desc":"","lua_type":"ViewmodelSettings"}],"returns":[{"desc":"","lua_type":"Viewmodel"}],"function_type":"static","source":{"line":212,"path":"src/init.lua"}}],"properties":[{"name":"Settings","desc":"The Settings of the Viewmodel.","lua_type":"ViewmodelSettings","source":{"line":18,"path":"src/init.lua"}},{"name":"Instance","desc":"The actual instance of the Viewmodel.","lua_type":"Model","readonly":true,"source":{"line":24,"path":"src/init.lua"}},{"name":"Animator","desc":"The animator of the Viewmodel instance.","lua_type":"Animator","readonly":true,"source":{"line":30,"path":"src/init.lua"}},{"name":"Culled","desc":"Determines if the Viewmodel should be visible to the Camera or not.\\nIf set to true the Viewmodel will be sent to the internal constant CULL_CFRAME.","lua_type":"boolean","source":{"line":36,"path":"src/init.lua"}}],"types":[{"name":"ViewmodelSettings","desc":"All settings inside ViewmodelSettings can be changed at run time to your liking.","fields":[{"name":"AnimateCamera","lua_type":"boolean","desc":"Animates FakeCamera movement to Camera if set to true"},{"name":"UseCharacterShirt","lua_type":"boolean","desc":"Self explanatory"},{"name":"LeftArmColor","lua_type":"Color3?","desc":"Set as nil for default"},{"name":"RightArmColor","lua_type":"Color3?","desc":"Set as nil for default"}],"source":{"line":60,"path":"src/init.lua"}}],"name":"Viewmodel","desc":"","source":{"line":13,"path":"src/init.lua"}}')}}]);