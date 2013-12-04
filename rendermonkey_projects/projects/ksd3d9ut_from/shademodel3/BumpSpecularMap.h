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

	class BumpSpecularMap : public detail::base_shademodel,
						 public detail::IParameterTransfViewProj,
						 public detail::IParameterTransfView,

						 public detail::IParameterAmbientColor,
						 public detail::IParameterDiffuseColor,
						 public detail::IParameterSpecularColor,

						 public detail::IParameterLightPosition,
						 public detail::IParameterEyePosition,


						 public detail::IParameterDiffuseTexture,
						 public detail::IParameterNormalMapTexture,
						 public detail::IParameterSpecularTexture



	{
	public:
	
				 BumpSpecularMap() {}
		virtual ~BumpSpecularMap() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "BumpSpecularMap";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::bumpspecularmap );
		}
	
	
	
	
	};
}
}
