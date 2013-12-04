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
// BumpSpecular
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// Pass_0
//--------------------------------------------------------------//
string eff_BumpSpecular_Pass_0_Model : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

float3 eyePosition
<
   string UIName = "eyePosition";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -100.00;
   float UIMax = 100.00;
> = float3( 0.00, 0.00, -100.00 );
float4x4 mViewProj : ViewProjection;
float4x4 mView : View;
float4x4 mWorld
<
   string UIName = "mWorld";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
> = float4x4( 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00 );
float3 g_LightPosition
<
   string UIName = "g_LightPosition";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -100.00;
   float UIMax = 100.00;
> = float3( 0.00, 0.00, 1000.00 );
 
struct VS_INPUT 
{
   float4 Position : POSITION0;
   float2 Texcoord : TEXCOORD0;
   float3 Normal :   NORMAL0;
   float3 Binormal : BINORMAL0;
   float3 Tangent :  TANGENT0;
   
};

struct VS_OUTPUT 
{
   float4 Position :        POSITION0;
   float2 Texcoord :        TEXCOORD0;
   float3 ViewDirection  :   TEXCOORD1;
   float3 LightDirection :   TEXCOORD2;
   
};

VS_OUTPUT eff_BumpSpecular_Pass_0_Vertex_Shader_vs_main( VS_INPUT Input ) {
   VS_OUTPUT Output;

  float4x4 mWVP = mul( mWorld, mViewProj );  
  Output.Position   = mul( Input.Position,  mWVP );
  Output.Texcoord   = Input.Texcoord;
   
  float3 fvObjectPosition = mul( Input.Position, mView ); // need mWorld
   
  float3 fvViewDirection  = eyePosition - fvObjectPosition;
   float3 fvLightDirection = normalize(g_LightPosition - fvObjectPosition);
      fvLightDirection =mul( fvLightDirection, mView );
     
   float3 fvNormal         = mul( Input.Normal, mView );
   float3 fvBinormal       = mul( Input.Binormal, mView );
   float3 fvTangent        = mul( Input.Tangent, mView );
      
   Output.ViewDirection.x  = dot( fvTangent, fvViewDirection );
   Output.ViewDirection.y  = dot( fvBinormal, fvViewDirection );
   Output.ViewDirection.z  = dot( fvNormal, fvViewDirection );
   
   Output.LightDirection.x  = dot( fvTangent, fvLightDirection );
   Output.LightDirection.y  = dot( fvBinormal, fvLightDirection );
   Output.LightDirection.z  = dot( fvNormal, fvLightDirection );
   
   return( Output );
   
}



float var3
<
   string UIName = "var3";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 0.00;
> = float( 1.00 );
float var2
<
   string UIName = "var2";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 0.00;
> = float( 2.00 );
float var1
<
   string UIName = "var1";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 0.00;
> = float( 1.85 );
float4 fvAmbient
<
   string UIName = "fvAmbient";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.37, 0.37, 0.37, 1.00 );
float4 fvSpecular
<
   string UIName = "fvSpecular";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.97, 0.97, 1.00, 1.00 );
float4 fvDiffuse
<
   string UIName = "fvDiffuse";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.89, 0.89, 0.89, 1.00 );
float fSpecularPower
<
   string UIName = "fSpecularPower";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 1.00;
   float UIMax = 100.00;
> = float( 7.93 );

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
texture normalMap_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\FieldstoneBumpDOT3.tga";
>;
sampler2D bumpMap = sampler_state
{
   Texture = (normalMap_Tex);
   ADDRESSU = WRAP;
   ADDRESSV = WRAP;
   MINFILTER = LINEAR;
   MAGFILTER = LINEAR;
   MIPFILTER = LINEAR;
};

struct PS_INPUT 
{
   float2 Texcoord :        TEXCOORD0;
   float3 ViewDirection :   TEXCOORD1;
   float3 LightDirection:   TEXCOORD2;
   
};

float4 eff_BumpSpecular_Pass_0_Pixel_Shader_ps_main( PS_INPUT Input ) : COLOR0
{      
   float3 fvLightDirection = normalize( Input.LightDirection );
   float3 fvNormal         = normalize( ( tex2D( bumpMap, Input.Texcoord ).xyz * var2 ) - var3 );// 2.0  - 1.0
   float  fNDotL           = dot( fvNormal, fvLightDirection ); 
   
   float3 fvReflection     = normalize( ( ( var1 * fvNormal ) * ( fNDotL ) ) - fvLightDirection );//2.0 
   float3 fvViewDirection  = normalize( Input.ViewDirection );
   float  fRDotV           = max( 0.0f, dot( fvReflection, fvViewDirection ) );  
   
   float4 fvBaseColor      = tex2D( baseMap, Input.Texcoord );
   
   float4 fvTotalAmbient   = fvAmbient * fvBaseColor; 
   float4 fvTotalDiffuse   = fvDiffuse * fNDotL * fvBaseColor; 
   float4 fvTotalSpecular  = fvSpecular * pow( fRDotV, fSpecularPower );
   
   return( saturate( fvTotalAmbient + fvTotalDiffuse + fvTotalSpecular ) );
      
}




//--------------------------------------------------------------//
// Technique Section for eff
//--------------------------------------------------------------//
technique BumpSpecular
{
   pass Pass_0
   {
      VertexShader = compile vs_2_0 eff_BumpSpecular_Pass_0_Vertex_Shader_vs_main();
      PixelShader = compile ps_2_0 eff_BumpSpecular_Pass_0_Pixel_Shader_ps_main();
   }

}

