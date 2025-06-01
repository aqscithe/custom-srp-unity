#ifndef CUSTOM_LIT_INPUT_INCLUDED
#define CUSTOM_LIT_INPUT_INCLUDED

// SRP Batcher compatibility: Use constant buffers for material properties, rather than legacy global uniforms. 
// In practice, wrap your material properties in a CBUFFER_START/END (e.g. UnityPerMaterial) block so the SRP Batcher 
// can handle them ￼. DOTS instancing leverages the SRP Batcher’s “fast path” to persist instance data on the GPU

CBUFFER_START(UnityPerMaterial)
float4 _BaseMap_ST;
float4 _DetailMap_ST;
float4 _BaseColor;
float4 _EmissionColor;
float _Cutoff;
float _ZWrite;
float _Metallic;
float _Occlusion;
float _Smoothness;
float _Fresnel;
float _DetailAlbedo;
float _DetailSmoothness;
float _DetailNormalScale;
float _NormalScale;
float _Surface;
CBUFFER_END


#ifdef UNITY_DOTS_INSTANCING_ENABLED
/*
#undef unity_ObjectToWorld
#undef unity_WorldToObject

UNITY_DOTS_INSTANCING_START(BuiltinPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP(float3x4, unity_ObjectToWorld)
    UNITY_DOTS_INSTANCED_PROP(float3x4, unity_WorldToObject)
UNITY_DOTS_INSTANCING_END(BuiltinPropertyMetadata)
*/

UNITY_DOTS_INSTANCING_START(MaterialPropertyMetadata)
	UNITY_DOTS_INSTANCED_PROP(float4, _BaseMap_ST)
	UNITY_DOTS_INSTANCED_PROP(float4, _DetailMap_ST)
	UNITY_DOTS_INSTANCED_PROP(float4, _BaseColor)
	UNITY_DOTS_INSTANCED_PROP(float4, _EmissionColor)
	UNITY_DOTS_INSTANCED_PROP(float, _Cutoff)
	UNITY_DOTS_INSTANCED_PROP(float, _ZWrite)
	UNITY_DOTS_INSTANCED_PROP(float, _Metallic)
	UNITY_DOTS_INSTANCED_PROP(float, _Occlusion)
	UNITY_DOTS_INSTANCED_PROP(float, _Smoothness)
	UNITY_DOTS_INSTANCED_PROP(float, _Fresnel)
	UNITY_DOTS_INSTANCED_PROP(float, _DetailAlbedo)
	UNITY_DOTS_INSTANCED_PROP(float, _DetailSmoothness)
	UNITY_DOTS_INSTANCED_PROP(float, _DetailNormalScale)
	UNITY_DOTS_INSTANCED_PROP(float, _NormalScale)
UNITY_DOTS_INSTANCING_END(MaterialPropertyMetadata)

// Here, we want to avoid overriding a property like e.g. _BaseColor with something like this:
// #define _BaseColor UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float4, _BaseColor0)
//
// It would be simpler, but it can cause the compiler to regenerate the property loading code for each use of _BaseColor.
//
// To avoid this, the property loads are cached in some static values at the beginning of the shader.
// The properties such as _BaseColor are then overridden so that it expand directly to the static value like this:
// #define _BaseColor unity_DOTS_Sampled_BaseColor
//
// This simple fix happened to improve GPU performances by ~10% on Meta Quest 2 with URP on some scenes.

static float4 unity_DOTS_Sampled_BaseMap_ST;
static float4 unity_DOTS_Sampled_DetailMap_ST;
static float4 unity_DOTS_Sampled_BaseColor;
static float4 unity_DOTS_Sampled_EmissionColor;
static float  unity_DOTS_Sampled_Cutoff;
static float  unity_DOTS_Sampled_ZWrite;
static float  unity_DOTS_Sampled_Metallic;
static float  unity_DOTS_Sampled_Occlusion;
static float  unity_DOTS_Sampled_Smoothness;
static float  unity_DOTS_Sampled_Fresnel;
static float  unity_DOTS_Sampled_DetailAlbedo;
static float  unity_DOTS_Sampled_DetailSmoothness;
static float  unity_DOTS_Sampled_DetailNormalScale;
static float  unity_DOTS_Sampled_NormalScale;

void SetupDOTSLitMaterialPropertyCaches()
{
	unity_DOTS_Sampled_BaseMap_ST = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float4, _BaseMap_ST);
	unity_DOTS_Sampled_DetailMap_ST = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float4, _DetailMap_ST);
	unity_DOTS_Sampled_BaseColor = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float4, _BaseColor);
	unity_DOTS_Sampled_EmissionColor = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float4, _EmissionColor);
	unity_DOTS_Sampled_Cutoff = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _Cutoff);
	unity_DOTS_Sampled_ZWrite = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _ZWrite);
	unity_DOTS_Sampled_Metallic = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _Metallic);
	unity_DOTS_Sampled_Occlusion = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _Occlusion);
	unity_DOTS_Sampled_Smoothness = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _Smoothness);
	unity_DOTS_Sampled_Fresnel = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _Fresnel);
	unity_DOTS_Sampled_DetailAlbedo = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _DetailAlbedo);
	unity_DOTS_Sampled_DetailSmoothness = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _DetailSmoothness);
	unity_DOTS_Sampled_DetailNormalScale = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _DetailNormalScale);
	unity_DOTS_Sampled_NormalScale = UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(float, _NormalScale);
}

#undef UNITY_SETUP_DOTS_MATERIAL_PROPERTY_CACHES
#define UNITY_SETUP_DOTS_MATERIAL_PROPERTY_CACHES() SetupDOTSLitMaterialPropertyCaches()

#define _BaseMap_ST             unity_DOTS_Sampled_BaseMap_ST
#define _DetailMap_ST           unity_DOTS_Sampled_DetailMap_ST
#define _BaseColor              unity_DOTS_Sampled_BaseColor
#define _EmissionColor          unity_DOTS_Sampled_EmissionColor
#define _Cutoff                 unity_DOTS_Sampled_Cutoff
#define _ZWrite                 unity_DOTS_Sampled_ZWrite
#define _Metallic               unity_DOTS_Sampled_Metallic
#define _Occlusion              unity_DOTS_Sampled_Occlusion
#define _Smoothness             unity_DOTS_Sampled_Smoothness
#define _Fresnel                unity_DOTS_Sampled_Fresnel
#define _DetailAlbedo           unity_DOTS_Sampled_DetailAlbedo
#define _DetailSmoothness       unity_DOTS_Sampled_DetailSmoothness
#define _DetailNormalScale      unity_DOTS_Sampled_DetailNormalScale
#define _NormalScale            unity_DOTS_Sampled_NormalScale
#endif

TEXTURE2D(_BaseMap);
TEXTURE2D(_MaskMap);
TEXTURE2D(_NormalMap);
TEXTURE2D(_EmissionMap);
SAMPLER(sampler_BaseMap);

TEXTURE2D(_DetailMap);
TEXTURE2D(_DetailNormalMap);
SAMPLER(sampler_DetailMap);

/*

UNITY_INSTANCING_BUFFER_START(UnityPerMaterial)
	UNITY_DEFINE_INSTANCED_PROP(float4, _BaseMap_ST)
	UNITY_DEFINE_INSTANCED_PROP(float4, _DetailMap_ST)
	UNITY_DEFINE_INSTANCED_PROP(float4, _BaseColor)
	UNITY_DEFINE_INSTANCED_PROP(float4, _EmissionColor)
	UNITY_DEFINE_INSTANCED_PROP(float, _Cutoff)
	UNITY_DEFINE_INSTANCED_PROP(float, _ZWrite)
	UNITY_DEFINE_INSTANCED_PROP(float, _Metallic)
	UNITY_DEFINE_INSTANCED_PROP(float, _Occlusion)
	UNITY_DEFINE_INSTANCED_PROP(float, _Smoothness)
	UNITY_DEFINE_INSTANCED_PROP(float, _Fresnel)
	UNITY_DEFINE_INSTANCED_PROP(float, _DetailAlbedo)
	UNITY_DEFINE_INSTANCED_PROP(float, _DetailSmoothness)
	UNITY_DEFINE_INSTANCED_PROP(float, _DetailNormalScale)
	UNITY_DEFINE_INSTANCED_PROP(float, _NormalScale)
UNITY_INSTANCING_BUFFER_END(UnityPerMaterial)
*/

//#define INPUT_PROP(name) UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, name)

struct InputConfig
{
	Fragment fragment;
	float2 baseUV;
	float2 detailUV;
	bool useMask;
	bool useDetail;
};

InputConfig GetInputConfig(
	float4 positionSS,
	float2 baseUV,
	float2 detailUV = 0.0)
{
	InputConfig c;
	c.fragment = GetFragment(positionSS);
	c.baseUV = baseUV;
	c.detailUV = detailUV;
	c.useMask = false;
	c.useDetail = false;
	return c;
}

float2 TransformBaseUV(float2 baseUV)
{
	//float4 baseST = INPUT_PROP(_BaseMap_ST);
	float4 baseST = _BaseMap_ST;
	return baseUV * baseST.xy + baseST.zw;
}

float2 TransformDetailUV(float2 detailUV)
{
	//float4 detailST = INPUT_PROP(_DetailMap_ST);
	float4 detailST = _DetailMap_ST;
	return detailUV * detailST.xy + detailST.zw;
}

float4 GetMask(InputConfig c)
{
	if (c.useMask)
	{
		return SAMPLE_TEXTURE2D(_MaskMap, sampler_BaseMap, c.baseUV);
	}
	return 1.0;
}

float4 GetDetail(InputConfig c)
{
	if (c.useDetail)
	{
		float4 map = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, c.detailUV);
		return map * 2.0 - 1.0;
	}
	return 0.0;
}

float4 GetBase(InputConfig c)
{
	float4 map = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, c.baseUV);
	//float4 color = INPUT_PROP(_BaseColor);
	float4 color = _BaseColor;

	if (c.useDetail)
	{
		//float detail = GetDetail(c).r * INPUT_PROP(_DetailAlbedo);
		float detail = GetDetail(c).r * _DetailAlbedo;
		float mask = GetMask(c).b;
		map.rgb = lerp(
			sqrt(map.rgb), detail < 0.0 ? 0.0 : 1.0, abs(detail) * mask);
		map.rgb *= map.rgb;
	}
	
	return map * color;
}

float GetFinalAlpha(float alpha)
{
	//return INPUT_PROP(_ZWrite) ? 1.0 : alpha;
	return _ZWrite ? 1.0 : alpha;
}

float3 GetNormalTS(InputConfig c)
{
	float4 map = SAMPLE_TEXTURE2D(_NormalMap, sampler_BaseMap, c.baseUV);
	//float scale = INPUT_PROP(_NormalScale);
	float scale = _NormalScale;
	float3 normal = DecodeNormal(map, scale);

	if (c.useDetail)
	{
		map = SAMPLE_TEXTURE2D(_DetailNormalMap, sampler_DetailMap, c.detailUV);
		//scale = INPUT_PROP(_DetailNormalScale) * GetMask(c).b;
		scale = _DetailNormalScale * GetMask(c).b;
		float3 detail = DecodeNormal(map, scale);
		normal = BlendNormalRNM(normal, detail);
	}
	
	return normal;
}

float3 GetEmission(InputConfig c)
{
	float4 map = SAMPLE_TEXTURE2D(_EmissionMap, sampler_BaseMap, c.baseUV);
	//float4 color = INPUT_PROP(_EmissionColor);
	float4 color = _EmissionColor;
	return map.rgb * color.rgb;
}

float GetCutoff(InputConfig c)
{
	//return INPUT_PROP(_Cutoff);
	return _Cutoff;
}

float GetMetallic(InputConfig c)
{
	//float metallic = INPUT_PROP(_Metallic);
	float metallic = _Metallic;
	metallic *= GetMask(c).r;
	return metallic;
}

float GetOcclusion(InputConfig c)
{
	//float strength = INPUT_PROP(_Occlusion);
	float strength = _Occlusion;
	float occlusion = GetMask(c).g;
	occlusion = lerp(occlusion, 1.0, strength);
	return occlusion;
}

float GetSmoothness(InputConfig c)
{
	//float smoothness = INPUT_PROP(_Smoothness);
	float smoothness = _Smoothness;
	smoothness *= GetMask(c).a;

	if (c.useDetail)
	{
		//float detail = GetDetail(c).b * INPUT_PROP(_DetailSmoothness);
		float detail = GetDetail(c).b * _DetailSmoothness;
		float mask = GetMask(c).b;
		smoothness = lerp(
			smoothness, detail < 0.0 ? 0.0 : 1.0, abs(detail) * mask);
	}
	
	return smoothness;
}

float GetFresnel(InputConfig c)
{
	//return INPUT_PROP(_Fresnel);
	return _Fresnel;
}

#endif
