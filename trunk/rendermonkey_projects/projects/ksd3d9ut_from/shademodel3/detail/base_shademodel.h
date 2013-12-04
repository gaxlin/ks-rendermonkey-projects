/**  \file 
 \brief 
 
*/


#pragma once

#include <d3d9.h>

// A class to dynamically load and use of functional D3DX9 DLL 
// http://code.google.com/p/d3dx9-dynamic-load/
#include <d3dx9-dynamic-load/d3dx9_dynamic_load.h>
	using d3dx9_dynamic_load::CD3DX9_Dll_Loader;

// math library (MIT licence)
// http://code.google.com/p/gbmath/
#include <gbmath/_gbmath.h>
	using namespace gbmath;

	/*
	using gbmath::vec2;
	using gbmath::vec3;
	using gbmath::vec4;

	using gbmath::mat33;
	using gbmath::mat44;

	using gbmath::color4f;
		 */


#include "params.h"
#include "../ShadeModelType_e.h"

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <assert.h>




namespace ksd3d9ut
{

namespace shademodel3
{

namespace detail
{


	typedef LPVOID   PARAMS    ; //< temp

	class base_shademodel {
	protected:
		ID3DXEffect* m_eff;
		
		
		ID3DXEffect* getProgram() const throw (std::runtime_error&);
	
	public:
	
				  base_shademodel();
		virtual  ~base_shademodel();

		static void SetAdditionSearchFxDir(const char* dir);
		static std::wstring GetHeadersDir();
		
		
		HRESULT BeginDraw(IDirect3DDevice9* device, CD3DX9_Dll_Loader* loader);
		HRESULT EndDraw();
		
		HRESULT CheckInterfaces(IDirect3DDevice9* device, CD3DX9_Dll_Loader* loader);
		HRESULT CommitChanges();
		void ReleaseInterfaces();

		bool isProgramCreated() const
		{
			return m_eff != NULL;
		}
		
		//virtual HRESULT SetParams(PARAMS* params) {return 0;};
		
		virtual const char* GetName() const =0;
		virtual bool isAlphaBlended() const =0;
		virtual ShadeModelType_e GetType() const =0;
	
	
	
	};




}
}
}
