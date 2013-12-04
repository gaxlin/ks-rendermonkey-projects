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

	class AnisotropicSatin : public detail::base_shademodel,
						 //public detail::IParameterTransfWorldViewProj,
						 public detail::IParameterTransfViewProj,
						 public detail::IParameterTransfView,
						 public detail::IParameterColor,
						 public detail::IParameterLightDirection // ,
	{
	public:
	
				 AnisotropicSatin() {}
		virtual ~AnisotropicSatin() {}
		
		virtual ID3DXEffect*   getParamProgram() 
		{
			return getProgram(); 
		}
		
		virtual const char* GetName() const
		{
			return "AnisotropicSatin";
		}
		
		virtual bool isAlphaBlended() const 
		{
			return false;
		}

		virtual ShadeModelType_e GetType() const 
		{
			return ShadeModelType_e(ShadeModelType_e::anisotropicsatin);
		}
	

		//--------------  custom params --------------------------

		inline HRESULT Set_noiseRate(float value)
		{
			HRESULT hr = getProgram()->SetFloat( "noiseRate" , value );
			assert(hr==0);
			return hr;
		}

		inline HRESULT Set_noiseScale(float value)
		{
			HRESULT hr = getProgram()->SetFloat( "noiseScale" , value );
			assert(hr==0);
			return hr;
		}

		inline HRESULT Set_color_gloss ( const D3DXCOLOR* color )
		{
			HRESULT hr = getProgram()->SetVector( "gloss" , (D3DXVECTOR4*)&color->r );
			assert(hr==0);
			return hr;
		}



	
	
	
	};
}
}
