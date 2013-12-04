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

	class DiffuseMulCubemapReflection : public detail::base_shademodel,

						   public detail::IParameterBrightness,

						   //public detail::IParameterTransfViewProj,
						   public detail::IParameterTransfViewProjTranspose,

						   public detail::IParameterTransfWorld,
						  
						   public detail::IParameterEyePosition,


						   public detail::IParameterDiffuseTexture,
						   public detail::IParameterCubemapReflectionTexture


	{
	public:
	
				 DiffuseMulCubemapReflection() {}
		virtual ~DiffuseMulCubemapReflection() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "DiffuseMulCubemapReflection";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::diffusemulcubemapreflection);
		}
	
	
	
	
	};
}
}
