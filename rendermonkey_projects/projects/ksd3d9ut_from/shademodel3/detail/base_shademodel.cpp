// #include "stdafx.h"
#include "base_shademodel.h"

#include <ksfilefunc/ksfilefunc.h>

#pragma warning (disable : 4996)

namespace ksd3d9ut 
{
namespace shademodel3 
{
namespace detail
{

	static char g_additionalFxDir[MAX_PATH] = {'\0'};

	void queryFxPath(char* path)
	{
	    *path = 0;

		strcpy(path, __FILE__);
		const int LEN = (int)strlen(path);
		bool foundFirstSlash = false;
		for(int c=LEN; c>=0; c--)
		{

			
 
				if( (path[c]=='\\') || (path[c]=='/') )
				{
					if (foundFirstSlash) break;
					foundFirstSlash = true;
				}
 

			path[c] = '\0';
		}
 


	}


base_shademodel::base_shademodel()
{


}


base_shademodel::~base_shademodel()
{
	ReleaseInterfaces();

}

void base_shademodel::SetAdditionSearchFxDir(const char* dir)
{
	strcpy(g_additionalFxDir, dir);
}

std::wstring   base_shademodel::GetHeadersDir()
{
 

	char char_path [MAX_PATH];
	strcpy(char_path, __FILE__ );

 
	int LEN = (int)strlen(char_path);
	for(int c=LEN-1; c>=0; c--)
	{
		if( (char_path[c]=='/') || (char_path[c]=='\\') )
		{
			break;			
		}

		char_path[c]= '\0' ;
	}

	WCHAR wchar_path[MAX_PATH];
	memset( wchar_path, 0, sizeof(wchar_path) );

	LEN = (int)strlen(char_path);
	for(int c=0; c<LEN; c++)
	{
		wchar_path[c] = (WCHAR)char_path[c];
	}


	return std::wstring(wchar_path);

}

HRESULT base_shademodel::BeginDraw(IDirect3DDevice9* device, CD3DX9_Dll_Loader* loader)
{
	HRESULT hr =0;
	hr |= CheckInterfaces(device, loader);
	assert(hr==0);
	if FAILED(hr) 
	{
		return hr;
	}
	
	UINT passes =0;
	hr |= m_eff->Begin( &passes , 0 );
	hr |= m_eff->BeginPass(0);
	assert(hr==0 && " failed effect operation ");
	
	
	
	return hr;
}


HRESULT base_shademodel::EndDraw()
{
	HRESULT hr =0;
	if(m_eff==NULL)
		return hr;

	//hr |= CheckInterfaces(device, loader);
	//if FAILED(hr) return hr;
	
	hr |= m_eff->EndPass();
	hr |= m_eff->End();
	
	
	
	return hr;
}

HRESULT base_shademodel::CheckInterfaces(IDirect3DDevice9* device, CD3DX9_Dll_Loader* loader)
{
	HRESULT hr =0;

#define ERR_FXFILE_NOTFOUND   "  fx file not found ! "
 
	if(m_eff == NULL)
	{
		// create effect
		char path[MAX_PATH];
		memset(path, 0, sizeof(path));


		// make full fx path
		queryFxPath(path);
 


		strcat(path, GetName());
		strcat(path, ".fx");

		if(!ksfilefunc::fileExistsA(path))
		{
			// not found
			if(g_additionalFxDir[0] == '\0')
			{
				// none
				assert(   false &&  ERR_FXFILE_NOTFOUND );
				return E_FAIL;
			}

			strcpy(path, g_additionalFxDir);
			strcat(path , GetName() );
			strcat(path, ".fx");
			if(!ksfilefunc::fileExistsA(path))
			{
				// not found
				assert(   false &&  ERR_FXFILE_NOTFOUND );
				return E_FAIL;
			}


		}



		// create
		LPD3DXBUFFER errorbuffer = NULL;
		hr |= loader->D3DXCreateEffectFromFileA(device, path,
			NULL, NULL, 0, NULL, &m_eff, &errorbuffer );

		std::string strError;
		if FAILED(hr)
		{
			
			if(errorbuffer)
			{
			   char* temp = new char[errorbuffer->GetBufferSize() + 100];
			   memset(temp, 0, sizeof(temp) );
			   memcpy(temp, errorbuffer->GetBufferPointer(), 
								errorbuffer->GetBufferSize() );
			   strError = temp;

			   delete [] temp;
			   temp = NULL;
			}
			else
			{
				 strError = " error buffer empty !";
			}

#ifdef _DEBUG
	 MessageBoxA(0, strError.c_str(), "Error create effect", MB_OK | MB_ICONERROR);
#endif
			assert(hr==0 && "  Error create effect ");

		}
 
	}
	
	
#undef ERR_FXFILE_NOTFOUND

	return hr;
}

HRESULT base_shademodel::CommitChanges()
{
	assert(m_eff);
	if(m_eff==NULL) 
		return E_FAIL;

	return m_eff->CommitChanges();
}

void base_shademodel::ReleaseInterfaces()
{
	if(m_eff)
	{
		m_eff->Release();
		m_eff = NULL;
	}
	
	

}

ID3DXEffect* base_shademodel::getProgram() const throw (std::runtime_error&)
{
	if(m_eff==NULL)
	{


		assert(false && "inseert code create effect");
		throw std::runtime_error(" effect is NULL ");
	}
	
	return m_eff;
}



}
}
}
