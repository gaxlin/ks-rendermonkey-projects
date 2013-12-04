/**  \file 
 \brief classes for set parameters
 
*/

#pragma once

#include <d3d9.h>

#include "base_shademodel.h"



#include <stdlib.h>
#include <string>
#include <assert.h>


namespace ksd3d9ut
{

namespace shademodel3
{

namespace detail
{



/** \brief Класс базовый интерфейс для классов-интерфейсов установки параметров в материал. */  
class IParameter {
protected:

	/** \brief Получение указателя на шейдер. */
	virtual ID3DXEffect* getParamProgram()  = 0;

};
 
//-------------------------   float params -------------------------------



/** \brief Класс  интерфейс для материалов имеющих параметр 
			яркость кубической текстуры отражения. */
class IParameterCubemapBrightness : public IParameter {
public:

	inline HRESULT SetCubemapBrightness(const float value) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetFloat("cubemapBrightness", value );
		assert(hr==0);
		return hr;
	}
};


/** \brief Класс  интерфейс для материалов имеющих параметр яркость. */
class IParameterBrightness : public IParameter  { 
public:

	inline HRESULT SetBrightness(const float value) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetFloat("brightness", value );
		assert(hr==0);
		return hr;
	}

}; 
 


/** \brief Класс интерфейс для материалов имеющих параметр яркость диффузной текстуры.  */ 
class IParameterDiffuseTextureBrightness  : public IParameter {
public:

	inline HRESULT SetDiffuseTextureBrightness(const float value) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetFloat( "diffuseBrightness", value );
		assert(hr==0);
		return hr;
	}

}; 
 



/** \brief Класс  интерфейс для материалов имеющих параметр силу спекулярного отражения. */ 
class IParameterSpecularPower : public IParameter  {
public:

	inline HRESULT SetSpecularPower(float value) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetFloat("fSpecularPower", value);
		assert(hr==0);
		return hr;
	}

};
 




/** \brief Класс  интерфейс для материалов имеющих параметр степень рельефности. */ 
class IParameterBumpness : public IParameter  {
public:

	inline HRESULT SetBumpness( const float value) 
	{
		HRESULT hr =0;
		hr   |= getParamProgram()->SetFloat("bumpness", value);
		assert(hr==0);
		return hr;
	}
};

  

class IParameterTime : public IParameter  {
public:

	inline HRESULT SetBumpness( const float value) 
	{
		HRESULT hr =0;
		hr   |= getParamProgram()->SetFloat("time", value);
		assert(hr==0);
		return hr;
	}
};



class IParameterLightFalloff : public IParameter  {
public:

	inline HRESULT SetLightFalloff( const float value) 
	{
		HRESULT hr =0;
		hr   |= getParamProgram()->SetFloat("LightFalloff", value);
		assert(hr==0);
		return hr;
	}
}; 

 
/** \brief Класс  интерфейс для материалов имеющих параметр яркость текстуры свечения. */ 
class IParameterAdditiveIntencity : public IParameter  {
public:

	inline HRESULT SetAdditiveIntencity( const float value) 
	{
		HRESULT hr =0;
		hr   |= getParamProgram()->SetFloat("additiveIntencity", value);
		assert(hr==0);
		return hr;
	}
}; 



//-----------------------   vectors params  ---------------------------



/** \brief Класс  интерфейс для материалов имеющих параметр позиция наблюдения . */
class IParameterEyePosition : public IParameter {
public:

	inline HRESULT SetEyePosition(const vec3* src) 
	{
		HRESULT hr =0;
		float array[4];
		array[0] = src->x;
		array[1] = src->y;
		array[2] = src->z;
		array[3] = 1.0f;
		hr   |= getParamProgram()->SetVector("eyePosition",  (D3DXVECTOR4*)&array[0] );
		assert(hr==0);
		return hr;
	}

	inline HRESULT SetEyePosition(const vec4* src) 
	{
		HRESULT hr=0;
		hr |= getParamProgram()->SetVector("eyePosition",  (D3DXVECTOR4*)&src->x );
		assert(hr==0);
		return hr;
	}
};   




/** \brief Класс  интерфейс для материалов имеющих параметр позиция источника освещения . */
class IParameterLightPosition : public IParameter {
public:

	inline HRESULT SetLightPosition(const vec3* src) 
	{
		HRESULT hr =0;
		hr   |= getParamProgram()->SetFloatArray("lightPosition", &src->x, 3 ) ;
		assert(hr==0);
		return hr;
	}

};   



/** \brief Класс  интерфейс для материалов имеющих параметр направление источника освещения . */
class IParameterLightDirection : public IParameter {
public:

	inline HRESULT SetLightDirection(const vec3* value) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetFloatArray("lightDirection", &value->x, 3 );
		assert(hr==0);
		return hr;
	}

}; 


//-----------------------  color  params  ------------------------------




/** \brief Класс  интерфейс для материалов имеющих параметр objColor
общий цвет. (ЦВЕТ ОБЪЕКТА). */ 
class IParameterColor : public IParameter  {
public:

	inline HRESULT SetObjectColor(const color4f* color_rgba) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetVector("ObjectColor",  (D3DXVECTOR4*)&color_rgba->r );
		assert(hr==0);
		return hr;
	}
}; 




/** \brief Класс  интерфейс для материалов имеющих параметр цвет Ambient  */  
class IParameterAmbientColor : public IParameter {
public:

	inline HRESULT SetColorAmbient(const color4f* color_rgba) 
	{
		HRESULT hr = 0;
		hr |= getParamProgram()->SetVector("Ambient",  (D3DXVECTOR4*)&color_rgba->r);
		assert(hr==0);
		return hr;
	}
}; 




/** \brief Класс  интерфейс для материалов имеющих параметр дифузный цвет. */ 
class  IParameterDiffuseColor : public IParameter  {
public:

	inline HRESULT SetColorDiffuse(const color4f* color_rgba) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetVector("Diffuse",  (D3DXVECTOR4*)&color_rgba->r );
		assert(hr==0);
		return hr;
	}
}; 




/** \brief Класс  интерфейс для материалов имеющих параметр спекулярный цвет. */ 
class IParameterSpecularColor : public IParameter  { 
public:

	inline HRESULT SetColorSpecular(const color4f* value) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetVector("Specular", (D3DXVECTOR4*)&value->r );
		assert(hr==0);
		return hr;
	}
}; 



//-----------------------  matrix  params  ------------------------------



/** \brief Класс  интерфейс для материалов имеющих параметр трансформацию WORLD.  */ 
class IParameterTransfWorld : public IParameter  {
public:

	inline HRESULT SetMatrixWorld(const mat44* matrix4x4_World) 
	{
		HRESULT hr =0; 
		hr |= getParamProgram()->SetMatrix( "mWorld", (D3DXMATRIX*)&matrix4x4_World->_11 );
		assert(hr==0);
		return hr;
	}
}; 
 

/** \brief Класс  интерфейс для материалов имеющих параметр трансформацию VIEW.  */ 
class IParameterTransfView : public IParameter  {
public:

	inline HRESULT SetMatrixView(const mat44* matrix4x4_View) 
	{
		HRESULT hr =0; 
		hr |= getParamProgram()->SetMatrix( "mView", (D3DXMATRIX*)&matrix4x4_View->_11 );
		assert(hr==0);
		return hr;
	}
}; 

class IParameterTransfViewInverse : public IParameter  {
public:

	inline HRESULT SetMatrixViewInverse(const mat44* mViewInverse ) 
	{
		HRESULT hr =0; 
 
			hr |= getParamProgram()->SetMatrix( "mViewInverse", 
				(D3DXMATRIX*)&mViewInverse->_11 );

		assert(hr==0);
		return hr;
	}

	/*
	inline HRESULT SetMatrixViewInverseFromView(const mat44* mView, bool transponed=false) 
	{
		HRESULT hr =0; 
		mat44 inv = *mView;
		inv.invert();
		hr |= getParamProgram()->SetMatrix( "mViewInverse", (D3DXMATRIX*)&inv._11 );
		assert(hr==0);
		return hr;
	}
	*/



}; 
 	 

/** \brief Класс  интерфейс для материалов имеющих параметр трансформацию PROJ.  */ 
class IParameterTransfProj : public IParameter  {
public:

	inline HRESULT SetMatrixProj(const mat44* matrix4x4_Proj) 
	{
		HRESULT hr =0; 
		hr |= getParamProgram()->SetMatrix( "mProj",  (D3DXMATRIX*)&matrix4x4_Proj->_11 );
		assert(hr==0);
		return hr;
	}
}; 
 

/** \brief Класс  интерфейс для материалов имеющих параметр трансформацию VIEW * PROJ.  */ 
class IParameterTransfViewProj : public IParameter  {
public:

	inline HRESULT SetMatrixViewProj(const mat44* matrix4x4_ViewProj) 
	{
		HRESULT hr =0; 
		hr |= getParamProgram()->SetMatrix( "mViewProj", (D3DXMATRIX*)&matrix4x4_ViewProj->_11 );
		assert(hr==0);
		return hr;
	}
}; 

class IParameterTransfViewProjTranspose : public IParameter  {
public:

	inline HRESULT SetMatrixViewProjTranspose(const mat44* matrix4x4_ViewProj) 
	{
		HRESULT hr =0; 
		hr |= getParamProgram()->SetMatrixTranspose( "mViewProj", 
						(D3DXMATRIX*)&matrix4x4_ViewProj->_11 );
		assert(hr==0);
		return hr;
	}
};



 

/** \brief Класс  интерфейс для материалов имеющих параметр трансформацию WorldViewProj.  */ 
class IParameterTransfWorldViewProj  : public IParameter  {
public:

	inline HRESULT SetMatrixWorldViewProj(const mat44* matrix4x4_WorldViewProj) 
	{
		HRESULT hr =0;
		hr |=  getParamProgram()->SetMatrix("mWorldViewProj",  (D3DXMATRIX*)&matrix4x4_WorldViewProj->_11);
		assert(hr==0);
		return hr;
	}
}; 
 



//-----------------------  texture params --------------------------
 



/** \brief Класс интерфейс для материалов имеющих параметр дифузную текстуру.  */ 
class IParameterDiffuseTexture : public IParameter {
public:

	inline HRESULT SetTextureDiffuse(IDirect3DBaseTexture9* ptxtr) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetTexture( "diffuse_Tex", ptxtr );
		assert(hr==0);
		return hr;
	}
}; 



/** \brief Класс  интерфейс для материалов имеющих параметр текстуру нормали. */ 
class IParameterNormalMapTexture : public IParameter  {
public:

	inline HRESULT SetTextureNormalMap(IDirect3DBaseTexture9* pTexture) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetTexture( "normalMap_Tex", pTexture );
		assert(hr==0);
		return hr;
	}
}; 

/** \brief Класс интерфейс для материалов имеющих параметр текстуру самосвечения. */ 
class IParameterAdditiveTexture : public IParameter {
public:

	inline HRESULT SetTextureAdditive(IDirect3DBaseTexture9* ptxtr) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetTexture( "additive_Tex", ptxtr );
		assert(hr==0);
		return hr;
	}
};


/** \brief Класс  интерфейс для материалов имеющих параметр кубическую текстуру отражения. */
class IParameterCubemapReflectionTexture : public IParameter {
public:

	inline HRESULT SetTextureCubemapReflection(IDirect3DCubeTexture9* texture) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetTexture("cubeMap_Tex", (IDirect3DBaseTexture9*)texture  );
		assert(hr==0);
		return hr;
	}

};

//! \brief  Для моделей имеющих текстуру карты спекуляра.
class IParameterSpecularTexture : public IParameter {
public:

	inline HRESULT SetTextureSpecular(IDirect3DBaseTexture9* pSpecularTexture) 
	{
		HRESULT hr =0;
		hr |= getParamProgram()->SetTexture( "specular_Tex", pSpecularTexture );
		assert(hr==0);
		return hr;
	}
};
 

//-------------------------------------------------------------------

}
}
}
