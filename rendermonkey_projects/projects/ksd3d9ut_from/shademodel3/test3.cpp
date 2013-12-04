// #include "stdafx.h"

#ifdef __USE_TEST_SHADEMODEL__


// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#include <ksd3d9ut/rendertarget/rendertarget.h>

// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 
#include <dxut_wonly/dxut_wonly.h> 

// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#include <gbmath/_gbmath.h>


// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#include <d3dx9-dynamic-load/d3dx9_dynamic_load.h>
using    d3dx9_dynamic_load::CD3DX9_Dll_Loader;


#include <ksd3d9ut/draw/draw.h>
#include <ksd3d9ut/device_helper.h>

#include <ksd3d9ut/dxmesh/d3dxmesh.h>

#include <ksfilefunc/ksfilefunc.h>

// shade models
/*
#include <ksd3d9ut/shademodel3/Colored.h>
#include <ksd3d9ut/shademodel3/Textured.h>
#include <ksd3d9ut/shademodel3/Diffuse.h>
#include <ksd3d9ut/shademodel3/PhongSpecular.h>
#include <ksd3d9ut/shademodel3/PhongIlumination.h>

#include <ksd3d9ut/shademodel3/BumpReflectiveSpecular.h>
#include <ksd3d9ut/shademodel3/BumpSpecular.h>
#include <ksd3d9ut/shademodel3/BumpSpecularMap.h>


#include <ksd3d9ut/shademodel3/CubemapReflection.h>
#include <ksd3d9ut/shademodel3/DiffuseMulCubemapReflection.h>
		   */
#include  <ksd3d9ut/shademodel3/Owner.h>



//#include "ResourseManager.h"




 

#pragma warning(disable : 4996)

namespace ksd3d9ut
{

namespace shademodel3
{

namespace test
{
 
	struct __marker_vars {};

	//=======================================================
	using ksd3d9ut::shademodel3::ShadeModelType_e;

	// shade models global vars
	ksd3d9ut::shademodel3::detail::base_shademodel* g_pCurrent = NULL;
	ksd3d9ut::shademodel3::ShadeModelType_e g_type = ShadeModelType_e::colored;
 
	ksd3d9ut::shademodel3::Owner   g_owner;
	CD3DX9_Dll_Loader*  g_loader = NULL; 
//	ResourseManager* g_rm = NULL;
	gbmath::model_view_camera g_camera;



	ksd3d9ut::dxmesh::d3dxmesh * g_pmesh = NULL; 
 
	IDirect3DTexture9*  g_tex_diffuse = NULL;   
	IDirect3DTexture9*  g_tex_normalMap   = NULL;
	IDirect3DTexture9*  g_tex_additive     = NULL;
	IDirect3DCubeTexture9* g_tex_cubemap   = NULL;

	IDirect3DVolumeTexture9*  g_tex_NoiseVolume = NULL;



	bool SearchMediaDir(std::wstring& dest )
	{
		dest = L"";
 

		WCHAR fullpath[MAX_PATH] = {L'\0'};

		wcscpy(fullpath, 
			ksd3d9ut::shademodel3::detail::base_shademodel::GetHeadersDir().c_str() );
 

		/*
		// extract path
		{
			const int LEN = (int)wcslen(fullpath);
			for(int c=LEN; c>=0; c--)
			{
				if((fullpath[c]==L'\\')||(fullpath[c]==L'/'))
				{
					break;
				}

				fullpath[c] = L'\0';
			}

		}
		*/

		WCHAR result [512];
		result [0] = L'\0';

		bool found = false;
		while(!found)
		{
			wcscpy(result, fullpath);
			wcscat(result, L"media\\" );


			if( ksfilefunc::directoryExistW(result))
			{
				dest = result;
				return true;
			}

			// check path len
			if( wcslen(fullpath) < 4 )
			{
				return false;
			}

			// set full path level up
			{
				const int LEN2 = (int)wcslen(fullpath);
				fullpath[LEN2-1] = L'\0';
				for(int c=LEN2; c>=0; c--)
				{
					if( (fullpath[c]==L'\\') || (fullpath[c]==L'/') )
					{
						break;
					}

					fullpath[c] = L'\0';
				}
			}

		} // while
 
		return false;
	}

	HRESULT CheckCreateResources(IDirect3DDevice9* const device,
				CD3DX9_Dll_Loader* const loader)
	{
		HRESULT hr=0;

		static std::wstring mediadir;
		std::wstring strPath;

		{
			static bool firstcall = true;
			if(firstcall)
			{
				if(!SearchMediaDir(mediadir) )
				{
					throw std::runtime_error( "dir not found ");
				}

				firstcall = false;
			}
		}
 

		// crate rendering mesh
		if(g_pmesh==NULL)
		{
		    strPath = mediadir;
			strPath += L"teapot.x";
			

			g_pmesh = new ksd3d9ut::dxmesh::d3dxmesh( device, loader,  
				//"c:/Program Files/AMD/RenderMonkey 1.82/Examples/Media/Models/Sphere.x", 
				strPath.c_str() , //"j:\\ksd3d9ut\\ksd3d9ut\\media\\teapot.x",
				true 
			   );



		}

		if(g_tex_diffuse == NULL)
		{
			strPath = mediadir;
			strPath += L"diffuse.tga";
			hr |= loader->D3DXCreateTextureFromFileW(device, strPath.c_str() , &g_tex_diffuse);		
			assert( hr == 0 );
		}


		if(g_tex_normalMap == NULL)
		{
			strPath = mediadir;
			strPath += L"normalMap.tga";
			hr |= loader->D3DXCreateTextureFromFileW(device, strPath.c_str() , &g_tex_normalMap);		
			assert( hr == 0 );
		}		

		if(g_tex_additive == NULL)
		{
			strPath = mediadir;
			strPath += L"additive.tga";
			hr |= loader->D3DXCreateTextureFromFileW(device, strPath.c_str() , &g_tex_additive);		
			assert( hr == 0 );
		}		


		if(g_tex_cubemap == NULL)
		{
			strPath = mediadir;
			strPath += L"cubemap.dds";
			hr |= loader->D3DXCreateCubeTextureFromFileW(device, strPath.c_str() , &g_tex_cubemap);		
			assert( hr == 0 );
		}		


		if(g_tex_NoiseVolume == NULL)
		{
			strPath = mediadir;
			strPath += L"NoiseVolume.dds";
			hr |= loader->D3DXCreateVolumeTextureFromFileW(device, strPath.c_str() , &g_tex_NoiseVolume);		
			assert( hr == 0 );
		}	




		assert(hr==0);
		return hr;
	}

	void ReleaseAllResources()
	{

		if(g_pmesh)
		{
			delete g_pmesh;
			g_pmesh = NULL;
		}



		if(g_tex_diffuse)
		{
			g_tex_diffuse->Release();
			g_tex_diffuse=NULL;
		}

		if(g_tex_normalMap)
		{
			g_tex_normalMap->Release();
			g_tex_normalMap=NULL;
		}		


		if(g_tex_additive)
		{
			g_tex_additive->Release();
			g_tex_additive=NULL;
		}

		if(g_tex_cubemap)
		{
			g_tex_cubemap->Release();
			g_tex_cubemap=NULL;
		}


		 if(g_tex_NoiseVolume)
		 {
			 g_tex_NoiseVolume->Release();
			 g_tex_NoiseVolume=NULL;
		 }		


   




	}


 
bool CALLBACK IsDeviceAcceptable( D3DCAPS9* pCaps, D3DFORMAT AdapterFormat, 
								 D3DFORMAT BackBufferFormat, bool bWindowed, void* pUserContext )
{
	// Typically want to skip backbuffer formats that don't support alpha blending
	IDirect3D9* pD3D = DXUTGetD3DObject(); 
	if( FAILED( pD3D->CheckDeviceFormat( pCaps->AdapterOrdinal, pCaps->DeviceType,
		AdapterFormat, D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING, 
		D3DRTYPE_TEXTURE, BackBufferFormat ) ) )
		return false;

	return true;
}


//--------------------------------------------------------------------------------------
// Before a device is created, modify the device settings as needed
//--------------------------------------------------------------------------------------
bool CALLBACK ModifyDeviceSettings( DXUTDeviceSettings* pDeviceSettings, const D3DCAPS9* pCaps, void* pUserContext )
{
	return true;
}


//--------------------------------------------------------------------------------------
// Create any D3DPOOL_MANAGED resources here 
//--------------------------------------------------------------------------------------
HRESULT CALLBACK OnCreateDevice( IDirect3DDevice9* pd3dDevice, const D3DSURFACE_DESC* pBackBufferSurfaceDesc, void* pUserContext )
{
	HRESULT hr =0;
	g_loader = new CD3DX9_Dll_Loader();

//	g_rm = new ResourseManager(pd3dDevice , g_loader);

	//ksd3d9ut::shademodel3::detail::base_shademodel::SetAdditionSearchFxDir(
	//	 g_rm->GetMediaDirectory()	 );
 

	g_camera.setViewParams(vec3(6.0f , -4.0f, 0.0f ), vec3(0.0f, 0.0f, 0.0f) );

	return hr;
}


//--------------------------------------------------------------------------------------
// Create any D3DPOOL_DEFAULT resources here 
//--------------------------------------------------------------------------------------
HRESULT CALLBACK OnResetDevice( IDirect3DDevice9* pd3dDevice, 
							   const D3DSURFACE_DESC* pBackBufferSurfaceDesc, 
							   void* pUserContext )
{	
	HRESULT hr =0;

	g_camera.setWindow(pBackBufferSurfaceDesc->Width,
		pBackBufferSurfaceDesc->Height );





	return hr;
}


//-------------------------------------------------------------------------
// Handle updates to the scene
//-------------------------------------------------------------------------
void CALLBACK OnFrameMove( IDirect3DDevice9* pd3dDevice, double fTime, 
						  float fElapsedTime, void* pUserContext )
{
	g_camera.frameMove(fElapsedTime);

}


#if  1

HRESULT do_test(IDirect3DDevice9* device, float time)
{
	HRESULT hr =0;	 
	using namespace  ksd3d9ut::shademodel3;
 
	
	mat44 world;
	world.setIdentity();
	//world.setRotationY(time/4.0f);
	mat44 wvp = world * g_camera.getViewMatrix() * g_camera.getProjMatrix();
	const mat44 viewinverse = g_camera.getViewMatrix().inverted();
	const mat44 viewproj = g_camera.getViewMatrix() * g_camera.getProjMatrix();

	vec3 eyepos;
	eyepos.x = viewinverse._41;
	eyepos.y = viewinverse._42;
	eyepos.z = viewinverse._43;
 


	//===================  switch  =======================

	g_pCurrent = g_owner.GetShadeModelByType(g_type);


	switch(g_type)
	{
	case ShadeModelType_e::colored: {
	   hr|=g_owner.GetColored()->SetMatrixWorldViewProj( &wvp);

	   //g_pCurrent = (detail::base_shademodel*)&g_Colored;
									} break;

	case ShadeModelType_e::textured: {
	  hr|= g_owner.GetTextured()->SetMatrixWorldViewProj(&wvp);
	   hr|=g_owner.GetTextured()->SetTextureDiffuse(g_tex_diffuse);
				//g_pCurrent = (detail::base_shademodel*)&g_Textured;
									 } break;


	case ShadeModelType_e::diffuse: {
		
	 
		 //IParameterTransfWorldViewProj,
		  hr|=g_owner.GetDiffuse()->SetMatrixWorldViewProj(&wvp);
			   //IParameterTransfView,
		   hr|=g_owner.GetDiffuse()->SetMatrixView(&g_camera.getViewMatrix());
			   //IParameterTransfWorld,
		   hr|=g_owner.GetDiffuse()->SetMatrixWorld(&world);

			   //IParameterAmbientColor,
			   //IParameterDiffuseColor,

			   //IParameterLightPosition,

			   //IParameterDiffuseTexture	 
			hr|=g_owner.GetDiffuse()->SetTextureDiffuse (   g_tex_diffuse  );
 
			//	g_pCurrent = (detail::base_shademodel*)&g_Diffuse;
									} break;



	case ShadeModelType_e::phongspecular: {
		


		hr|=g_owner.GetPhongSpecular()->SetMatrixWorldViewProj(&wvp);
		hr|=g_owner.GetPhongSpecular()->SetMatrixWorld(&world);

		hr|=g_owner.GetPhongSpecular()->SetTextureDiffuse(g_tex_diffuse);


				//g_pCurrent = (detail::base_shademodel*)&g_PhongSpecular;

										  } break;
 


	case ShadeModelType_e::phongilumination: {
		

		hr|=g_owner.GetPhongIlumination()->SetMatrixWorldViewProj(&wvp);
		hr|=g_owner.GetPhongIlumination()->SetMatrixView(&g_camera.getViewMatrix());


		hr|=g_owner.GetPhongIlumination()->SetTextureDiffuse(g_tex_diffuse);
		hr|=g_owner.GetPhongIlumination()->SetTextureAdditive( g_tex_additive );


		//g_pCurrent = (detail::base_shademodel*)&g_PhongIlumumination;

											   } break;

 

	case ShadeModelType_e::bumpspecular: {



	//IParameterLightPosition,
	//hr|=g_BumpSpecular.

	//IParameterEyePosition,
	hr|= g_owner.GetBumpSpecular()->SetEyePosition(&eyepos);

	//IParameterTransfViewProj,
	hr|=g_owner.GetBumpSpecular()->SetMatrixViewProj(  &viewproj );

	//IParameterTransfView,
	hr|= g_owner.GetBumpSpecular()->SetMatrixView( &g_camera.getViewMatrix()  ); 

	//IParameterTransfWorld,
	hr|= g_owner.GetBumpSpecular()->SetMatrixWorld( &world  ); 


	//IParameterAmbientColor,

	//IParameterDiffuseColor,

	//IParameterSpecularColor,


	//IParameterDiffuseTexture,
	hr|=g_owner.GetBumpSpecular()->SetTextureDiffuse( g_tex_diffuse);

	//IParameterNormalMapTexture
	hr|=g_owner.GetBumpSpecular()->SetTextureNormalMap( g_tex_normalMap );


		// g_pCurrent = (detail::base_shademodel*)&g_BumpSpecular;
										 } break;


	case ShadeModelType_e::bumpreflectivespecular: {


	//IParameterTransfViewInverse, 
	hr|=g_owner.GetBumpReflectiveSpecular()->SetMatrixViewInverse(&viewinverse  );
	//IParameterTransfView ,
	hr|=g_owner.GetBumpReflectiveSpecular()->SetMatrixView(&g_camera.getViewMatrix() );
	//IParameterTransfViewProj,
	hr|=g_owner.GetBumpReflectiveSpecular()->SetMatrixViewProjTranspose(&viewproj);    

	//IParameterAmbientColor,
	//IParameterDiffuseColor,
	//IParameterSpecularColor,

	hr|=g_owner.GetBumpReflectiveSpecular()->SetEyePosition(&eyepos);


	//IParameterDiffuseTexture,
	hr|=g_owner.GetBumpReflectiveSpecular()->SetTextureDiffuse( g_tex_diffuse );
	//IParameterNormalMapTexture,
	hr|=g_owner.GetBumpReflectiveSpecular()->SetTextureNormalMap( g_tex_normalMap );
	//IParameterCubemapReflectionTexture
	hr|=g_owner.GetBumpReflectiveSpecular()->SetTextureCubemapReflection( g_tex_cubemap );



			//g_pCurrent = (detail::base_shademodel*)&g_BumpReflectiveSpecular;
												   } break;



	case ShadeModelType_e::bumpspecularmap : {



	// IParameterTransfViewProj,
	hr|=g_owner.GetBumpSpecularMap()->SetMatrixViewProj(&viewproj);

	// IParameterTransfView,
	hr|=g_owner.GetBumpSpecularMap()->SetMatrixView(&g_camera.getViewMatrix());

	hr|=g_owner.GetBumpSpecularMap()->SetEyePosition(&eyepos);


	// IParameterDiffuseTexture,
	 hr|=g_owner.GetBumpSpecularMap()->SetTextureDiffuse( g_tex_diffuse );

	// IParameterNormalMapTexture,
	 hr|=g_owner.GetBumpSpecularMap()->SetTextureNormalMap( g_tex_normalMap );

	// IParameterSpecularTexture
	hr|=g_owner.GetBumpSpecularMap()->SetTextureSpecular( g_tex_additive );




		//	g_pCurrent = (detail::base_shademodel*)&g_BumpSpecularMap;
				 }  break;




	case ShadeModelType_e::cubemapreflection: {
	   


		hr|=g_owner.GetCubemapReflection()->SetMatrixViewProj( &viewproj );
		hr|=g_owner.GetCubemapReflection()->SetMatrixWorld( &world );
 
		hr|=g_owner.GetCubemapReflection()->SetEyePosition(&eyepos);

		//g_CubemapReflection.SetTextureBrithness( cccccccc );
		hr|=g_owner.GetCubemapReflection()->SetTextureCubemapReflection( g_tex_cubemap );
 
		// g_pCurrent = (detail::base_shademodel*)&g_CubemapReflection;
							} break;



	case ShadeModelType_e:: diffusemulcubemapreflection :  {

		
	 
     hr|=g_owner.GetDiffuseMulCubemapReflection()->SetMatrixViewProjTranspose( &viewproj );
	 hr|=g_owner.GetDiffuseMulCubemapReflection()->SetMatrixWorld( &world );

	 hr|=g_owner.GetDiffuseMulCubemapReflection()->SetEyePosition(&eyepos);

	 hr|=g_owner.GetDiffuseMulCubemapReflection()->SetTextureDiffuse( g_tex_diffuse );
	 hr|=g_owner.GetDiffuseMulCubemapReflection()->SetTextureCubemapReflection(  g_tex_cubemap );



		//  g_pCurrent = (detail::base_shademodel*)&g_DiffuseMulCubemapReflection;
						 }  break;



	case ShadeModelType_e::anisotropicsatin:  
		{
			// IParameterTransfViewProj,
	   hr|=g_owner.GetAnisotropicSatin()->SetMatrixViewProj(&g_camera.getViewMatrix() );
 
		// IParameterTransfView,
	  hr|=g_owner.GetAnisotropicSatin()->SetMatrixView( &viewproj );
		 //IParameterColor,
	   //hr|=g_owner.GetAnisotropicSatin()->SetObjectColor();

		  //IParameterLightDirection
	   //hr|=g_owner.GetAnisotropicSatin()->

 
 
		} break;





 
	case ShadeModelType_e::anisotpicbrushedmetal:
		{
		   assert(false);
		   hr |= g_owner.GetAnisotpicBrushedMetal()->SetMatrixViewProj(&viewproj);
		   hr |= g_owner.GetAnisotpicBrushedMetal()->SetMatrixViewInverse(&viewinverse);

 

		} break;
 



	default: 
			{
				int temp = (int)g_type._e;
				printf("type=%i \n", temp);
				assert(false && "  default case  ");
			}

	}



	if(g_pCurrent==NULL) return hr;



	hr|= g_pCurrent->BeginDraw(device, g_loader);
	hr |= g_pmesh->drawSubset(0);
	hr|= g_pCurrent->EndDraw();	

	return hr;
}

#endif 

struct __mark_end_testfunc {};






//-------------------------------------------------------------------------
//  Draw text
//-------------------------------------------------------------------------
HRESULT DrawText(IDirect3DDevice9* device)
{
	HRESULT hr=0;

	hr |= device->BeginScene();
 
	 int y=55;
	 if(g_pCurrent == NULL)
	 {
		hr |= ksd3d9ut::draw::DrawStr(device, 22, y, "NULL", 0xffffffff);
	 }
	 else
	 {
		hr |= ksd3d9ut::draw::DrawStr(device, 22, y, g_pCurrent->GetName(), 0xffffffff);
	 }
	 y+= 12;




	 // draw help
	 y+= 50;
	hr |= ksd3d9ut::draw::DrawStr(device, 22, y, "Press N for next shademodel", 0xffffffff);



	hr |= device->EndScene();
	assert(hr==0);
 
	return hr;
}

 

//-------------------------------------------------------------------------
// Render the scene 
//-------------------------------------------------------------------------
void CALLBACK OnFrameRender( IDirect3DDevice9* pd3dDevice, double fTime, float fElapsedTime, void* pUserContext )
{
	HRESULT hr=0;
 

	hr |= g_owner.CheckInterfaces(pd3dDevice, g_loader);
	assert(hr==0);

	hr |= CheckCreateResources(pd3dDevice, g_loader);


	// Clear the render target and the zbuffer 
	V( pd3dDevice->Clear(0, NULL, D3DCLEAR_TARGET | D3DCLEAR_ZBUFFER,   D3DCOLOR_ARGB(0, 45, 50, 170),  1.0f, 0) );
 




	// Render the scene
	if( SUCCEEDED( pd3dDevice->BeginScene() ) )
	{

	ksd3d9ut::device_helper device_helper(pd3dDevice);
	hr |= device_helper.setTransformView( (D3DMATRIX*)&g_camera.getViewMatrix() );
	hr |= device_helper.setTransformProj( (D3DMATRIX*)&g_camera.getProjMatrix() );

	//dh.set_CullModeCW();

 
	D3DCOLORVALUE color;
	color.r=color.g=color.b=color.a=1.0f;

 
		hr |= device_helper.setTextureFilter_mip_min_mag_linear(0);

		//hr |= ksd3d9ut::draw::drawMeshPrimitiveCube1x1Mem(pd3dDevice);

		// check interfaces
		hr |= g_owner.CheckInterfaces(pd3dDevice, g_loader);	
		assert(hr==0 && " check interfaces error ");


		 hr |= do_test(pd3dDevice, (float)fTime);
 

		V( pd3dDevice->EndScene() );
	}


	// draw text
	hr |= DrawText(pd3dDevice);

	assert(hr==0);
}


//-------------------------------------------------------------------------
// Handle messages to the application 
//-------------------------------------------------------------------------
LRESULT CALLBACK MsgProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam, 
						 bool* pbNoFurtherProcessing, void* pUserContext )
{
	g_camera.handleMessages(hWnd, uMsg, wParam, lParam);
	return 0;
}

void  CALLBACK KeyboardProc( UINT nChar, bool bKeyDown, 
							bool bAltDown, void* pUserContext )
{
	if(bKeyDown)
	{
 

		if(nChar == 'N')
		{
		   ++g_type;

		   int _end =0;
 
		}


	}

}

void CALLBACK MouseProc( bool bLeftButtonDown, bool bRightButtonDown, 
						bool bMiddleButtonDown, bool bSideButton1Down, 
						bool bSideButton2Down, int nMouseWheelDelta, 
						int xPos, int yPos, void* pUserContext )
{



}


//-------------------------------------------------------------------------
// Release resources created in the OnResetDevice callback here 
//-------------------------------------------------------------------------
void CALLBACK OnLostDevice( void* pUserContext )
{
 
	ksd3d9ut::draw::ReleaseAllInternalData();

	ReleaseAllResources();


	// release
	/*
	g_Colored.ReleaseInterfaces();  
	g_Textured.ReleaseInterfaces();
	g_Diffuse.ReleaseInterfaces();
	g_PhongSpecular.ReleaseInterfaces();
	g_PhongIlumumination.ReleaseInterfaces();
	g_BumpReflectiveSpecular.ReleaseInterfaces();
	g_BumpSpecular.ReleaseInterfaces();
	g_CubemapReflection.ReleaseInterfaces();
	g_DiffuseMulCubemapReflection.ReleaseInterfaces();
	g_BumpSpecularMap.ReleaseInterfaces();
 
		*/


	g_owner.ReleaseInterfaces();
//	g_rm->FreeAllResources(); 

}


//-------------------------------------------------------------------------
// Release resources created in the OnCreateDevice callback here
//-------------------------------------------------------------------------
void CALLBACK OnDestroyDevice( void* pUserContext )
{
 

	ReleaseAllResources();
 

	ksd3d9ut::draw::ReleaseAllInternalData();
 
	g_owner.ReleaseInterfaces();
 

	delete g_loader;
	g_loader = NULL;

}


 


}
}
}




//================================================================= 
int main(int argc,  char* argv[])   
{

	using namespace ksd3d9ut::shademodel3::test;
	// Enable run-time memory check for debug builds.
	#if defined(DEBUG) | defined(_DEBUG)
		_CrtSetDbgFlag( _CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF );
	#endif



	// Set the callback functions
	DXUTSetCallbackDeviceCreated( OnCreateDevice  );
	DXUTSetCallbackDeviceReset( OnResetDevice  );
	DXUTSetCallbackDeviceLost( OnLostDevice  );
	DXUTSetCallbackDeviceDestroyed( OnDestroyDevice );
	DXUTSetCallbackMsgProc( MsgProc  );
	DXUTSetCallbackFrameRender( OnFrameRender );
	DXUTSetCallbackFrameMove( OnFrameMove  );
	DXUTSetCallbackKeyboard(KeyboardProc  );
	DXUTSetCallbackMouse(MouseProc  );



	// TODO: Perform any application-level initialization here

	// Initialize DXUT and create the desired Win32 window and Direct3D device for the application
	DXUTInit( true, true, true ); // Parse the command line, handle the default hotkeys, and show msgboxes
	DXUTSetCursorSettings( true, true ); // Show the cursor and clip it when in full screen
	DXUTCreateWindow( L"shademodel3 test" );
	DXUTCreateDevice( D3DADAPTER_DEFAULT, 
		true, 800, 600, IsDeviceAcceptable, ModifyDeviceSettings );




	// Start the render loop
	DXUTMainLoop();
	DXUTShutdown( 0 );

	// TODO: Perform any application-level cleanup here

	return DXUTGetExitCode();
}

 
 
#endif // __USE_TEST_SHADEMODEL__
