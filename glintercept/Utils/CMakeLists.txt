ADD_DEFINITIONS(-D GLI_BUILD_WINDOWS)

SET(LIB_EXTERNAL_DEPS
  
)


INCLUDE_DIRECTORIES(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/../MainLib
)


#file(GLOB SOURCE_FILES "*")


#--------------------common-----------------------------
SET(ConfigParser
	${CMAKE_CURRENT_SOURCE_DIR}/OSDefines.h
	${CMAKE_CURRENT_SOURCE_DIR}/ConfigParser.h
	${CMAKE_CURRENT_SOURCE_DIR}/ConfigParser.cpp
)
#source_group("ConfigParser" FILES ${ConfigParser})

SET(SysUtils
	${CMAKE_CURRENT_SOURCE_DIR}/ErrorLog.h
	${CMAKE_CURRENT_SOURCE_DIR}/ErrorLog.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/MiscUtils.h
	${CMAKE_CURRENT_SOURCE_DIR}/MiscUtils.cpp

		${CMAKE_CURRENT_SOURCE_DIR}/FileUtils.h
	${CMAKE_CURRENT_SOURCE_DIR}/FileUtils.cpp

		${CMAKE_CURRENT_SOURCE_DIR}/InputUtils.h
	${CMAKE_CURRENT_SOURCE_DIR}/InputUtils.cpp

		${CMAKE_CURRENT_SOURCE_DIR}/MovieMaker.h
	${CMAKE_CURRENT_SOURCE_DIR}/MovieMaker.cpp

)
#source_group("SysUtils" FILES ${SysUtils})

SET(LIB_SOURCES
	${ConfigParser}
	${SysUtils}
)

get_filename_component(MyProjectName ${CMAKE_CURRENT_SOURCE_DIR} NAME)

VSP_ADD_LIBRARY(${MyProjectName} STATIC)
