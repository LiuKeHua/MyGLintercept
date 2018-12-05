PROJECT(Opengl_Hook)
cmake_minimum_required(VERSION 2.8)


SET_PROPERTY(GLOBAL PROPERTY USE_FOLDERS ON)
SET(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "possible configurations" FORCE)
SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMakeModules;${CMAKE_MODULE_PATH}")


SET(CMAKE_USE_RELATIVE_PATHS ON)


INCLUDE(UtilityMacros)

set(CompilerFlags
      CMAKE_CXX_FLAGS
      CMAKE_CXX_FLAGS_DEBUG
      CMAKE_CXX_FLAGS_RELEASE
      CMAKE_C_FLAGS
      CMAKE_C_FLAGS_DEBUG
      CMAKE_C_FLAGS_RELEASE
)
 foreach(CompilerFlag ${CompilerFlags})
   string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
 endforeach()

 ADD_DEFINITIONS(-D GLI_BUILD_WINDOWS)

INCLUDE_DIRECTORIES(
  ${PROJECT_SOURCE_DIR}
  )
ADD_subdirectory(Corona-1.0.2-Static)
ADD_subdirectory(glintercept)