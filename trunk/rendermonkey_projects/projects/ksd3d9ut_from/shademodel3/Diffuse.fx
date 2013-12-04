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
// Diffuse
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// Pass0
//--------------------------------------------------------------//
string eff_Diffuse_Pass0_Model : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

float4x4 mWorldViewProj : WorldViewProjection;
float4x4 mWorld : World;
float4x4 mView : View;

float3 fvLightPosition
<
   string UIName = "fvLightPosition";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -100.00;
   float UIMax = 100.00;
> = float3( 0.00, 0.00, 100.00 );
 

 

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float2 Texcoord : TEXCOORD0;
   float3 Normal :   NORMAL0;
   
};

struct VS_OUTPUT 
{
   float4 Position :        POSITION0;
   float2 Texcoord :        TEXCOORD0;
  // float3 ViewDirection :   TEXCOORD1;
   float3 LightDirection :  TEXCOORD2;
   float3 Normal :          TEXCOORD3;
   
};

VS_OUTPUT eff_Diffuse_Pass0_Vertex_Shader_vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;

   Output.Position         = mul( Input.Position, mWorldViewProj );
   Output.Texcoord         = Input.Texcoord;
   
   float3 fvObjectPosition = mul( Input.Position, mWorld );
   
//   Output.ViewDirection    = fvEyePosition - fvObjectPosition;
   Output.LightDirection   = fvLightPosition - fvObjectPosition;
   Output.Normal           = mul( Input.Normal, mView );
      
   return( Output );
   
}



float4 fvAmbient
<
   string UIName = "fvAmbient";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.29, 0.00, 0.01, 1.00 );
 
float4 fvDiffuse
<
   string UIName = "fvDiffuse";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.00, 0.87, 0.89, 1.00 );
 
texture diffuse_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\Fieldstone.tga";
>;
sampler2D baseMap = sampler_state
{
   Texture = (diffuse_Tex);
   ADDRESSU = WRAP;
   ADDRESSV = WRAP;
   MINFILTER = LINEAR;
   MAGFILTER = LINEAR;
   MIPFILTER = LINEAR;
};

struct PS_INPUT 
{
   float2 Texcoord :        TEXCOORD0;
 //  float3 ViewDirection :   TEXCOORD1;
   float3 LightDirection:   TEXCOORD2;
   float3 Normal :          TEXCOORD3;
   
};

float4 eff_Diffuse_Pass0_Pixel_Shader_ps_main( PS_INPUT Input ) : COLOR0
{      
   float3 fvLightDirection = normalize( Input.LightDirection );
   float3 fvNormal         = normalize( Input.Normal );
   float  fNDotL           = dot( fvNormal, fvLightDirection ); 
   
   float3 fvReflection     = normalize( ( ( 2.0f * fvNormal ) * ( fNDotL ) ) - fvLightDirection ); 
  // float3 fvViewDirection  = normalize( Input.ViewDirection );
  // float  fRDotV           = max( 0.0f, dot( fvReflection, fvViewDirection ) );
   
   float4 fvBaseColor      = tex2D( baseMap, Input.Texcoord );
   
   float4 fvTotalAmbient   = fvAmbient * fvBaseColor; 
   float4 fvTotalDiffuse   = fvDiffuse * fNDotL * fvBaseColor; 
 
   
   return( saturate( fvTotalAmbient + fvTotalDiffuse   ) );
      
}



//--------------------------------------------------------------//
// Technique Section for eff
//--------------------------------------------------------------//
technique Diffuse
{
   pass Pass0
   {
      VertexShader = compile vs_2_0 eff_Diffuse_Pass0_Vertex_Shader_vs_main();
      PixelShader = compile ps_2_0 eff_Diffuse_Pass0_Pixel_Shader_ps_main();
   }

}

