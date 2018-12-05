ADD_DEFINITIONS(-D GLI_BUILD_WINDOWS)

SET(LIB_EXTERNAL_DEPS
  
)


INCLUDE_DIRECTORIES(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/../MainLib
)


#file(GLOB SOURCE_FILES "*")


#--------------------common-----------------------------


SET(SysUtils

)
source_group("SysUtils" FILES ${SysUtils})

SET(LIB_SOURCES
	${ConfigParser}
	${SysUtils}
)

get_filename_component(MyProjectName ${CMAKE_CURRENT_SOURCE_DIR} NAME)

#VSP_ADD_LIBRARY(${MyProjectName} STATIC)
