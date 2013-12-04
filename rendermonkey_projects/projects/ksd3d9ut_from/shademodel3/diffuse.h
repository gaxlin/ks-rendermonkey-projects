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

	class Diffuse : public detail::base_shademodel ,

						public detail::IParameterTransfWorldViewProj,
						public detail::IParameterTransfView,
						public detail::IParameterTransfWorld,

						 public detail::IParameterAmbientColor,
						 public detail::IParameterDiffuseColor,

						 public detail::IParameterLightPosition,

						 public detail::IParameterDiffuseTexture


	{
	public:
	
				 Diffuse() {}
		virtual ~Diffuse() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "Diffuse";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::diffuse);
		}
	
	
	
	
	};
}
}
