/**  \file
 \brief 


*/

#pragma once

#include <d3d9.h>



// shade models
#include "Colored.h"
#include "Textured.h"
#include "Diffuse.h"
#include "PhongSpecular.h"
#include "PhongIlumination.h"
#include "BumpReflectiveSpecular.h"
#include "BumpSpecular.h"
#include "CubemapReflection.h"
#include "DiffuseMulCubemapReflection.h"
#include "BumpSpecularMap.h"
#include "AnisotropicSatin.h"
#include "AnisotpicBrushedMetal.h"


#include <assert.h>




namespace ksd3d9ut
{

namespace shademodel3
{

		class Owner {

		private:
			Colored                m_Colored;
			Textured               m_Textured;
			Diffuse                m_Diffuse;
			PhongSpecular          m_PhongSpecular;
			PhongIlumination       m_PhongIlumumination;
			
			BumpReflectiveSpecular m_BumpReflectiveSpecular;
			BumpSpecular           m_BumpSpecular;
			BumpSpecularMap        m_BumpSpecularMap;
			
			CubemapReflection      m_CubemapReflection;
			DiffuseMulCubemapReflection   m_DiffuseMulCubemapReflection;

			AnisotropicSatin        m_AnisotropicSatin;			
			AnisotpicBrushedMetal   m_AnisotpicBrushedMetal;			



		public:

					  Owner();
			 virtual ~Owner();

			 detail::base_shademodel* GetShadeModelByType(const ShadeModelType_e&);

			 HRESULT CheckInterfaces(IDirect3DDevice9* const, CD3DX9_Dll_Loader* loader);
			 HRESULT ReleaseInterfaces();

			inline Colored*                 GetColored()  { return  &m_Colored;  }
			inline Textured*                GetTextured() { return  &m_Textured; }
			inline Diffuse*                 GetDiffuse()  { return  &m_Diffuse; }
			
			inline PhongSpecular*           GetPhongSpecular()          { return  &m_PhongSpecular; }
			inline PhongIlumination*        GetPhongIlumination()       { return  &m_PhongIlumumination; }

			inline BumpReflectiveSpecular*  GetBumpReflectiveSpecular() { return  &m_BumpReflectiveSpecular; }
			inline BumpSpecular*            GetBumpSpecular()           { return  &m_BumpSpecular; }
			inline BumpSpecularMap*         GetBumpSpecularMap()        { return  &m_BumpSpecularMap; }
 

			inline CubemapReflection*			  GetCubemapReflection()            { return  &m_CubemapReflection; }
			inline DiffuseMulCubemapReflection*   GetDiffuseMulCubemapReflection()  { return  &m_DiffuseMulCubemapReflection; }
 
 
			inline AnisotropicSatin*		 GetAnisotropicSatin()            { return  &m_AnisotropicSatin; }
			inline AnisotpicBrushedMetal*    GetAnisotpicBrushedMetal()  { return  &m_AnisotpicBrushedMetal; }


 

		};






}
}
