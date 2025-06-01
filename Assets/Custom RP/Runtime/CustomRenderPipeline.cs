﻿using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.RenderGraphModule;

public partial class CustomRenderPipeline : RenderPipeline
{
	readonly CameraRenderer renderer;

	readonly CustomRenderPipelineSettings settings;

	readonly RenderGraph renderGraph = new("Custom SRP Render Graph");

	public CustomRenderPipeline(CustomRenderPipelineSettings settings)
	{
		this.settings = settings;
		GraphicsSettings.useScriptableRenderPipelineBatching =
			settings.useSRPBatcher;
		GraphicsSettings.lightsUseLinearIntensity = true;
		InitializeForEditor();
		renderer =
			new(settings.cameraRendererShader, settings.cameraDebuggerShader);
	}

	protected override void Render(
		ScriptableRenderContext context, List<Camera> cameras)
	{
		for (int i = 0; i < cameras.Count; i++)
		{
			renderer.Render(renderGraph, context, cameras[i], settings);
		}
		renderGraph.EndFrame();
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		DisposeForEditor();
		renderer.Dispose();
		renderGraph.Cleanup();
	}
}
