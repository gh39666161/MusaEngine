file(GLOB HEADER_LIST "Public/*.h")
file(GLOB SOURCE_LIST "Private/*.c" "Private/*.cpp" "Private/*.m" "Private/*.mm")
source_group(Public FILES ${HEADER_LIST})
source_group(Private FILES ${SOURCE_LIST})

add_library(Common STATIC ${SOURCE_LIST} ${HEADER_LIST})