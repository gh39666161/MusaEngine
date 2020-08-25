file(GLOB_RECURSE HEADER_LIST "*.h")
file(GLOB_RECURSE SOURCE_LIST "*.c" "*.cpp" "*.m" "*.mm")

assign_source_group(${HEADER_LIST})
assign_source_group(${SOURCE_LIST})

add_definitions(
    -DUSE_OPENGL_RENDER
)

add_library(Render STATIC
    ${HEADER_LIST}
    ${SOURCE_LIST}
)