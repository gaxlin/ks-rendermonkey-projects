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

	class PhongSpecular : public detail::base_shademodel,
								   public detail::IParameterTransfWorld,
								   public detail::IParameterTransfWorldViewProj,
								   //public detail::IParameterTransfProj,
								   public detail::IParameterDiffuseTexture,
								   //public detail::IParameterDiffuse,
								   public detail::IParameterLightPosition,
								   public detail::IParameterEyePosition//,

								   //public detail::IParameterLightFalloff
	{
	public:
	
				 PhongSpecular() {}
		virtual ~PhongSpecular() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "PhongSpecular";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}
	
		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::phongspecular);
		}	
	
	
	};
}
}
