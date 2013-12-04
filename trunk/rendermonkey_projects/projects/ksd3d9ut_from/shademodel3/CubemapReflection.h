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

	class CubemapReflection : public detail::base_shademodel,
						public detail::IParameterTransfViewProj,
						public detail::IParameterTransfWorld,
 
						public detail::IParameterEyePosition,

						public detail::IParameterCubemapBrightness,
						public detail::IParameterCubemapReflectionTexture
	{
	public:
	
				 CubemapReflection() {}
		virtual ~CubemapReflection() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "CubemapReflection";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::cubemapreflection);
		}
	
	
	
	
	};
}
}
