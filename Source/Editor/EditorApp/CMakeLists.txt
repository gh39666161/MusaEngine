file(GLOB MAC_HEADER_LIST "Mac/Public/*.h")
file(GLOB MAC_SOURCE_LIST "Mac/Private/*.c" "Mac/Private/*.cpp" "Mac/Private/*.m" "Mac/Private/*.mm")
source_group(Mac/Public FILES ${MAC_HEADER_LIST})
source_group(Mac/Private FILES ${MAC_SOURCE_LIST})




add_library(EditorApp STATIC ${MAC_SOURCE_LIST} ${MAC_HEADER_LIST})

target_link_libraries(EditorApp "-framework Cocoa")
target_link_libraries(EditorApp "-framework OpenGL")
target_link_libraries(EditorApp "-framework Metal")
target_link_libraries(EditorApp "-framework MetalKit")