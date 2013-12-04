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

// shade models
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






#pragma warning(disable : 4996)

namespace ksd3d9ut
{

	namespace shademodel3
	{

		namespace test
		{


			//=======================================================
			using ksd3d9ut::shademodel3::ShadeModelType_e;

			// shade models global vars
			ksd3d9ut::shademodel3::detail::base_shademodel* g_pCurrent = NULL;
			ksd3d9ut::shademodel3::ShadeModelType_e g_type = ShadeModelType_e::colored;

			ksd3d9ut::shademodel3::Colored                g_Colored;
			ksd3d9ut::shademodel3::Textured               g_Textured;
			ksd3d9ut::shademodel3::Diffuse                g_Diffuse;
			ksd3d9ut::shademodel3::PhongSpecular          g_PhongSpecular;
			ksd3d9ut::shademodel3::PhongIlumination       g_PhongIlumumination;


			ksd3d9ut::shademodel3::BumpReflectiveSpecular g_BumpReflectiveSpecular;
			ksd3d9ut::shademodel3::BumpSpecular           g_BumpSpecular;
			ksd3d9ut::shademodel3::BumpSpecularMap        g_BumpSpecularMap;


			ksd3d9ut::shademodel3::CubemapReflection      g_CubemapReflection;
			ksd3d9ut::shademodel3::DiffuseMulCubemapReflection      g_DiffuseMulCubemapReflection;







			CD3DX9_Dll_Loader*  g_loader = NULL; 
			gbmath::model_view_camera g_camera;



			ksd3d9ut::dxmesh::d3dxmesh * g_pmesh = NULL; 


			IDirect3DTexture9* g_texture_diffuse = NULL;
			IDirect3DTexture9* g_texture_normalmap = NULL;
			IDirect3DTexture9* g_texture_additive = NULL;
			IDirect3DCubeTexture9* g_texture_cubemap = NULL;


			//-------------------------------------------------------------------------
			// Rejects any devices that aren't acceptable by returning false
			//-------------------------------------------------------------------------
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



				// crate textures
				if(g_texture_diffuse==NULL)
				{
					hr|=g_loader->D3DXCreateTextureFromFileA(pd3dDevice,
						"c:/Program Files/AMD/RenderMonkey 1.82/Examples/Media/Textures/Fieldstone.tga", 
						&g_texture_diffuse);
					assert(hr==0);
				}

				if(g_texture_normalmap==NULL)
				{
					hr|=g_loader->D3DXCreateTextureFromFileA(pd3dDevice,
						"c:/Program Files/AMD/RenderMonkey 1.82/Examples/Media/Textures/FieldstoneBumpDOT3.tga", &g_texture_normalmap);
					assert(hr==0);
				}

				if(g_texture_additive==NULL)
				{
					hr|=g_loader->D3DXCreateTextureFromFileA(pd3dDevice,
						"c:/Program Files/AMD/RenderMonkey 1.82/Examples/Media/Textures/base.tga", &g_texture_additive);
					assert(hr==0);
				}

				if(g_texture_cubemap==NULL)
				{
					hr |= g_loader->D3DXCreateCubeTextureFromFileA(pd3dDevice,
						"c:/Program Files/AMD/RenderMonkey 1.82/Examples/Media/Textures/grace_cube.dds",  &g_texture_cubemap);

					assert(hr==0);
				}






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

				switch(g_type)
				{
				case ShadeModelType_e::colored: {
					g_Colored.SetMatrixWorldViewProj( &wvp);

					g_pCurrent = (detail::base_shademodel*)&g_Colored;
												} break;

				case ShadeModelType_e::textured: {
					g_Textured.SetMatrixWorldViewProj(&wvp);
					g_Textured.SetTextureDiffuse(g_texture_diffuse);
					g_pCurrent = (detail::base_shademodel*)&g_Textured;
												 } break;


				case ShadeModelType_e::diffuse: {

					//IParameterTransfWorldViewProj,
					g_Diffuse.SetMatrixWorldViewProj(&wvp);
					//IParameterTransfView,
					g_Diffuse.SetMatrixView(&g_camera.getViewMatrix());
					//IParameterTransfWorld,
					g_Diffuse.SetMatrixWorld(&world);

					//IParameterAmbientColor,
					//IParameterDiffuseColor,

					//IParameterLightPosition,

					//IParameterDiffuseTexture	 
					hr|=g_Diffuse.SetTextureDiffuse (   g_texture_diffuse  );

					g_pCurrent = (detail::base_shademodel*)&g_Diffuse;
												} break;



				case ShadeModelType_e::phongspecular: {
					g_PhongSpecular.SetMatrixWorldViewProj(&wvp);
					g_PhongSpecular.SetMatrixWorld(&world);
					g_PhongSpecular.SetTextureDiffuse(g_texture_diffuse);
					g_pCurrent = (detail::base_shademodel*)&g_PhongSpecular;

													  } break;



				case ShadeModelType_e::phongilumination: {
					g_PhongIlumumination.SetMatrixWorldViewProj(&wvp);
					g_PhongIlumumination.SetMatrixView(&g_camera.getViewMatrix());
					g_PhongIlumumination.SetTextureDiffuse(g_texture_diffuse);
					g_PhongIlumumination.SetTextureAdditive(g_texture_additive);
					g_pCurrent = (detail::base_shademodel*)&g_PhongIlumumination;

														 } break;



				case ShadeModelType_e::bumpspecular: {

					//IParameterLightPosition,
					//hr|=g_BumpSpecular.

					//IParameterEyePosition,
					// g_BumpSpecular.SetEyePosition(viewpositionn);

					//IParameterTransfViewProj,
					g_BumpSpecular.SetMatrixViewProj( 
						&(g_camera.getViewMatrix() * g_camera.getProjMatrix()) );

					//IParameterTransfView,
					g_BumpSpecular.SetMatrixView( &g_camera.getViewMatrix()  ); 

					//IParameterTransfWorld,
					g_BumpSpecular.SetMatrixWorld( &world  ); 


					//IParameterAmbientColor,

					//IParameterDiffuseColor,

					//IParameterSpecularColor,


					//IParameterDiffuseTexture,
					g_BumpSpecular.SetTextureDiffuse(g_texture_diffuse);

					//IParameterNormalMapTexture
					g_BumpSpecular.SetTextureNormalMap(g_texture_normalmap);






					g_pCurrent = (detail::base_shademodel*)&g_BumpSpecular;
													 } break;


				case ShadeModelType_e::bumpreflectivespecular: {
					//IParameterTransfViewInverse, 
					g_BumpReflectiveSpecular.SetMatrixViewInverse(&viewinverse  );
					//IParameterTransfView ,
					g_BumpReflectiveSpecular.SetMatrixView(&g_camera.getViewMatrix() );
					//IParameterTransfViewProj,
					g_BumpReflectiveSpecular.SetMatrixViewProjTranspose(&viewproj);    

					//IParameterAmbientColor,
					//IParameterDiffuseColor,
					//IParameterSpecularColor,

					g_BumpReflectiveSpecular.SetEyePosition(&eyepos);


					//IParameterDiffuseTexture,
					g_BumpReflectiveSpecular.SetTextureDiffuse( g_texture_diffuse);
					//IParameterNormalMapTexture,
					g_BumpReflectiveSpecular.SetTextureNormalMap(g_texture_normalmap);
					//IParameterCubemapReflectionTexture
					g_BumpReflectiveSpecular.SetTextureCubemapReflection(g_texture_cubemap);






					g_pCurrent = (detail::base_shademodel*)&g_BumpReflectiveSpecular;
															   } break;



				case ShadeModelType_e::bumpspecularmap : {

					// IParameterTransfViewProj,
					g_BumpSpecularMap.SetMatrixViewProj(&viewproj);

					// IParameterTransfView,
					g_BumpSpecularMap.SetMatrixView(&g_camera.getViewMatrix());

					g_BumpSpecularMap.SetEyePosition(&eyepos);




					// IParameterDiffuseTexture,
					g_BumpSpecularMap.SetTextureDiffuse(g_texture_diffuse);

					// IParameterNormalMapTexture,
					g_BumpSpecularMap.SetTextureNormalMap(g_texture_normalmap);


					// IParameterSpecularTexture
					g_BumpSpecularMap.SetTextureSpecular(g_texture_additive);



					g_pCurrent = (detail::base_shademodel*)&g_BumpSpecularMap;
														 }  break;




				case ShadeModelType_e::cubemapreflection: {
					g_CubemapReflection. SetMatrixViewProj( &viewproj );
					g_CubemapReflection.SetMatrixWorld( &world );

					g_CubemapReflection.SetEyePosition(&eyepos);

					//g_CubemapReflection.SetTextureBrithness( cccccccc );
					g_CubemapReflection.SetTextureCubemapReflection(  g_texture_cubemap );




					g_pCurrent = (detail::base_shademodel*)&g_CubemapReflection;
														  } break;



				case ShadeModelType_e:: diffusemulcubemapreflection :  {

					g_DiffuseMulCubemapReflection.SetMatrixViewProjTranspose( &viewproj );
					g_DiffuseMulCubemapReflection.SetMatrixWorld( &world );

					g_DiffuseMulCubemapReflection.SetEyePosition(&eyepos);

					g_DiffuseMulCubemapReflection.SetTextureDiffuse( g_texture_diffuse );
					g_DiffuseMulCubemapReflection.SetTextureCubemapReflection(  g_texture_cubemap );



					g_pCurrent = (detail::base_shademodel*)&g_DiffuseMulCubemapReflection;
																	   }  break;




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


				// Clear the render target and the zbuffer 
				V( pd3dDevice->Clear(0, NULL, D3DCLEAR_TARGET | D3DCLEAR_ZBUFFER,   D3DCOLOR_ARGB(0, 45, 50, 170),  1.0f, 0) );

				// crate rendering mesh
				if(g_pmesh==NULL)
				{
					g_pmesh = new ksd3d9ut::dxmesh::d3dxmesh( pd3dDevice, g_loader,  
						//"c:/Program Files/AMD/RenderMonkey 1.82/Examples/Media/Models/Sphere.x", 
						"j:\\ksd3d9ut\\ksd3d9ut\\media\\teapot.x",
						true 

						);

				}


				// Render the scene
				if( SUCCEEDED( pd3dDevice->BeginScene() ) )
				{

					ksd3d9ut::device_helper dh(pd3dDevice);
					hr |= dh.setTransformView( (D3DMATRIX*)&g_camera.getViewMatrix() );
					hr |= dh.setTransformProj( (D3DMATRIX*)&g_camera.getProjMatrix() );

					dh.set_CullModeCW();


					D3DCOLORVALUE color;
					color.r=color.g=color.b=color.a=1.0f;






					hr |= pd3dDevice->SetTexture(0, g_texture_diffuse);
					ksd3d9ut::device_helper dhelper(pd3dDevice);
					hr |= dhelper.setTextureFilter_mip_min_mag_linear(0);

					//hr |= ksd3d9ut::draw::drawMeshPrimitiveCube1x1Mem(pd3dDevice);

					// check interfaces
					hr|=g_Colored.CheckInterfaces(pd3dDevice, g_loader);
					hr|=g_Textured.CheckInterfaces(pd3dDevice, g_loader);
					hr|=g_Diffuse.CheckInterfaces(pd3dDevice, g_loader);
					hr|=g_PhongSpecular.CheckInterfaces(pd3dDevice, g_loader);
					hr|=g_PhongIlumumination.CheckInterfaces(pd3dDevice, g_loader);

					hr|=g_BumpSpecular.CheckInterfaces(pd3dDevice, g_loader);
					hr|=g_BumpReflectiveSpecular.CheckInterfaces(pd3dDevice, g_loader);
					hr|=g_BumpSpecularMap.CheckInterfaces(pd3dDevice, g_loader);


					hr|=g_CubemapReflection.CheckInterfaces(pd3dDevice, g_loader);
					hr|=g_DiffuseMulCubemapReflection.CheckInterfaces(pd3dDevice, g_loader);






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

				if(g_pmesh)
				{
					delete g_pmesh;
					g_pmesh = NULL;
				}

				// release
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




			}


			//-------------------------------------------------------------------------
			// Release resources created in the OnCreateDevice callback here
			//-------------------------------------------------------------------------
			void CALLBACK OnDestroyDevice( void* pUserContext )
			{


				if(g_pmesh)
				{
					delete g_pmesh;
					g_pmesh = NULL;
				}


				// release
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




				if(g_texture_diffuse)
				{
					g_texture_diffuse->Release();
					g_texture_diffuse = NULL;
				}

				if(g_texture_normalmap)
				{
					g_texture_normalmap->Release();
					g_texture_normalmap = NULL;
				}

				if(g_texture_additive)
				{
					g_texture_additive->Release();
					g_texture_additive = NULL;
				}

				if(g_texture_cubemap)
				{
					g_texture_cubemap->Release();
					g_texture_cubemap = NULL;
				}

				if(g_pmesh)
				{
					delete g_pmesh;
					g_pmesh = NULL;
				}





				ksd3d9ut::draw::ReleaseAllInternalData();





				delete g_loader;
				g_loader = NULL;

			}


			// end namespaces
		}
	}
}



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