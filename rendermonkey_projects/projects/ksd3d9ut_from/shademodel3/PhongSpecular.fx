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
// PhongSpecularPointLight
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// Pass 0
//--------------------------------------------------------------//
string Effect_Group_1_PhongSpecularPointLight_Pass_0_Model : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Sphere.x";

float4x4 mWorld : World;
float4x4 mWorldViewProj : WorldViewProjection;
 
float4 eyePosition : ViewPosition;
float4 lightPosition
<
   string UIName = "lightPosition";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -10.00, -10.00, -10.00, -10.00 );
   float4 UIMax = float4( 10.00, 10.00, 10.00, 10.00 );
   bool Normalize =  false;
> = float4( 349.11, 17.00, 260.72, 1.00 );

struct A2V
{ 
    float4 Pos : POSITION;
    float3 Normal : NORMAL;
    float2 Tex0 : TEXCOORD0;
};

struct V2P
{
    float4 Pos : POSITION;
    float2 TexCoord0 : TEXCOORD2;
    float4 WorldPos : TEXCOORD0;
    float3 ViewNormal : TEXCOORD1;
    float3 LightDir : TEXCOORD4;
    float3 ViewDir : TEXCOORD5;
};

void Effect_Group_1_PhongSpecularPointLight_Pass_0_Vertex_Shader_VS(in A2V IN, out V2P OUT)
{
    OUT.Pos = mul( IN.Pos, mWorldViewProj );
    OUT.WorldPos = mul( IN.Pos, mWorld );
    OUT.LightDir = lightPosition - OUT.WorldPos;
    OUT.ViewDir = eyePosition - OUT.WorldPos;
    OUT.ViewNormal = normalize( mul( IN.Normal, (float3x3)mWorld) );
    OUT.TexCoord0 = IN.Tex0;
}
 float fSpecularPower
<
   string UIName = "fSpecularPower";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 0.00;
> = float( 2.99 );
float4 Specular
<
   string UIName = "Specular";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.80, 0.80, 0.80, 1.00 );
float4 Ambient
<
   string UIName = "Ambient";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.41, 0.41, 0.40, 1.00 );
float4 Diffuse
<
   string UIName = "Diffuse";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.84, 0.83, 0.82, 1.00 );
float LightFalloff
<
   string UIName = "LightFalloff";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 0.00;
> = float( 436.79 ); 
 
texture diffuse_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\Tiles.dds";
>;
sampler2D textureSampler = sampler_state
{
   Texture = (diffuse_Tex);
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
};

struct Effect_Group_1_PhongSpecularPointLight_Pass_0_Pixel_Shader_V2P
{
    float4 Pos : POSITION;
    float2 TexCoord0 : TEXCOORD2;
    float4 WorldPos : TEXCOORD0;
    float3 ViewNormal : TEXCOORD1;
    
    float3 LightDir : TEXCOORD4;
    float3 ViewDir : TEXCOORD5;
};

float4 Effect_Group_1_PhongSpecularPointLight_Pass_0_Pixel_Shader_PS( in Effect_Group_1_PhongSpecularPointLight_Pass_0_Pixel_Shader_V2P IN) : COLOR0
{
    float LenSq = dot( IN.LightDir, IN.LightDir );
    IN.LightDir = normalize( IN.LightDir );

    float Attn = min(( LightFalloff * LightFalloff ) / LenSq, 1.0f);
    
    IN.ViewDir = normalize( IN.ViewDir );
        
    float4 I = saturate( dot( normalize( IN.ViewNormal ), IN.LightDir ) ) * Attn;              
        
    float3 Reflect = normalize(2 * I * IN.ViewNormal - IN.LightDir);
    float nrdot = dot(Reflect, IN.ViewDir);
 
    // ?>?KB:0 A1@>A0 >1@0B=>3> A?5:C;O@0
    float nval =  saturate( dot(   IN.LightDir,  IN.ViewDir ) *  2.0f  )  ;
        
float4 fvTotalSpecular = 
   Specular *  pow(  0.98f  * saturate( nrdot ),  fSpecularPower ) * nval ;  

    float4 TexColor = tex2D( textureSampler, IN.TexCoord0 );
    
    float4 fvTotalAmbient   = ( Ambient * TexColor  );
    float4 fvTotalDiffuse   = 2 *  saturate (Diffuse * (I * TexColor) ); 
 
  return ( ( fvTotalAmbient + fvTotalDiffuse + fvTotalSpecular ) );   
}
//--------------------------------------------------------------//
// Technique Section for Effect Group 1
//--------------------------------------------------------------//
technique PhongSpecularPointLight
{
   pass Pass_0
   {
      VertexShader = compile vs_2_0 Effect_Group_1_PhongSpecularPointLight_Pass_0_Vertex_Shader_VS();
      PixelShader = compile ps_2_0 Effect_Group_1_PhongSpecularPointLight_Pass_0_Pixel_Shader_PS();
   }

}

