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

	class Textured : public detail::base_shademodel,
						 public detail::IParameterTransfWorldViewProj,
						 public detail::IParameterDiffuseTexture,
						 public detail::IParameterColor						 
	{
	public:
	
				 Textured() {}
		virtual ~Textured() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "Textured";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::textured);
		}
	
	
	
	
	};
}
}
