
set(MyProjectName OpenGL32)

ADD_DEFINITIONS(-D GLINTERCEPT_EXPORTS)


include(CMakeTestASMCompiler)
enable_language(ASM_MASM)


SET(LIB_EXTERNAL_DEPS

)

SET(LIB_INTERNAL_DEPS
  CoronaStatic
  Utils
  )

INCLUDE_DIRECTORIES(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/../Common
  )

  
#--------------------common-----------------------------


SET(SysUtils


)
source_group("common\\SysUtils" FILES ${SysUtils})


#--------------------DLLLoader-----------------------------
SET(DLLLoader
	${CMAKE_CURRENT_SOURCE_DIR}/DLLLoader.h
	${CMAKE_CURRENT_SOURCE_DIR}/DLLLoader.cpp
)
source_group("DLLLoader" FILES ${DLLLoader})

#--------------------FunctionParser-----------------------------
SET(FunctionParser
	${CMAKE_CURRENT_SOURCE_DIR}/FunctionParser.h
	${CMAKE_CURRENT_SOURCE_DIR}/FunctionParser.cpp
)
source_group("FunctionParser" FILES ${FunctionParser})

#--------------------Header Files-----------------------------
SET(HeaderFiles
	${CMAKE_CURRENT_SOURCE_DIR}/GLDefines.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLInterceptConfig.h
)
source_group("Header Files" FILES ${HeaderFiles})



#--------------------BuiltInFunction-----------------------------
SET(BuiltInFunction
	${CMAKE_CURRENT_SOURCE_DIR}/BuiltInFunction.h
	${CMAKE_CURRENT_SOURCE_DIR}/BuiltInFunction.cpp
)
source_group("BuiltInFunction" FILES ${BuiltInFunction})


#--------------------ExtensionFunction-----------------------------
if(CMAKE_CL_64)
	SET(TMP ${CMAKE_CURRENT_SOURCE_DIR}/ExtensionFunctionStubs_64.asm)
else()
	SET(TMP)
endif()


SET(ExtensionFunction
	${CMAKE_CURRENT_SOURCE_DIR}/ExtensionFunction.h
	${CMAKE_CURRENT_SOURCE_DIR}/ExtensionFunction.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/ExtensionFunctionWrapper.h
	${CMAKE_CURRENT_SOURCE_DIR}/ExtensionFunctionWrapper.cpp
#	${CMAKE_CURRENT_SOURCE_DIR}/ExtensionFunctionStubs.cpp
	${TMP}
)
source_group("ExtensionFunction" FILES ${ExtensionFunction})


#--------------------FunctionTable-----------------------------
SET(FunctionTable
	${CMAKE_CURRENT_SOURCE_DIR}/FunctionArgs.h
	${CMAKE_CURRENT_SOURCE_DIR}/FunctionRetValue.h
	${CMAKE_CURRENT_SOURCE_DIR}/FunctionParamStore.h

	${CMAKE_CURRENT_SOURCE_DIR}/FunctionData.h
	${CMAKE_CURRENT_SOURCE_DIR}/FunctionData.cpp	
	${CMAKE_CURRENT_SOURCE_DIR}/FunctionTable.h
	${CMAKE_CURRENT_SOURCE_DIR}/FunctionTable.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/EnumData.h
	${CMAKE_CURRENT_SOURCE_DIR}/EnumData.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/ParameterData.h
	${CMAKE_CURRENT_SOURCE_DIR}/ParameterData.cpp
)
source_group("FunctionTable" FILES ${FunctionTable})


#--------------------InterceptData-----------------------------
SET(InterceptData

#DisplayList
	${CMAKE_CURRENT_SOURCE_DIR}/DisplayListManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/DisplayListManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/DisplayListSaveManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/DisplayListSaveManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptDisplayList.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptDisplayList.cpp
#Frame
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptFrame.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptFrame.cpp
#Image
	${CMAKE_CURRENT_SOURCE_DIR}/ImageManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/ImageManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/ImageSaveManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/ImageSaveManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptImage.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptImage.cpp
#Shader
	${CMAKE_CURRENT_SOURCE_DIR}/ShaderManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/ShaderManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/ShaderSaveManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/ShaderSaveManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptShader.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptShader.cpp
#ShaderGLSL
	${CMAKE_CURRENT_SOURCE_DIR}/ShaderGLSLManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/ShaderGLSLManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/ShaderGLSLSaveManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/ShaderGLSLSaveManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptShaderGLSL.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptShaderGLSL.cpp


	${CMAKE_CURRENT_SOURCE_DIR}/InterceptData.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptData.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptDataManager.h
)

source_group("InterceptData" FILES ${InterceptData})


#--------------------InterceptLog-----------------------------
SET(InterceptLog
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptLog.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptLog.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptLogText.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptLogText.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptLogXML.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptLogXML.cpp
)
source_group("InterceptLog" FILES ${InterceptLog})


#--------------------InterceptPlugin-----------------------------

SET(InterceptPlugin
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptPluginInterface.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptPluginManager.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptPluginManager.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptPluginDLLInstance.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptPluginDLLInstance.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptPluginInstance.h
	${CMAKE_CURRENT_SOURCE_DIR}/InterceptPluginInstance.cpp
)
source_group("InterceptPlugin" FILES ${InterceptPlugin})

#--------------------Interface-----------------------------
SET(Interface
#Stubs
	${CMAKE_CURRENT_SOURCE_DIR}/GLStubs.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLStubs.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/GLStubsWGL.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLStubsWGL.cpp

	${CMAKE_CURRENT_SOURCE_DIR}/GLFunctions.h

	${CMAKE_CURRENT_SOURCE_DIR}/GLCore1_2.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLCore1_2.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/GLCore1_1.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLCore1_1.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/GLWindows.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLWindows.cpp
)
source_group("Interface" FILES ${Interface})


#--------------------Source Files-----------------------------

SET(SourceFiles
#Stubs
	${CMAKE_CURRENT_SOURCE_DIR}/ConfigData.h
	${CMAKE_CURRENT_SOURCE_DIR}/ConfigData.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/GLContext.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLContext.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/GLDriver.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLDriver.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/GLIntercept.h
	${CMAKE_CURRENT_SOURCE_DIR}/GLIntercept.cpp
)
source_group("Source Files" FILES ${SourceFiles})



SET(LIB_SOURCES
	${SysUtils}
	${ConfigParser}
	${DLLLoader}
	${FunctionParser}
	${HeaderFiles}
	${BuiltInFunction}
	${ExtensionFunction}
	${FunctionTable}
	${InterceptData}
	${InterceptLog}
	${InterceptPlugin}
	${Interface}
	${SourceFiles}
)



VSP_ADD_LIBRARY(${MyProjectName})

if(CMAKE_CL_64)
	SET_PROPERTY(TARGET ${MyProjectName} PROPERTY LINK_FLAGS /DEF:"${CMAKE_CURRENT_SOURCE_DIR}/glInterceptx64.def")
else()
	SET_PROPERTY(TARGET ${MyProjectName} PROPERTY LINK_FLAGS /DEF:"${CMAKE_CURRENT_SOURCE_DIR}/glIntercept.def")
endif()


TARGET_LINK_LIBRARIES(${MyProjectName}
 odbc32.lib
 odbccp32.lib
 OpenGL32.lib
 imagehlp.lib
)