/** \file 
 \brief	 Type of shade model .


*/

#pragma once

#include <d3d9.h>
#include <stdlib.h>
#include <string>
#include <stdexcept>
#include <assert.h>


 #pragma warning (disable : 4290)


namespace ksd3d9ut 
{

namespace shademodel3 
{



	struct  ShadeModelType_e
	{

		/** \brief Перечисление описания типа материала. <br>
		Каждый элемент перечисления соответствует своему классу  */
		enum e 
		{ 

			UNDEFINED     = 0, //< тип не определён.

			
			colored,
			textured,
			diffuse,


			phongspecular,
			phongilumination,

			bumpspecular,
			bumpspecularmap,
			bumpreflectivespecular,

			cubemapreflection,
			diffusemulcubemapreflection,

			anisotropicsatin,
			anisotpicbrushedmetal,
			
			
			/*
 
			DIFFUSEDIRECTIONAL,  ///<  Класс xxxx   
 
			PHONGSPECDIRLIGHT,  ///<  Класс MaterialPhongSpecDirLight.
			PHONGSPECPOINTLIGHT,  ///<  Класс MaterialPhongSpecPointLight.

 
			BUMPREFLECTNODIFFUSE,
			BUMPPOINTLIGHT,


			CUBEMAPREFLECTION,  ///<  Класс IMtrlTextureCubemapReflection
			TEXTUREDIFFUSESUMCUBEMAPREFLECTION,  ///<  Класс xxxx 								   
			TEXTUREDIFFUSEMULCUBEMAPREFLECTION,	  ///<  Класс xxxx


			LIGHTDIREYE,  ///<
				*/



			__UNUSED_DECLARED_LAST, ///<  ЭТОТ ПУНКТ НЕ ИСПОЛЬЗУЕТСЯ ДЕКЛАРИРУЕТСЯ ПОСЛЕДНИМ.

			__MT_FORCEDWORD  = 0x7F000000  //* ЭТОТ ПУНКТ НЕ ИСПОЛЬЗУЕТСЯ. ЗАСТАВИТЬ ВЗЯТЬ 4 БАЙТА.

		};


		ShadeModelType_e()
		{
			_e = colored;
		}

		ShadeModelType_e(const ShadeModelType_e& a)
		{
			*this = a;
		}

		ShadeModelType_e(const e a)
		{
			_e = a;
		}

		void operator = (const std::string&) throw (std::runtime_error);
		operator  std::string() const throw (std::runtime_error);

		operator e() const 
		{ 
			return _e; 
		}

		void operator = (const e a) 
		{ 
			_e = a; 
		}

		void operator ++()
		{
			int temp = (int)_e;
			temp++;

			_e = (e)temp;

				if(_e >= __UNUSED_DECLARED_LAST)
				{
					_e = colored;
					return;
				}
		}


 
		e _e;
	};







}
}

// end file