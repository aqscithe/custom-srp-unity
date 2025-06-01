# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Upgraded **Unity** to version 6000.1.4f1.
- Upgraded **Burst** to version 1.8.21.
- Upgraded **Core RP Library** to version 17.1.0.
- Use unsafe render passes.

### Fixed
- Changed capitalization of `UnpackNormalMapRGorAG` to match Unity's rename.
- Workaround for missing profiling samplers Unity bug in release builds.

### Removed
- Obsolete `CustomRenderPipeline.Render` method.
- Obsolete `CameraSettings.renderingLayerMask` field.

## [4.0.0] - 2024-11-22

### Changed
- Upgraded **Unity** to version 6000.0.24f1.
- Upgraded **Burst** to version 1.8.18.
- Upgraded **Core RP Library** to version 17.0.3.
- Upgraded **Mathematics** to version 1.3.2.
- Upgraded **Unity UI** to version 2.0.0.
- Removed newly-added **Multiplayer Center** package.
- Changed code to work with Unity 6.
- Rebaked scene lighting assets.

### Removed
- Deprecated settings and automatic settings upgrade.

## [3.2.0] - 2024-10-10

### Added
- Unified low/mid/high quality setting for shadow filtering.
- Toggle to enable shadow cascade blending, otherwise dithering is used.

### Changed
- Upgraded **Unity** to version 2022.3.48f1.
- Shadows filter quality settings simplified to a single low/med/high option.
- Cascade blend mode simplified to a single toggle for soft vs. dithering.
- Rendering is always done to an intermediate texture.

### Deprecated
- Seperate filter quality settings for directional and other shadows.
- Cascade blend mode with three options, replaced with a toggle.

### Removed
- Lights-per-object lighting method.

## [3.1.0] - 2024-08-27

### Added

- Forward Plus settings for tile size and max lights per tile.

### Changed

- Upgraded **Unity** to version 2022.3.43f1.
- Upgraded **Burst** to version 1.8.17.
- Hidden deprecated settings in `CustomRenderPipelineAsset`.
- Automatically set deprecated references to `null`.
- Reduce tile data size based on visible light count.

### Deprecated
- Lights-per-object drawing mode option is marked as deprecated.

## [3.0.0] - 2024-05-30

## Added

- Simple tiled Forward+ lighting.
- Camera debugger pass that can be enabled via the `Rendering Debugger`.
- *Many Lights* scene.

### Changed

- Updated Unity to version 2022.3.27f1.
- Updated **Core RP Library** package to version 14.0.11.
- Included **Burst** package version 1.8.15.
- Included **Mathematics** package version 1.2.6.
- Moved RP settings to `CustomRenderPipelineSettings` class.

### Deprecated

- Top-level `CustomRenderPipelineAsset` settings have been moved, but still exist to automatically migrate them. They will be removed in a later version.

### Removed

- Previously deprecated settings.

### Fixed

- Always set shadow buffers even if no shadows are drawn, to prevent skipped draw calls.

## [2.5.0] - 2024-03-30

### Changed

- Updated Unity to version 2022.3.22f1.
- Updated **Core RP Library** package to version 14.0.10.
- HLSL and shader code style changed to match C#.
- Use the full word `directional` instead of `dir` shorthand in field names.
- Light and shadow data is stored in structured buffers instead of arrays.
- Isolated inner structured buffer struct types, putting them in partial classes.
- Renamed `ShadowTextures` to `ShadowResources` and wrapped in `LightResources`.

## [2.4.0] - 2024-01-13

### Changed

- Updated Unity to version 2022.3.16f1.
- Explicitly marked all anonymous render functions as static.
- Use local `bufferSettings.allowHDR` instead of separate `useHDR` variable in `CameraRenderer`.
- Moved logic to decide whether post FX are active for a camera to new `PostFXSettings.IsActiveFor` method.
- Moved logic from `PostFXStack` to `PostFXPass`, `BloomPass`, and `ColorLUTPass`.
- `PostFXStack` only facilitates drawing and access to common settings.
- Post FX textures are managed by the render graph.

## [2.3.0] - 2023-11-21

### Changed

- Updated Unity to version 2022.3.12f1.
- Updated **Core RP Library** package to version 14.0.9.
- Shadow textures are managed by the render graph.
- `LightingPass` sets up lights and shadows in `Record` instead of `Render`.
- `GeometryPass` register reading from shadow textures.
- Merged `Lighting` into `LightingPass`.
- Set global shader keywords via buffer using `GlobalKeyword`.

## [2.2.0] - 2023-10-12

### Changed

- Color and depth attachments and their copies are managed by the render graph.
- `SetupPass` registers color and depth copies instead of `CopyAttachmentsPass`.
- Passes register their usage of attachments and their copies.
- Passes are decoupled from `CameraRenderer`. `CameraRendererCopier` facilitates texture copying.

## [2.1.0] - 2023-09-29

### Changed

- Opaque, transparent, and unsupported-shaders geometry is drawn via renderer lists.
- `VisibleGeometryPass` replaced with `GeometryPass`, `SkyboxPass`, and `CopyAttachmentPass`.
- Dynamic batching is no longer used.
- GPU instancing is always enabled.

### Deprecated

- `CustomRenderPipelineAsset` configuration options **Use Dynamic Batching** and **Use GPU Instancing**. 

## [2.0.0] - 2023-08-21

### Added

- _Render Graph Viewer_ can show passes used for every camera.

### Changed

- Use Render Graph API exclusively. This means no easy porting back to Unity 2019.
- Split rendering code into multiple passes, found in the _Runtime / Passes_ folder.
- Profiler and frame debugger hierarchy changed due to switch to render graph.
- Camera names are cached for profiling, if camera has `CustomRenderPipelineCamera` component, otherwise its camera type is used as its name.
- Cached camera names are reset at domain or scene reload, or when camera is enabled in editor play mode and development builds.
- No more _Editor Only_ allocations every frame while in the editor.
- Pre-FX gizmos are now also drawn after post FX,  although they don't appear to exist.

## [1.0.0] - 2023-08-14

### Added

- Support inner cone angle and falloff for baking spotlights.
- Lighting settings assets for all scenes.
- **.gitignore** file.

### Changed

- Updated Unity to version 2022.3.5f1.
- Updated **Core RP Library** package to version 14.0.8 and removed AI package.
- Switched to `CustomRenderPipeline.Render` version with list instead of array parameter.
- Disabled automatic baking for **Baked Light** scene so generated maps can be inspected.
- Provide required `BatchCullingProjectionType` argument to `DrawShadowSettings` constructor, even through it will be deprecated again in Unity 2023.
- Project _Enter Play Mode Settings_ set to not reload domain and scene.
- C# code uses more modern syntax and more closely matches standard and Unity C# style.
- Moved scenes to their own folders.
- Moved materials to a common and to scene-specific folders.

### Fixed

- Added missing matrices to **Common.hlsl** and **UnityInput.hlsl**.
- Also clear color when skybox is used, to avoid `NaN` and `Inf` values that can mess up frame buffer blending.
- Always perform a buffer load for the final draw if using a reduced viewport, to prevent artifacts on tile-based GPUs.
- Copy depth once more after post FX, so post-FX gizmos correctly use depth.
- Normalize unpacked normal vectors because Unity no longer does this.
- Removed duplicate for-loop iterator variable declaration in **FXAAPass.hlsl** to avoid shader compiler warning.
