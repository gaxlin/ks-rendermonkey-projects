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
// DiffuseMulCubemapReflection
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// pass0
//--------------------------------------------------------------//
string eff_DiffuseMulCubemapReflection_pass0_Teapot : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

float4 eyePosition : ViewPosition ;
float4x4 mViewProj : ViewProjection ;
float4x4 mWorld
<
   string UIName = "mWorld";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
> = float4x4( 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00 );
float4x4 matWorld;
 
struct VS_OUTPUT {
   float4 Pos:     POSITION;
   float3 normal:  TEXCOORD0;
   float3 viewVec: TEXCOORD1;
   float2 tc :TEXCOORD2;
};

VS_OUTPUT eff_DiffuseMulCubemapReflection_pass0_Vertex_Shader_main(float4 Pos: POSITION, float3 normal: NORMAL, float2 txtrCoor :TEXCOORD){
   VS_OUTPUT Out;

float4x4 mtr = mul (  mViewProj , mWorld );
   Out.Pos = mul(  mtr, Pos  );
   Out.normal = normal;
   Out.viewVec =     -eyePosition + Pos   ;
   Out.tc = txtrCoor;
   return Out;
}








float brightness
<
   string UIName = "brightness";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 0.00;
> = float( 3.15 );
 
float4 vReflApsInf
<
   string UIName = "vReflApsInf";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -10.00, -10.00, -10.00, -10.00 );
   float4 UIMax = float4( 10.00, 10.00, 10.00, 10.00 );
   bool Normalize =  false;
> = float4( 1.00, 1.00, 1.00, 1.00 );
 
texture diffuse_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\Tiles.dds";
>;
sampler2D Texture1 = sampler_state
{
   Texture = (diffuse_Tex);
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
   MAGFILTER = LINEAR;
};
 
texture cubeMap_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\Snow.dds";
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

float4 eff_DiffuseMulCubemapReflection_pass0_Pixel_Shader_main(
         float3 normal  : TEXCOORD0, 
         float3 viewVec : TEXCOORD1,
         float2 txtrCoor :TEXCOORD2   ) : COLOR 
{
   normal = normalize(normal);

   float v = dot(normalize(viewVec), normal) * 2.0;
 
   float3 reflVec = reflect(-viewVec, normal);
   
    reflVec[0] *= vReflApsInf[0];
    reflVec[1] *= vReflApsInf[1];    
    reflVec[2] *= vReflApsInf[2];   
     
     float3 refl = (brightness * texCUBE(Environment, reflVec)) 
              * (tex2D( Texture1 , txtrCoor)  ) ;
 
     float3 color = lerp(refl, 0, 0);
 
    
  return float4(color, 1 - v );
}

//--------------------------------------------------------------//
// Technique Section for eff
//--------------------------------------------------------------//
technique DiffuseMulCubemapReflection
{
   pass pass0
   {
      CULLMODE = NONE;
      ALPHABLENDENABLE = FALSE;
      ZWRITEENABLE = TRUE;

      VertexShader = compile vs_2_0 eff_DiffuseMulCubemapReflection_pass0_Vertex_Shader_main();
      PixelShader = compile ps_2_0 eff_DiffuseMulCubemapReflection_pass0_Pixel_Shader_main();
   }

}

