/**  \file 
 \brief 

*/

#pragma once

#include "detail/base_shademodel.h"
#include "detail/params.h"



namespace ksd3d9ut
{
namespace shademodel3
{

	class BumpReflectiveSpecular : public detail::base_shademodel,
						 //public detail::IParameterTransfWorldViewProj,

						 public detail::IParameterTransfViewInverse,  
						 public detail::IParameterTransfView , 
						 public detail::IParameterTransfViewProjTranspose,

						 public detail::IParameterEyePosition,

						 public detail::IParameterAmbientColor,
						 public detail:: IParameterDiffuseColor,
						 public detail::IParameterSpecularColor,


						 public detail::IParameterDiffuseTexture,
						 public detail::IParameterNormalMapTexture,
						 public detail::IParameterCubemapReflectionTexture

					 
	{
	public:
	
				 BumpReflectiveSpecular() {}
		virtual ~BumpReflectiveSpecular() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "BumpReflectiveSpecular";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::bumpreflectivespecular);
		}
	
	
	
	
	};
}
}
