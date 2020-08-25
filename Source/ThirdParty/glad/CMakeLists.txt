file(GLOB HEADER_LIST "include/*.h" "include/glad/*.h" "include/KHR/*.h")
file(GLOB SOURCE_LIST "src/*.c" "src/*.cpp" "src/*.m" "src/*.mm")

assign_source_group(${HEADER_LIST})
assign_source_group(${SOURCE_LIST})

add_library(glad STATIC ${SOURCE_LIST} ${HEADER_LIST})
