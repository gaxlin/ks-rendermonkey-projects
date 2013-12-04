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
// AnisotropicSatin
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// pass0
//--------------------------------------------------------------//
string eff_AnisotropicSatin_pass0_Teapot : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

 
 
float4x4 mViewProj : ViewProjection;
float4x4 mView : View;
float noiseRate
<
   string UIName = "noiseRate";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = 0.00;
   float UIMax = 0.10;
> = float( 0.02 );

struct VS_OUTPUT
{
   float4 Pos:      POSITION;
   float3 normal:   TEXCOORD0;
   float3 tangent:  TEXCOORD1;
   float3 binormal: TEXCOORD2;
   float3 viewVec:  TEXCOORD3;
   float3 pos:      TEXCOORD4;
};

VS_OUTPUT eff_AnisotropicSatin_pass0_Vertex_Shader_main(float4 Pos: POSITION, 
               float3 tangent: TANGENT, 
               float3 binormal: BINORMAL, 
               float3 normal: NORMAL)
 {
 
   VS_OUTPUT Out;

   Out.Pos = mul(mViewProj, Pos);
   // Transform our tangent-space into eye-space
   Out.normal   =  mul(mView, normal);
   Out.binormal =  mul(mView, binormal);
   Out.tangent  =  mul(mView, tangent);
   // The view-vector in eye-space is -eyePos
   Out.viewVec  = -mul(mView, Pos);
   // Texture coords for the noise
   Out.pos = Pos.xyz * noiseRate;

   return Out;
}




float noiseScale
<
   string UIName = "noiseScale";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = 0.00;
   float UIMax = 3.14;
> = float( 0.50 );
float4 color
<
   string UIName = "color";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 1.00, 0.30, 0.00, 1.00 );
float4 gloss
<
   string UIName = "gloss";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.77, 0.59, 0.40, 1.00 );
float4 lightDir
<
   string UIName = "lightDir";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -10.00, -10.00, -10.00, -10.00 );
   float4 UIMax = float4( 10.00, 10.00, 10.00, 10.00 );
   bool Normalize =  false;
> = float4( -0.41, 0.41, -0.82, 0.00 );

texture Noise_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\NoiseVolume.dds";
>;

sampler Noise = sampler_state
{
   Texture = (Noise_Tex);
   ADDRESSU = WRAP;
   ADDRESSV = WRAP;
   ADDRESSW = WRAP;
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
};

float4 eff_AnisotropicSatin_pass0_Pixel_Shader_main(float3 normal: TEXCOORD0, 
               float3 tangent: TEXCOORD1,
                float3 binormal: TEXCOORD2, 
                float3 viewVec: TEXCOORD3, 
                float3 pos: TEXCOORD4) : COLOR 
 {
   viewVec = normalize(viewVec);

   // Grab an angle to rotate the tangent around the normal
   // This is done to create a slightly bumpy feeling
   float angle = noiseScale * (tex3D(Noise, pos).r - 0.5);

   // Our angle is within the [-PI, PI] range and we need both
   // the sine and cosine. Perfect for the sincos function,
   // which will save us some hardware instructions over separate
   // sin and cos calls.
   float cosA, sinA;
   sincos(angle, sinA, cosA);

   // Rotate tangent around the normal
   float3 tang = sinA * tangent + cosA * binormal;

   // Do the anisotropic lighting
   float diffuse = saturate(dot(lightDir, normal));
   float cs = -dot(viewVec, tang);
   float sn = sqrt(1 - cs * cs);
   float cl = dot(lightDir, tang);
   float sl = sqrt(1 - cl * cl);
   float specular = pow(saturate(cs * cl + sn * sl), 32);

   // Output the results
   return diffuse * color + gloss * specular;
}



//--------------------------------------------------------------//
// Technique Section for eff
//--------------------------------------------------------------//
technique AnisotropicSatin
{
   pass pass0
   {
      VertexShader = compile vs_2_0 eff_AnisotropicSatin_pass0_Vertex_Shader_main();
      PixelShader = compile ps_2_0 eff_AnisotropicSatin_pass0_Pixel_Shader_main();
   }

}

