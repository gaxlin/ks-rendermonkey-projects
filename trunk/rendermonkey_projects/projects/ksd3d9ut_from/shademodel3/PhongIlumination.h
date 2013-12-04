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

	class PhongIlumination : public detail::base_shademodel,
						public detail::IParameterAdditiveIntencity,
						public detail::IParameterTransfWorldViewProj,
						public detail::IParameterTransfView,
						public detail::IParameterEyePosition,
						public detail::IParameterDiffuseTexture,
						public detail::IParameterAdditiveTexture

						// public detail::IParameterColor						 
	{
	public:
	
				 PhongIlumination() {}
		virtual ~PhongIlumination() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "PhongIlumination";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::phongilumination);
		}
	
	
	
	
	};
}
}
