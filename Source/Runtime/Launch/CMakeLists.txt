file(GLOB HEADER_LIST "Public/*.h")
file(GLOB SOURCE_LIST "Private/*.c" "Private/*.cpp" "Private/*.m" "Private/*.mm")

INCLUDE_DIRECTORIES("/opt/local/include")
source_group(Public FILES ${HEADER_LIST})
source_group(Private FILES ${SOURCE_LIST})


add_executable(Launch MACOSX_BUNDLE ${SOURCE_LIST} ${HEADER_LIST} ${RESOURCE_LIST})
set_target_properties(Launch PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${PROJECT_SOURCE_DIR}/../Resources/Info.plist)

target_link_libraries(Launch Core)
target_link_libraries(Launch Common)
target_link_libraries(Launch Asset)
target_link_libraries(Launch Platform)
target_link_libraries(Launch EditorApp)
target_link_libraries(Launch Render)

IF(${WIN32})
target_link_libraries(Launch glad)
ENDIF(${WIN32})