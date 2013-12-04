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
// Effect Group 1
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// Textured Bump
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// Pass0
//--------------------------------------------------------------//
string Effect_Group_1_Textured_Bump_Pass0_Model : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";


float3 lightPosition
<
   string UIName = "lightPosition";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -100.00;
   float UIMax = 100.00;
> = float3( 100.00, 0.00, 100.00 );
float3 eyePosition
<
   string UIName = "eyePosition";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -100.00;
   float UIMax = 100.00;
> = float3( 0.00, 0.00, -100.00 );
 
 
float4x4 mView : View;
float4x4 mViewProj : ViewProjection;

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
   float3 ViewDirection :   TEXCOORD1;
   float3 LightDirection:   TEXCOORD2;
   
};

VS_OUTPUT Effect_Group_1_Textured_Bump_Pass0_Vertex_Shader_vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;

   Output.Position         = mul( Input.Position, mViewProj );
   Output.Texcoord         = Input.Texcoord;
   
   float3 fvObjectPosition = mul( Input.Position, mView );
   
   float3 fvViewDirection  = eyePosition - fvObjectPosition;
   float3 fvLightDirection = lightPosition - fvObjectPosition;
     
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



float4 Diffuse
<
   string UIName = "Diffuse";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.89, 0.89, 0.89, 1.00 );
float4 Ambient
<
   string UIName = "Ambient";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.29, 0.30, 0.31, 1.00 );
float4 Specular
<
   string UIName = "Specular";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.49, 0.49, 0.49, 1.00 );

texture specular_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\base.tga";
>;
sampler2D specMap = sampler_state
{
   Texture = (specular_Tex);
   MAGFILTER = LINEAR;
};
 
float fSpecularPower
<
   string UIName = "fSpecularPower";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 1.00;
   float UIMax = 100.00;
> = float( 1.01 );

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

float4 Effect_Group_1_Textured_Bump_Pass0_Pixel_Shader_ps_main( PS_INPUT Input ) : COLOR0
{      
   float3 fvLightDirection = normalize( Input.LightDirection );
   float3 fvNormal         = normalize( ( tex2D( bumpMap, Input.Texcoord ).xyz * 2.0f ) - 1.0f );
   float  fNDotL           = dot( fvNormal, fvLightDirection ); 
   
   float3 fvReflection     = normalize( ( ( 2.0f * fvNormal ) * ( fNDotL ) ) - fvLightDirection ); 
   float3 fvViewDirection  = normalize( Input.ViewDirection );
   float  fRDotV           = max( 0.0f, dot( fvReflection, fvViewDirection ) );
   
   float4 fvBaseColor      = tex2D( baseMap, Input.Texcoord );
   
   float4 fvTotalAmbient   = Ambient * fvBaseColor; 
   float4 fvTotalDiffuse   = Diffuse * fNDotL * fvBaseColor; 
   float4 fvTotalSpecular  = Specular * pow( fRDotV, fSpecularPower );
   
     fvTotalSpecular  *= tex2D( specMap, Input.Texcoord );
   
   
   return( saturate( fvTotalAmbient + fvTotalDiffuse + fvTotalSpecular ) );
      
}




//--------------------------------------------------------------//
// Technique Section for Effect Group 1
//--------------------------------------------------------------//
technique Textured_Bump
{
   pass Pass0
   {
      VertexShader = compile vs_2_0 Effect_Group_1_Textured_Bump_Pass0_Vertex_Shader_vs_main();
      PixelShader = compile ps_2_0 Effect_Group_1_Textured_Bump_Pass0_Pixel_Shader_ps_main();
   }

}

