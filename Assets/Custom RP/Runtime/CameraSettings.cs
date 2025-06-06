﻿using System;
using UnityEngine;
using UnityEngine.Rendering;

[Serializable]
public class CameraSettings
{
	public bool copyColor = true, copyDepth = true;

	public RenderingLayerMask newRenderingLayerMask = -1;

	public bool maskLights = false;

	public enum RenderScaleMode
	{ Inherit, Multiply, Override }

	public RenderScaleMode renderScaleMode = RenderScaleMode.Inherit;

	[Range(CameraRenderer.renderScaleMin, CameraRenderer.renderScaleMax)]
	public float renderScale = 1f;

	public bool overridePostFX = false;

	public PostFXSettings postFXSettings = default;

	public bool allowFXAA = false;

	public bool keepAlpha = false;

	[Serializable]
	public struct FinalBlendMode
	{
		public BlendMode source, destination;
	}

	public FinalBlendMode finalBlendMode = new()
	{
		source = BlendMode.One,
		destination = BlendMode.Zero
	};

	public float GetRenderScale(float scale) =>
		renderScaleMode == RenderScaleMode.Inherit ? scale :
		renderScaleMode == RenderScaleMode.Override ? renderScale :
		scale * renderScale;
}
