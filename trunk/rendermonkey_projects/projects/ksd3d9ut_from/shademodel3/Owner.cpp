// #include "stdafx.h"

#include "Owner.h"

namespace ksd3d9ut
{

namespace shademodel3
{

Owner::Owner()
{


}

Owner::~Owner()
{

}

detail::base_shademodel* Owner::GetShadeModelByType(const ShadeModelType_e& _type)
{
	using detail::base_shademodel;
 
	switch(_type._e)
	{
	case ShadeModelType_e::colored : return ( base_shademodel*)&m_Colored; break;
	case ShadeModelType_e::textured : return ( base_shademodel*)&m_Textured; break;
	case ShadeModelType_e::diffuse : return ( base_shademodel*)&m_Diffuse; break;

	case ShadeModelType_e::phongspecular : return ( base_shademodel*)&m_PhongSpecular; break;
	case ShadeModelType_e::phongilumination : return ( base_shademodel*)&m_PhongIlumumination; break;

	case ShadeModelType_e::bumpspecular : return ( base_shademodel*)&m_BumpSpecular; break;
	case ShadeModelType_e::bumpreflectivespecular : return ( base_shademodel*)&m_BumpReflectiveSpecular; break;
	case ShadeModelType_e::bumpspecularmap : return ( base_shademodel*)&m_BumpSpecularMap; break;

	
	
	
	case ShadeModelType_e::cubemapreflection : return ( base_shademodel*)&m_CubemapReflection; break;
	case ShadeModelType_e::diffusemulcubemapreflection : return ( base_shademodel*)&m_DiffuseMulCubemapReflection; break;
 
 
	case ShadeModelType_e::anisotropicsatin  : return ( base_shademodel*)&m_AnisotropicSatin; break;
	case ShadeModelType_e::anisotpicbrushedmetal : return ( base_shademodel*)&m_AnisotpicBrushedMetal; break;
 
	
		default: 
			{
			   assert(  false && "  unused case ");
			}

	}


	assert(  false  && "  ShadeModel not found " );
	return NULL;
}

HRESULT Owner::CheckInterfaces(IDirect3DDevice9* const device, 
							   CD3DX9_Dll_Loader* loader)
{
	HRESULT hr=0;

	hr |= m_Colored.CheckInterfaces(device, loader);
	assert(hr==0);
	hr |= m_Textured.CheckInterfaces(device, loader);
	assert(hr==0);
	hr |= m_Diffuse.CheckInterfaces(device, loader);
	assert(hr==0);
	
	hr |= m_PhongSpecular.CheckInterfaces(device, loader);
	assert(hr==0);
	hr |= m_PhongIlumumination.CheckInterfaces(device, loader);
	assert(hr==0);
	
	hr |= m_BumpReflectiveSpecular.CheckInterfaces(device, loader);
	assert(hr==0);
	hr |= m_BumpSpecular.CheckInterfaces(device, loader);
	assert(hr==0);
	hr |= m_BumpSpecularMap.CheckInterfaces(device, loader);
	assert(hr==0);
	
	
	hr |= m_CubemapReflection.CheckInterfaces(device, loader);
	assert(hr==0);
	hr |= m_DiffuseMulCubemapReflection.CheckInterfaces(device, loader);
	assert(hr==0);

	
	hr |= m_AnisotropicSatin.CheckInterfaces(device, loader);
	assert(hr==0);
	hr |= m_AnisotpicBrushedMetal.CheckInterfaces(device, loader);
	assert(hr==0);	
	
	

		 


	assert(hr==0);
	return hr;
}


HRESULT Owner::ReleaseInterfaces()
{
	HRESULT hr =0;


	m_Colored.ReleaseInterfaces();
	m_Textured.ReleaseInterfaces();
	m_Diffuse.ReleaseInterfaces();
	m_PhongSpecular.ReleaseInterfaces();
	m_PhongIlumumination.ReleaseInterfaces();
	
	m_BumpReflectiveSpecular.ReleaseInterfaces();
	m_BumpSpecular.ReleaseInterfaces();
	m_BumpSpecularMap.ReleaseInterfaces();
	
	m_CubemapReflection.ReleaseInterfaces();  
	m_DiffuseMulCubemapReflection.ReleaseInterfaces();
	
	m_AnisotropicSatin.ReleaseInterfaces();  
	m_AnisotpicBrushedMetal.ReleaseInterfaces();







	return hr;
}






}
}
