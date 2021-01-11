cmake_minimum_required(VERSION 3.1)
SET(CMAKE_C_STANDARD 11)
SET(CMAKE_CXX_STANDARD 11)
SET_PROPERTY(GLOBAL PROPERTY USE_FOLDERS ON)
PROJECT(MusaEngine)
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../Bin)       #设置可执行文件的输出目录
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../Bin)           #设置库文件的输出目录
#SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/Bin)   
#SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/../Bin) 
#SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/../Bin)    
#SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/../Bin)

function(ASSIGN_SOURCE_GROUP)
    foreach(_source IN ITEMS ${ARGN})
        if (IS_ABSOLUTE "${_source}")
            file(RELATIVE_PATH _source_rel "${CMAKE_CURRENT_SOURCE_DIR}" "${_source}")
        else()
            set(_source_rel "${_source}")
        endif()
        get_filename_component(_source_path "${_source_rel}" PATH)
        string(REPLACE "/" "\\" _source_path_repl "${_source_path}")
        source_group("${_source_path_repl}" FILES "${_source}")
    endforeach()
endfunction(ASSIGN_SOURCE_GROUP)

INCLUDE_DIRECTORIES("${CMAKE_CURRENT_SOURCE_DIR}/Engine")
INCLUDE_DIRECTORIES("${CMAKE_CURRENT_SOURCE_DIR}/Editor")
INCLUDE_DIRECTORIES("${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty")

INCLUDE_DIRECTORIES("${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/glad/include")

ADD_SUBDIRECTORY(Engine)
ADD_SUBDIRECTORY(Editor)
ADD_SUBDIRECTORY(ThirdParty)