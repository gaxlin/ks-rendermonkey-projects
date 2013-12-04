//**************************************************************//
//  Effect File exported by RenderMonkey 1.6
//
//  - Although many improvements were made to RenderMonkey FX  
//    file export, there are still situations that may cause   
//    compilation problems once the file is exported, such as  
//    occasional naming conflicts for methods, since FX format 
//    does not support any notions of name spaces. You need to 
//    try to create workspaces in such a way as to minimize    
//    potential naming conflicts on export.                    
//    
//  - Note that to minimize resulting name collisions in the FX 
//    file, RenderMonkey will mangle names for passes, shaders  
//    and function names as necessary to reduce name conflicts. 
//**************************************************************//

//--------------------------------------------------------------//
// eff
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// CubeMapReflection
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// pass0
//--------------------------------------------------------------//
string eff_CubeMapReflection_pass0_Teapot : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

float4 eyePosition : ViewPosition ;
float4x4 mWorld
<
   string UIName = "mWorld";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
> = float4x4( 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00 );
float4x4 mViewProj : ViewProjectionTranspose ;
 
struct VS_OUTPUT {
   float4 Pos:     POSITION;
   float3 normal:  TEXCOORD0;
   float3 viewVec: TEXCOORD1;
};

VS_OUTPUT eff_CubeMapReflection_pass0_Vertex_Shader_main(float4 Pos: POSITION, 
float3 normal: NORMAL , float2 txcoord :TEXCOORD0 )
{
   VS_OUTPUT Out;

   float4x4 mtr = mul ( mWorld , mViewProj  );
   Out.Pos = mul( Pos , mtr );
   Out.normal = normal;
   Out.viewVec = eyePosition - Pos;
   return Out;
}
float brightness
<
   string UIName = "brightness";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 0.00;
> = float( 1.00 );
float4 vReflec
<
   string UIName = "vReflec";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -10.00, -10.00, -10.00, -10.00 );
   float4 UIMax = float4( 10.00, 10.00, 10.00, 10.00 );
   bool Normalize =  false;
> = float4( 1.00, 1.00, 1.00, 1.00 );
texture cubeMap_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\grace_cube.dds";
>;
sampler Environment = sampler_state
{
   Texture = (cubeMap_Tex);
   ADDRESSU = CLAMP;
   ADDRESSV = CLAMP;
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
};
float4 eff_CubeMapReflection_pass0_Pixel_Shader_main(
         float3 normal  : TEXCOORD0, 
         float3 viewVec : TEXCOORD1   ) : COLOR 
{
   normal = normalize(normal);
   float v = dot(normalize(viewVec), normal) * 2.0;
   float3 reflVec = reflect(-viewVec, normal);
    reflVec[0] *= -vReflec[0];
    reflVec[1] *= -vReflec[1];    
    reflVec[2] *= -vReflec[2];    
     
   float3 refl = texCUBE(Environment, reflVec);
   float3 color = lerp(refl, 0, 0);
          color *= brightness;
    
  return float4(color, 1 - v );
}







//--------------------------------------------------------------//
// Technique Section for eff
//--------------------------------------------------------------//
technique CubeMapReflection
{
   pass pass0
   {
      CULLMODE = NONE;
      ALPHABLENDENABLE = FALSE;
      ZWRITEENABLE = TRUE;

      VertexShader = compile vs_2_0 eff_CubeMapReflection_pass0_Vertex_Shader_main();
      PixelShader = compile ps_2_0 eff_CubeMapReflection_pass0_Pixel_Shader_main();
   }

}

