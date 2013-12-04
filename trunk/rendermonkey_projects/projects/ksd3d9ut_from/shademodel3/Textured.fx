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
// MaterialTextured
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// Pass 0
//--------------------------------------------------------------//
string Effect_Group_1_MaterialTextured_Pass_0_Model : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

float4x4 mWorldViewProj : WorldViewProjection;
 

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float2 Texcoord : TEXCOORD0;
   
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;
   float2 Texcoord : TEXCOORD0;
   
};

VS_OUTPUT Effect_Group_1_MaterialTextured_Pass_0_Vertex_Shader_vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;

   Output.Position = mul( Input.Position, mWorldViewProj );
   Output.Texcoord = Input.Texcoord;

   return( Output );
   
}




float4 color
<
   string UIName = "color";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.97, 0.95, 1.00, 1.00 );
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
   float2 Texcoord : TEXCOORD0;
   
};

float4 Effect_Group_1_MaterialTextured_Pass_0_Pixel_Shader_ps_main( PS_INPUT Input ) : COLOR0
{
   return color * tex2D( baseMap, Input.Texcoord );
   
}




//--------------------------------------------------------------//
// Technique Section for Effect Group 1
//--------------------------------------------------------------//
technique MaterialTextured
{
   pass Pass_0
   {
      VertexShader = compile vs_2_0 Effect_Group_1_MaterialTextured_Pass_0_Vertex_Shader_vs_main();
      PixelShader = compile ps_2_0 Effect_Group_1_MaterialTextured_Pass_0_Pixel_Shader_ps_main();
   }

}

