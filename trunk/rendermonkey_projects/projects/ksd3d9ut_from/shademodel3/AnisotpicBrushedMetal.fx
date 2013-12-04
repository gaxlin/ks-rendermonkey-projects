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
// AnisotpicBrushedMetal
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// pass0
//--------------------------------------------------------------//
string eff_AnisotpicBrushedMetal_pass0_Teapot : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

float4x4 mViewProj : ViewProjection;
float4x4 mViewInverse : ViewInverse;
float4x4 texture_space_matrix
<
   string UIName = "texture_space_matrix";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
> = float4x4( 1.00, 0.00, 0.00, 0.00, 0.00, -2.00, -4.00, 0.00, 0.00, -1.00, -2.00, 0.00, 0.00, 0.00, 0.00, 1.00 );
 

float4 light2Position
<
   string UIName = "light2Position";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -10.00, -10.00, -10.00, -10.00 );
   float4 UIMax = float4( 10.00, 10.00, 10.00, 10.00 );
   bool Normalize =  false;
> = float4( -500.00, 500.00, 1.00, 1.00 );
float4 light1Position
<
   string UIName = "light1Position";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -10.00, -10.00, -10.00, -10.00 );
   float4 UIMax = float4( 10.00, 10.00, 10.00, 10.00 );
   bool Normalize =  false;
> = float4( 300.00, 500.00, 1.00, 1.00 );
float4 vRingScale
<
   string UIName = "vRingScale";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -10.00, -10.00, -10.00, -10.00 );
   float4 UIMax = float4( 10.00, 10.00, 10.00, 10.00 );
   bool Normalize =  false;
> = float4( 0.50, 0.20, 0.75, 1.00 );
float4 vRingCenter
<
   string UIName = "vRingCenter";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -10.00, -10.00, -10.00, -10.00 );
   float4 UIMax = float4( 10.00, 10.00, 10.00, 10.00 );
   bool Normalize =  false;
> = float4( -1.50, -20.00, 26.00, 1.00 );
float fAmbient
<
   string UIName = "fAmbient";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 1.00;
> = float( 0.10 );

float4 ambient
<
   string UIName = "ambient";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.13, 0.16, 0.13, 1.00 );

float4x4 mWorld
<
   string UIName = "mWorld";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
> = float4x4( 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00 );
 

struct VS_OUTPUT
{
   float4 ProjPos  : POSITION;
   float4 Normal   : COLOR0;      // Has ambient in W
   float3 View     : TEXCOORD0;
   float3 DirAniso : COLOR1;
   float4 TexPos   : TEXCOORD1;   // Has light intensity in W
   float3 Light1   : TEXCOORD2;
   float3 Light2   : TEXCOORD3;
};

VS_OUTPUT eff_AnisotpicBrushedMetal_pass0_Vertex_Shader_main( float4 inPos: POSITION, float4 inNormal: NORMAL )
{
  VS_OUTPUT o = (VS_OUTPUT)0;

   // Texture space coordinates:
   float3 texPos      = ((float3)inPos) - vRingCenter;
   float3 texSpacePos = texPos * vRingScale + float3(0, -40, -40);

   texSpacePos = mul(texSpacePos, (float3x3)texture_space_matrix );

   o.TexPos.xyz = texSpacePos;

   // Ambient lighting: 
   o.TexPos.w = ambient.x * 5;

   // Compute direction of anisotropy
   float3 dirAniso = cross(inNormal, normalize(texPos));

   o.ProjPos  = mul( mViewProj, inPos );

   // Output the normal vector ( w component contains ambient factor ) 
   o.Normal   = float4( inNormal * .5 + (float3).5, fAmbient );

   // Propagate direction of anisotropy:
   o.DirAniso = dirAniso * 0.5 +(float3)0.5;

   // Compute camera position:
   float4 vCameraPosition = mul( mViewInverse, float4(0,0,0,1) );

   // Calculate view vector:
   o.View = normalize( vCameraPosition - mul( mWorld, inPos ) );
   
   // Compute light direction vectors: 
   float4 light1Position_2 = mul( mViewInverse, light1Position );
   float4 light2Position_2 = mul( mViewInverse, light2Position );

   o.Light1   = normalize(light1Position_2 - inPos );
   o.Light2   = normalize(light2Position_2 - inPos );

   return o;
} 







float4 ringAmbientColor
<
   string UIName = "ringAmbientColor";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.23, 0.25, 0.20, 1.00 );
float4 ringColor
<
   string UIName = "ringColor";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.93, 0.94, 1.00, 1.00 );
float4 lightColor
<
   string UIName = "lightColor";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 1.00, 0.94, 0.84, 1.00 );
texture ring_gradient_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\Anisotropic\\RingGradient.bmp";
>;
sampler ring_gradient = sampler_state
{
   Texture = (ring_gradient_Tex);
   ADDRESSU = MIRROR;
   ADDRESSV = MIRROR;
   MINFILTER = ANISOTROPIC;
   MIPFILTER = LINEAR;
   MIPMAPLODBIAS = 0.250000;
};
texture strand_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\Anisotropic\\AnisoStrand.tga";
>;
sampler strand = sampler_state
{
   Texture = (strand_Tex);
   ADDRESSU = CLAMP;
   ADDRESSV = CLAMP;
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
};
struct StrandPair
{
   float Diffuse;
   float Specular;
};

//----------------------------------------------------------------------------------------------//
// Pixel shader input struct                                                                    //
//----------------------------------------------------------------------------------------------//
struct PS_INPUT
{
   float4 ProjPos  : POSITION;    
   float4 Normal   : COLOR0;      // Normal vector, w component stores ambient contribution coefficient
   float3 View     : TEXCOORD0;   // View vector
   float3 DirAniso : COLOR1;      // Direction of anisotropy
   float4 TexPos   : TEXCOORD1;   // Lookup texture coordinate, w component stores light intensity coefficient
   float3 Light1   : TEXCOORD2;   // Direction vector for light 1
   float3 Light2   : TEXCOORD3;   // Direction vector for light 2
};

//----------------------------------------------------------------------------------------------//
StrandPair StrandLight( float3 normal, float3 light, float3 view, float3 dirAniso )
{
   StrandPair o;

   float  LdA        = dot( light, dirAniso );
   float  VdA        = dot( view,  dirAniso );
   float2 fnLookup   = tex2D( strand, float2( LdA, VdA ) * 0.5 + (float2)0.5 );
   float  spec       = fnLookup.y * fnLookup.y;
   float  diff       = fnLookup.x; 
   float  selfShadow = saturate( dot( normal, light ) );

   o.Diffuse  = diff * selfShadow;
   o.Specular = spec * selfShadow;
   return o;
}


//----------------------------------------------------------------------------------------------//
// Pixel shader                                                                                 //
//----------------------------------------------------------------------------------------------//
float4 eff_AnisotpicBrushedMetal_pass0_Pixel_Shader_main( PS_INPUT i ) : COLOR
{
   // Extract components from inputs //
   float3 dirAniso = i.DirAniso * 2 - (float3)1;
   float3 normal   = i.Normal * 2 - (float3)1;
   float3 view     = (float3) i.View;
   float3 light[2] = { (float3) i.Light1, (float3)i.Light2 };
   float  shadow   = i.TexPos.w;
   float  ambient  = i.Normal.w;

   // Strand Lighting //
   float3   color = 0;
   for (int l = 0; l < 2; l++)
   {
      StrandPair strand = StrandLight(normal, light[l], view, dirAniso);
      color += (strand.Diffuse + strand.Specular) * lightColor;
   }

   float3 ringNewColor = tex1D(ring_gradient, length(i.TexPos)) * ringColor + ringAmbientColor;

   color = (color*shadow + ambient) * ringNewColor;
   
   return float4( color, 1);

}







//--------------------------------------------------------------//
// Technique Section for eff
//--------------------------------------------------------------//
technique AnisotpicBrushedMetal
{
   pass pass0
   {
      VertexShader = compile vs_2_0 eff_AnisotpicBrushedMetal_pass0_Vertex_Shader_main();
      PixelShader = compile ps_2_0 eff_AnisotpicBrushedMetal_pass0_Pixel_Shader_main();
   }

}

