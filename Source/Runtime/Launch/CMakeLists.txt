FILE(GLOB HEADER_LIST "Public/*.h")
FILE(GLOB SOURCE_LIST "Private/*.c" "Private/*.cpp" "Private/*.m" "Private/*.mm")

INCLUDE_DIRECTORIES("/opt/local/include")
SOURCE_GROUP(Public FILES ${HEADER_LIST})
SOURCE_GROUP(Private FILES ${SOURCE_LIST})

ADD_LIBRARY(Launch STATIC ${HEADER_LIST} ${SOURCE_LIST})