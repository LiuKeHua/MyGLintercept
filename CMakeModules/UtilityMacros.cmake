SET(CMAKE_DEBUG_POSTFIX "" CACHE STRING "add a postfix, usually d on windows")
SET(CMAKE_RELEASE_POSTFIX "" CACHE STRING "add a postfix, usually empty on windows")
SET(CMAKE_RELWITHDEBINFO_POSTFIX "rd" CACHE STRING "add a postfix, usually empty on windows")
SET(CMAKE_MINSIZEREL_POSTFIX "s" CACHE STRING "add a postfix, usually empty on windows")


function(AddAllSubProjectForDirectory directory)
  file(GLOB  Directories  "${directory}/*")
  foreach(_var ${Directories})
    get_filename_component(MyProjectName ${_var} NAME)
    IF(NOT ( ${MyProjectName} MATCHES ".txt"))
#      message(${MyProjectName})
      ADD_subdirectory(${MyProjectName})
    ENDIF()
  endforeach()
endfunction()

##########���ñ�׼�����Ŀ¼�ṹ################################################################
SET(OUTPUT_BINDIR ${PROJECT_BINARY_DIR}/bin)
MAKE_DIRECTORY(${OUTPUT_BINDIR})
SET(OUTPUT_LIBDIR ${PROJECT_BINARY_DIR}/lib)
MAKE_DIRECTORY(${OUTPUT_LIBDIR})

SET (CMAKE_ARCHIVE_OUTPUT_DIRECTORY  ${OUTPUT_LIBDIR} CACHE PATH "build directory")
SET (CMAKE_RUNTIME_OUTPUT_DIRECTORY  ${OUTPUT_BINDIR} CACHE PATH "build directory")
SET (CMAKE_LIBRARY_OUTPUT_DIRECTORY  ${OUTPUT_BINDIR} CACHE PATH "build directory")


FOREACH(CONF ${CMAKE_CONFIGURATION_TYPES})
  STRING(TOUPPER "${CONF}" CONF)  # Go uppercase (DEBUG, RELEASE...)
  SET("CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONF}"  "${OUTPUT_LIBDIR}")
  SET("CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONF}"  "${OUTPUT_BINDIR}")
  SET("CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONF}"  "${OUTPUT_BINDIR}")
ENDFOREACH()
##########################################################################


########���ù��̵�ǰ׺���ƺ͸ù������ڵķ���#####################################
MACRO(SET_PROJECTLABEL_AND_FOLDERGROUP FOLDERNAME)
  SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES FOLDER ${FOLDERNAME})
#�������ڹ����ļ�����ӱ�ǩ,���ɵĹ����ļ���ʽΪ:"${TARGET_LABEL}${TARGET_NAME}"
  SET(TARGET_LABEL "")
  IF( TARGET_LABEL )
    SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES PROJECT_LABEL "${TARGET_LABEL}${TARGET_NAME}")
  ENDIF(TARGET_LABEL)
ENDMACRO(SET_PROJECTLABEL_AND_FOLDERGROUP)
########################################################################


#########���õ�ǰ�����ļ������·��##########################################
#��Ҫ������ CURRENT_ARCHIVE_PATH��CURRENT_RUNTIME_PATH��CURRENT_LIBRARY_PATH����������
MACRO(SET_CURRENT_DIR)
  # For each configuration (Debug, Release, MinSizeRel... and/or anything the user chooses)
  IF(CMAKE_CONFIGURATION_TYPES)
    FOREACH(CONF ${CMAKE_CONFIGURATION_TYPES})
      STRING(TOUPPER "${CONF}" CONF)
	  IF (${CONF} STREQUAL "DEBUG")  # ��Debug��������ֿ�
        SET(OUTPUT_FOLDER "Debug")
      ELSE()
	    SET(OUTPUT_FOLDER "Release")
      ENDIF (${CONF} STREQUAL "DEBUG")
     
      SET("CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONF}"  "${OUTPUT_LIBDIR}/${OUTPUT_FOLDER}/${CURRENT_ARCHIVE_PATH}")
      SET("CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONF}"  "${OUTPUT_BINDIR}/${OUTPUT_FOLDER}/${CURRENT_RUNTIME_PATH}")
      SET("CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONF}"  "${OUTPUT_BINDIR}/${OUTPUT_FOLDER}/${CURRENT_LIBRARY_PATH}")

    ENDFOREACH()
  ENDIF(CMAKE_CONFIGURATION_TYPES)
ENDMACRO()
########################################################################


#�����ǵ�ǰ���õ���DEBUG����RELEASE����Ӧ��DEBUG����RELEASE�Ŀ�
MACRO(LINK_WITH_VARIABLES TRGTNAME)
  FOREACH(varname ${ARGN})
    IF (WIN32)
      IF(${varname}_RELEASE)
        IF(${varname}_DEBUG)
          TARGET_LINK_LIBRARIES(${TRGTNAME} optimized "${${varname}_RELEASE}" debug "${${varname}_DEBUG}")
        ELSE(${varname}_DEBUG)
          TARGET_LINK_LIBRARIES(${TRGTNAME} optimized "${${varname}_RELEASE}" debug "${${varname}_RELEASE}" )
        ENDIF(${varname}_DEBUG)
      ELSE(${varname}_RELEASE)
        IF(${varname}_DEBUG)
          TARGET_LINK_LIBRARIES(${TRGTNAME} optimized "${${varname}}" debug "${${varname}_DEBUG}")
        ELSE(${varname}_DEBUG)
          TARGET_LINK_LIBRARIES(${TRGTNAME} optimized "${${varname}}" debug "${${varname}}" )
        ENDIF(${varname}_DEBUG)
      ENDIF(${varname}_RELEASE)
    ELSE (WIN32)
      IF(${varname}_RELEASE)
        TARGET_LINK_LIBRARIES(${TRGTNAME} "${${varname}_RELEASE}")
      ELSE(${varname}_RELEASE)
        TARGET_LINK_LIBRARIES(${TRGTNAME} "${${varname}}")
      ENDIF(${varname}_RELEASE)
    ENDIF (WIN32)
  ENDFOREACH(varname)
ENDMACRO(LINK_WITH_VARIABLES TRGTNAME)


#��lib����صİ�����������LIB_EXTERNAL_DEPS(�ⲿ�����⣩��LIB_INTERNAL_DEPS���������ڲ��⣩
#��Դ�ļ���صİ�����������LIB_PUBLIC_HEADERS��LIB_SOURCES
#����ɾ�̬����߶�̬����صı���LIBRARY_TYPE(Ĭ���Ƕ�̬�⣬��̬�����VSP_ADD_LIBRARY(${MyProjectName} STATIC))
MACRO(VSP_ADD_LIBRARY LIB_NAME)
  IF(NOT TARGET_NAME)
    SET(TARGET_NAME ${LIB_NAME})
  ENDIF(NOT TARGET_NAME)

  SET(LIBRARY_TYPE ${ARGV1})
  if (NOT LIBRARY_TYPE OR "${LIBRARY_TYPE}" STREQUAL "FRAMEWORK")
    SET(LIBRARY_TYPE SHARED)
  endif()

  #�����ļ����·��
    SET(CURRENT_ARCHIVE_PATH)
    SET(CURRENT_RUNTIME_PATH)
    SET(CURRENT_LIBRARY_PATH)
    SET_CURRENT_DIR()

  ADD_LIBRARY(${LIB_NAME} ${LIBRARY_TYPE}
    ${LIB_PUBLIC_HEADERS}
    ${LIB_SOURCES}
    )

  LINK_WITH_VARIABLES(${LIB_NAME} ${LIB_EXTERNAL_DEPS})
  TARGET_LINK_LIBRARIES(${LIB_NAME} ${LIB_INTERNAL_DEPS})  

  SET_PROJECTLABEL_AND_FOLDERGROUP(${MyCategory})

ENDMACRO(VSP_ADD_LIBRARY)


#��lib����صİ�����������LIB_EXTERNAL_DEPS(�ⲿ�����⣩��LIB_INTERNAL_DEPS���������ڲ��⣩
#��Դ�ļ���صİ���һ������TARGET_SRC
#����ɾ�̬����߶�̬����صı���LIBRARY_TYPE
MACRO(VSP_ADD_EXE execName)

  IF(NOT TARGET_NAME)
    SET(TARGET_NAME ${execName})
  ENDIF(NOT TARGET_NAME)

    #�����ļ����·�� ����� ${OUTPUT_LIBDIR}
    SET(CURRENT_ARCHIVE_PATH)
    SET(CURRENT_RUNTIME_PATH)
    SET(CURRENT_LIBRARY_PATH)
    SET_CURRENT_DIR()
  ADD_EXECUTABLE(${TARGET_NAME} ${TARGET_SRC})
  LINK_WITH_VARIABLES(${TARGET_NAME} ${LIB_EXTERNAL_DEPS})
  TARGET_LINK_LIBRARIES(${TARGET_NAME} ${LIB_INTERNAL_DEPS})

  SET_PROJECTLABEL_AND_FOLDERGROUP(${MyCategory})



ENDMACRO(VSP_ADD_EXE)


###########################################################################
#��lib����صİ�����������LIB_EXTERNAL_DEPS(�ⲿ�����⣩��LIB_INTERNAL_DEPS���������ڲ��⣩
#��Դ�ļ���صİ�����������LIB_PUBLIC_HEADERS��LIB_SOURCES
#����ɾ�̬����߶�̬����صı���LIBRARY_TYPE
MACRO (VSP_ADD_PLUGIN LIB_NAME)
  SET(LIBRARY_TYPE ${ARGV2})
  if (NOT LIBRARY_TYPE OR "${LIBRARY_TYPE}" STREQUAL "FRAMEWORK")
    SET(LIBRARY_TYPE SHARED)
  endif()

  IF(NOT TARGET_NAME)
    SET(TARGET_NAME ${LIB_NAME})
  ENDIF(NOT TARGET_NAME)

  #�������·�� ����� ${OUTPUT_LIBDIR}
  SET(CURRENT_ARCHIVE_PATH plugins)
  SET(CURRENT_RUNTIME_PATH plugins)
  SET(CURRENT_LIBRARY_PATH plugins)
  SET_CURRENT_DIR()
  
    
  ADD_LIBRARY(${TARGET_NAME} ${LIBRARY_TYPE}
    ${LIB_PUBLIC_HEADERS}
    ${LIB_SOURCES}
    )

  LINK_WITH_VARIABLES(${TARGET_NAME} ${LIB_EXTERNAL_DEPS})
  TARGET_LINK_LIBRARIES(${TARGET_NAME} ${LIB_INTERNAL_DEPS})

  LINK_WITH_VARIABLES(${TARGET_NAME} ${TARGET_COMMON_LIBRARIES})

 SET_PROJECTLABEL_AND_FOLDERGROUP(${MyCategory})
  
ENDMACRO(VSP_ADD_PLUGIN)
