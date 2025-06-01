#ifndef CUSTOM_DOTS_INSTANCING_INCLUDED
#define CUSTOM_DOTS_INSTANCING_INCLUDED

// Taken from /Library/PackageCache/com.unity.render-pipelines.universal@2b33a11d06a4/ShaderLibrary/UniversalDOTSInstancing.hlsl

#ifdef UNITY_DOTS_INSTANCING_ENABLED

#undef unity_ObjectToWorld
#undef unity_WorldToObject
#undef unity_MatrixPreviousM
#undef unity_MatrixPreviousMI

// TODO: This might not work correctly in all cases, double check!
UNITY_DOTS_INSTANCING_START(BuiltinPropertyMetadata)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(float3x4, unity_ObjectToWorld)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(float3x4, unity_WorldToObject)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(float4,   unity_SpecCube0_HDR)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(float4,   unity_LightmapST)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(float4,   unity_LightmapIndex)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(float4,   unity_DynamicLightmapST)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(float3x4, unity_MatrixPreviousM)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(float3x4, unity_MatrixPreviousMI)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(SH,       unity_SHCoefficients)
    UNITY_DOTS_INSTANCED_PROP_OVERRIDE_SUPPORTED(uint2,    unity_EntityId)
UNITY_DOTS_INSTANCING_END(BuiltinPropertyMetadata)

#define unity_LODFade               LoadDOTSInstancedData_LODFade()
#define unity_SpecCube0_HDR         UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_CUSTOM_DEFAULT(float4, unity_SpecCube0_HDR, unity_DOTS_SpecCube0_HDR)
#define unity_LightmapST            UNITY_ACCESS_DOTS_INSTANCED_PROP(float4,   unity_LightmapST)
#define unity_LightmapIndex         UNITY_ACCESS_DOTS_INSTANCED_PROP(float4,   unity_LightmapIndex)
#define unity_DynamicLightmapST     UNITY_ACCESS_DOTS_INSTANCED_PROP(float4,   unity_DynamicLightmapST)
#define unity_SHAr                  LoadDOTSInstancedData_SHAr()
#define unity_SHAg                  LoadDOTSInstancedData_SHAg()
#define unity_SHAb                  LoadDOTSInstancedData_SHAb()
#define unity_SHBr                  LoadDOTSInstancedData_SHBr()
#define unity_SHBg                  LoadDOTSInstancedData_SHBg()
#define unity_SHBb                  LoadDOTSInstancedData_SHBb()
#define unity_SHC                   LoadDOTSInstancedData_SHC()
#define unity_ProbesOcclusion       LoadDOTSInstancedData_ProbesOcclusion()
#define unity_LightData             LoadDOTSInstancedData_LightData()
#define unity_WorldTransformParams  LoadDOTSInstancedData_WorldTransformParams()
#define unity_RenderingLayer        LoadDOTSInstancedData_RenderingLayer()
#define unity_MotionVectorsParams   LoadDOTSInstancedData_MotionVectorsParams() 

#define UNITY_SETUP_DOTS_SH_COEFFS  SetupDOTSSHCoeffs(UNITY_DOTS_INSTANCED_METADATA_NAME(SH, unity_SHCoefficients))
#define UNITY_SETUP_DOTS_RENDER_BOUNDS  SetupDOTSRendererBounds(UNITY_DOTS_MATRIX_M)


// For probe/shading data not directly instanced, provide safe fallbacks:
static const float4 unity_ProbeVolumeParams = float4(0,0,0,0);
static const float4x4 unity_ProbeVolumeWorldToObject = float4x4(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1);
static const float4 unity_ProbeVolumeSizeInv = float4(1,1,1,1);
static const float4 unity_ProbeVolumeMin = float4(0,0,0,0);


#endif

#endif // CUSTOM_DOTS_INSTANCING_INCLUDED