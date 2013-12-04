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

	class BumpSpecular : public detail::base_shademodel ,
						// public detail::IParameterTransfWorldViewProj,
						 //public detail::IParameterDiffuseTexture,
						 //public detail::IParameterColor
						 public detail::IParameterSpecularPower,
						 public detail::IParameterLightPosition,
						 public detail::IParameterEyePosition,
						 public detail::IParameterTransfViewProj,
						 public detail::IParameterTransfView,
						 public detail::IParameterTransfWorld,

						 public detail::IParameterAmbientColor,
						 public detail::IParameterDiffuseColor,
						 public detail::IParameterSpecularColor,

						 public detail::IParameterDiffuseTexture,
						 public detail::IParameterNormalMapTexture


	{
	public:
	
				 BumpSpecular() {}
		virtual ~BumpSpecular() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "BumpSpecular";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::bumpspecular);
		}
	
	
	
	
	};
}
}
