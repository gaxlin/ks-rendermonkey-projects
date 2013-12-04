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
// BumpReflectiveSpecular
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// pass0
//--------------------------------------------------------------//
string eff_BumpReflectiveSpecular_pass0_Teapot : ModelData = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Teapot.3ds";

 
float4 light_position
<
   string UIName = "light_position";
   string UIWidget = "Direction";
   bool UIVisible =  true;
   float4 UIMin = float4( -500.00, -500.00, -500.00, -500.00 );
   float4 UIMax = float4( 500.00, 500.00, 500.00, 500.00 );
   bool Normalize =  false;
> = float4( -10.00, 40.00, 100.00, 1.00 );
float4  eyePosition
<
   string UIName = "eyePosition";
   string UIWidget = "Direction";
   bool UIVisible =  false;
   float4 UIMin = float4( -500.00, -500.00, -500.00, -500.00 );
   float4 UIMax = float4( 500.00, 500.00, 500.00, 500.00 );
   bool Normalize =  false;
> = float4( 19.73, -128.58, -74.07, 1.00 );


float4x4 mViewProj : ViewProjection;
float4x4 mView;
float4x4 mViewInverse : ViewInverse;


struct VS_INPUT_STRUCT
{
   float4 position:     POSITION;
   float3 normal:       NORMAL;
   float2 texcoord0:    TEXCOORD0;
   float3 binormal:     BINORMAL0;
   float3 tangent:      TANGENT0;
};

struct VS_OUTPUT_STRUCT
{
   float4 position:     POSITION;
   float2 bump_map:     TEXCOORD0;
   float3 light_vector: TEXCOORD1;
   float3 half_angle:   TEXCOORD2;
   float3 basis1:       TEXCOORD3;
   float3 basis2:       TEXCOORD4;
   float3 basis3:       TEXCOORD5;
};

//**---------------------------------------------------------
//** Function:    eff_BumpReflectiveSpecular_pass0_Vertex_Shader_main
//** Description: Declare the eff_BumpReflectiveSpecular_pass0_Vertex_Shader_main entry point for the shader
//** Input:       VS_INPUT_STRUCT, derived from the stream
//**              mapping parameters defined in the workspace
//** Returns:     VS_OUTPUT_STRUCT
//**---------------------------------------------------------
VS_OUTPUT_STRUCT eff_BumpReflectiveSpecular_pass0_Vertex_Shader_main( VS_INPUT_STRUCT vsInStruct )
{
   VS_OUTPUT_STRUCT vsOutStruct; //** Declare the output struct

   vsOutStruct.position = mul(   mViewProj, vsInStruct.position );
   float3 position =  mul( mView, vsInStruct.position );

   //**----------------------------------------------
   //** Pass the bump and base texture coords through
   //**----------------------------------------------
   vsOutStruct.bump_map = vsInStruct.texcoord0;

   //**--------------------------------------------
   //** Calculate the light vector in object space,
   //** and then transform it into texture space.
   //**--------------------------------------------
   float3 temp_light_position = mul( mViewInverse, light_position );
   float3 temp_light_vector = temp_light_position - vsInStruct.position; 
   vsOutStruct.light_vector.x = dot( temp_light_vector, vsInStruct.tangent );
   vsOutStruct.light_vector.y = dot( temp_light_vector, vsInStruct.binormal );
   vsOutStruct.light_vector.z = dot( temp_light_vector, vsInStruct.normal );

   //**-------------------------------------------
   //** Calculate the view vector in object space,
   //** and then transform it into texture space.
   //**-------------------------------------------
   float3 temp_eye_position =  mul( mViewInverse, eyePosition );
   float3 temp_view_vector = temp_eye_position - vsInStruct.position;
   float3 temp_view_vector2;
   temp_view_vector2.x = dot( temp_view_vector, vsInStruct.tangent );
   temp_view_vector2.y = dot( temp_view_vector, vsInStruct.binormal );
   temp_view_vector2.z = dot( temp_view_vector, vsInStruct.normal );

   //**-------------------------
   //** Calculate the half angle
   //**-------------------------
   vsOutStruct.half_angle = vsOutStruct.light_vector + temp_view_vector2;

   //**-----------------------------------------
   //** Construct the transpose of the tangent
   //** space basis vectors, so we can transform
   //** the reflection vector from texture space
   //** into view space
   //**-----------------------------------------
   vsOutStruct.basis1.x = vsInStruct.tangent.x;
   vsOutStruct.basis1.y = vsInStruct.binormal.x;
   vsOutStruct.basis1.z = vsInStruct.normal.x;
   vsOutStruct.basis2.x = vsInStruct.tangent.y;
   vsOutStruct.basis2.y = vsInStruct.binormal.y;
   vsOutStruct.basis2.z = vsInStruct.normal.y;
   vsOutStruct.basis3.x = vsInStruct.tangent.z;
   vsOutStruct.basis3.y = vsInStruct.binormal.z;
   vsOutStruct.basis3.z = vsInStruct.normal.z;

   return vsOutStruct; //** Return the resulting output struct
}











 
 

float Ka
<
   string UIName = "Ka";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -1.00;
   float UIMax = 1.00;
> = float( 0.30 );
float Kd
<
   string UIName = "Kd";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -1.00;
   float UIMax = 1.00;
> = float( 1.00 );
float Ks
<
   string UIName = "Ks";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -1.00;
   float UIMax = 1.00;
> = float( 2.64 );
float specular_power
<
   string UIName = "specular_power";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 1.00;
   float UIMax = 200.00;
> = float( 64.00 );
float bumpiness
<
   string UIName = "bumpiness";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 0.00;
   float UIMax = 1.00;
> = float( 1.00 );
float reflection_clarity
<
   string UIName = "reflection_clarity";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -3.00;
   float UIMax = 3.00;
> = float( 3.51 );
float reflectance
<
   string UIName = "reflectance";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 0.00;
   float UIMax = 1.00;
> = float( 1.00 );

float4 Ambient
<
   string UIName = "Ambient";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.94, 0.90, 0.92, 1.00 );
float4 Diffuse
<
   string UIName = "Diffuse";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.84, 0.86, 0.89, 1.00 );
float4 Specular
<
   string UIName = "Specular";
   string UIWidget = "Color";
   bool UIVisible =  true;
> = float4( 0.00, 1.00, 0.89, 1.00 );

float4x4 eff_BumpReflectiveSpecular_pass0_Pixel_Shader_mView : View;

texture diffuse_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\Fieldstone.tga";
>;
sampler base_map = sampler_state
{
   Texture = (diffuse_Tex);
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
};
texture normalMap_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\FieldstoneBumpDOT3.tga";
>;
sampler bump_map = sampler_state
{
   Texture = (normalMap_Tex);
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
};
texture cubeMap_Tex
<
   string ResourceName = "C:\\Program Files\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Textures\\tower_cube.dds";
>;
sampler environment_map = sampler_state
{
   Texture = (cubeMap_Tex);
};

struct PS_INPUT_STRUCT
{
   float2 bump_map:     TEXCOORD0;
   float3 light_vector: TEXCOORD1;
   float3 half_angle:   TEXCOORD2;
   float3 basis1:       TEXCOORD3;
   float3 basis2:       TEXCOORD4;
   float3 basis3:       TEXCOORD5;
};

struct PS_OUTPUT_STRUCT
{
   float4 color0:       COLOR0;
};

//**---------------------------------------------------------
//** Function:    eff_BumpReflectiveSpecular_pass0_Pixel_Shader_main
//** Description: Declare the eff_BumpReflectiveSpecular_pass0_Pixel_Shader_main entry point for the shader
//** Input:       PS_INPUT_STRUCT, derived from the output of
//**              the associated vertex shader
//** Returns:     PS_OUTPUT_STRUCT
//**---------------------------------------------------------
PS_OUTPUT_STRUCT eff_BumpReflectiveSpecular_pass0_Pixel_Shader_main( PS_INPUT_STRUCT psInStruct )
{
   PS_OUTPUT_STRUCT psOutStruct;

   //**----------------------------------------
   //** Get the base and bump map texture coord
   //**----------------------------------------
   float4 bump_coord = { psInStruct.bump_map, 0.0f, reflection_clarity };

   //**------------------------------------------------------
   //** Retreive the base color and bump components from the
   //** respective textures, based on the passed bump coords.
   //**------------------------------------------------------
   float3 base = tex2D( base_map, bump_coord );
   float3 bump = tex2D( bump_map, bump_coord );

   //**--------------------------------------------------
   //** Includes MIP bias to help clairify the reflection
   //**--------------------------------------------------
   float3 reflection_bump = tex2Dbias( bump_map, bump_coord );

   //**----------------------------------------------------
   //** Normalize the passed vectors from the vertex shader
   //**----------------------------------------------------
   float3 normalized_light_vector = normalize( psInStruct.light_vector );
   float3 normalized_half_angle = normalize( psInStruct.half_angle );
   
   //**--------------------------------------------------------
   //** "Smooth out" the bumps based on the bumpiness parameter.
   //** This is simply a linear interpolation between a "flat"
   //** normal and a "bumped" normal.  Note that this "flat"
   //** normal is based on the texture space coordinate basis.
   //**--------------------------------------------------------
   float3 smooth;
   smooth.r = 0.5f;
   smooth.g = 0.5f;
   smooth.b = 1.0f;
   bump = lerp( smooth, bump, bumpiness );
   bump = normalize( ( bump * 2.0f ) - 1.0f );
   reflection_bump = lerp( smooth, reflection_bump, bumpiness );
   reflection_bump = normalize( ( reflection_bump * 2.0f ) - 1.0f );

   //**---------------------------------------------
   //** Translate the reflection normal from texture 
   //** space into view space, so we can case the 
   //** reflection vector into an environment map.
   //**---------------------------------------------
   float3 reflection = reflection_bump;
   reflection.x = dot( reflection_bump, psInStruct.basis1 );
   reflection.y = dot( reflection_bump, psInStruct.basis2 );
   reflection.z = dot( reflection_bump, psInStruct.basis3 );
   float3 reflection_vector = mul( eff_BumpReflectiveSpecular_pass0_Pixel_Shader_mView, reflection );
   reflection_vector = normalize( reflection_vector );

   //**------------------------------------------
   //** Calculate the resulting reflection color.
   //**------------------------------------------
   float3 reflection_color = texCUBE( environment_map, reflection_vector );

   //**----------------------------------------------------------
   //** The following modifiers are used to enhance the effect of
   //** the basic reflection idea.  Normally, specular / gloss
   //** maps will take the place of these modifiers.
   //**----------------------------------------------------------
   float3 result_color = lerp( base, reflection_color, base * reflectance );
   float3 modified_specular_color = Specular * base;
   float3 modified_specular_coefficient = Ks * base;

   //**---------------------------------------------------------
   //** These dot products are used for the lighting model
   //** equations.  The surface normal dotted with the light
   //** vector is denoted by n_dot_l.  The normal vector
   //** dotted with the half angle vector is denoted by n_dot_h.
   //**---------------------------------------------------------
   float3 n_dot_l = dot( bump, normalized_light_vector );
   float3 n_dot_h = dot( bump, normalized_half_angle );

   //**--------------------------------------
   //** Calculate the resulting base color,
   //** based on our lighting model.
   //** Ambient + Diffuse + Specular
   //**--------------------------------------
   psOutStruct.color0.rgb = 
      ( result_color * Ambient * Ka ) +
      ( result_color * Diffuse * Kd * max( 0, n_dot_l ) ) +
      ( modified_specular_color * modified_specular_coefficient * pow( max( 0, n_dot_h ), specular_power ) );

   //**------------------------------------
   //** Interpolate the resulting color
   //** based on the reflectance parameter.
   //**------------------------------------
   psOutStruct.color0.a = 1.0f; //** Set the alpha component manually

   return psOutStruct; //** Return the resulting output struct
}








//--------------------------------------------------------------//
// Technique Section for eff
//--------------------------------------------------------------//
technique BumpReflectiveSpecular
{
   pass pass0
   {
      VertexShader = compile vs_2_0 eff_BumpReflectiveSpecular_pass0_Vertex_Shader_main();
      PixelShader = compile ps_2_0 eff_BumpReflectiveSpecular_pass0_Pixel_Shader_main();
   }

}

