file(GLOB HEADER_LIST "include/*.h" "include/glad/*.h" "include/KHR/*.h")
file(GLOB SOURCE_LIST "src/*.c" "src/*.cpp" "src/*.m" "src/*.mm")

ASSIGN_SOURCE_GROUP(${HEADER_LIST})
ASSIGN_SOURCE_GROUP(${SOURCE_LIST})

ADD_LIBRARY(glad STATIC ${SOURCE_LIST} ${HEADER_LIST})
