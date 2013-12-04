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
// ObjectColored
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// Pass 0
//--------------------------------------------------------------//
string Effect_Group_1_ObjectColored_Pass_0_Model : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

float4x4 mWorldViewProj : WorldViewProjection;
 
struct VS_INPUT 
{
   float4 Position : POSITION0;
   
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;
   
};

VS_OUTPUT Effect_Group_1_ObjectColored_Pass_0_Vertex_Shader_vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;

   Output.Position = mul( Input.Position, mWorldViewProj );
   
   return( Output );
   
}




float4 ObjectColor
<
   string UIName = "ObjectColor";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 1.00, 0.00, 0.02, 1.00 );

float4 Effect_Group_1_ObjectColored_Pass_0_Pixel_Shader_ps_main() : COLOR0
{   
   return( ObjectColor );  
}




//--------------------------------------------------------------//
// Technique Section for Effect Group 1
//--------------------------------------------------------------//
technique ObjectColored
{
   pass Pass_0
   {
      VertexShader = compile vs_2_0 Effect_Group_1_ObjectColored_Pass_0_Vertex_Shader_vs_main();
      PixelShader = compile ps_2_0 Effect_Group_1_ObjectColored_Pass_0_Pixel_Shader_ps_main();
   }

}

