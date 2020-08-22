cmake_minimum_required(VERSION 3.1)
set (CMAKE_C_STANDARD 11)
set (CMAKE_CXX_STANDARD 11)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
project(MusaEngine)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../Bin)       #设置可执行文件的输出目录
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../Bin)           #设置库文件的输出目录
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/Bin)   
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/../Bin) 
#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/../Bin)    
#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/../Bin)

function(assign_source_group)
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
endfunction(assign_source_group)

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/Runtime")
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/Editor")
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty")

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/glad/include")

add_subdirectory(Runtime)
add_subdirectory(Editor)
add_subdirectory(ThirdParty)