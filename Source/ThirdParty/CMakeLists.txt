IF(${WIN32})
add_subdirectory(glad)

SET_PROPERTY(TARGET glad PROPERTY FOLDER "ThirdParty")
ENDIF(${WIN32})