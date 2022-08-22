"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[671],{3905:function(e,n,t){t.d(n,{Zo:function(){return d},kt:function(){return m}});var r=t(67294);function a(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function o(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function i(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?o(Object(t),!0).forEach((function(n){a(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):o(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,r,a=function(e,n){if(null==e)return{};var t,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)t=o[r],n.indexOf(t)>=0||(a[t]=e[t]);return a}(e,n);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)t=o[r],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(a[t]=e[t])}return a}var c=r.createContext({}),u=function(e){var n=r.useContext(c),t=n;return e&&(t="function"==typeof e?e(n):i(i({},n),e)),t},d=function(e){var n=u(e.components);return r.createElement(c.Provider,{value:n},e.children)},p={inlineCode:"code",wrapper:function(e){var n=e.children;return r.createElement(r.Fragment,{},n)}},s=r.forwardRef((function(e,n){var t=e.components,a=e.mdxType,o=e.originalType,c=e.parentName,d=l(e,["components","mdxType","originalType","parentName"]),s=u(t),m=a,f=s["".concat(c,".").concat(m)]||s[m]||p[m]||o;return t?r.createElement(f,i(i({ref:n},d),{},{components:t})):r.createElement(f,i({ref:n},d))}));function m(e,n){var t=arguments,a=n&&n.mdxType;if("string"==typeof e||a){var o=t.length,i=new Array(o);i[0]=s;var l={};for(var c in n)hasOwnProperty.call(n,c)&&(l[c]=n[c]);l.originalType=e,l.mdxType="string"==typeof e?e:a,i[1]=l;for(var u=2;u<o;u++)i[u]=t[u];return r.createElement.apply(null,i)}return r.createElement.apply(null,t)}s.displayName="MDXCreateElement"},59881:function(e,n,t){t.r(n),t.d(n,{frontMatter:function(){return l},contentTitle:function(){return c},metadata:function(){return u},toc:function(){return d},default:function(){return s}});var r=t(87462),a=t(63366),o=(t(67294),t(3905)),i=["components"],l={},c="Getting Started",u={unversionedId:"intro",id:"intro",isDocsHomePage:!1,title:"Getting Started",description:"Installation",source:"@site/docs/intro.md",sourceDirName:".",slug:"/intro",permalink:"/Viewmodel/docs/intro",editUrl:"https://github.com/Synthranger/Viewmodel/edit/main/docs/intro.md",tags:[],version:"current",frontMatter:{},sidebar:"defaultSidebar"},d=[{value:"Installation",id:"installation",children:[{value:"Via Wally",id:"via-wally",children:[],level:3},{value:"Manual Installation",id:"manual-installation",children:[],level:3}],level:2},{value:"Example Usage",id:"example-usage",children:[],level:2}],p={toc:d};function s(e){var n=e.components,t=(0,a.Z)(e,i);return(0,o.kt)("wrapper",(0,r.Z)({},p,t,{components:n,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"getting-started"},"Getting Started"),(0,o.kt)("h2",{id:"installation"},"Installation"),(0,o.kt)("h3",{id:"via-wally"},"Via Wally"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-toml"},'Viewmodel = "synthranger/viewmodel@0.1.0"\n')),(0,o.kt)("h3",{id:"manual-installation"},"Manual Installation"),(0,o.kt)("p",null,"Just paste ",(0,o.kt)("inlineCode",{parentName:"p"},"src/init.lua")," into your project and rename it as Viewmodel and you're done!"),(0,o.kt)("h2",{id:"example-usage"},"Example Usage"),(0,o.kt)("p",null,"For a full example, check out the samples folder in the repo."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local Viewmodel = require(path.to.Viewmodel)\nlocal newVM = Viewmodel.new(viewmodelInstance, {\n    AnimateCamera = true;\n    UseCharacterShirt = true;\n    LeftArmColor = nil;\n    RightArmColor = nil;\n})\n\nRunService.RenderStepped:Connect(function(dt)\n    newVM:Update(dt, Camera.CFrame)\nend)\n\nnewVM:Cull(true) -- hides viewmodel from Camera\ntask.wait(1)\nnewVM:Cull(false)\n\nnewVM:LoadAnimation("Wave", waveAnim):Play() -- :LoadAnimation() returns the loaded AnimationTrack\nnewVM:GetAnimation("Wave"):Stop()\ntask.wait(5)\nnewVM:UnloadAnimation("Wave")\n')))}s.isMDXComponent=!0}}]);