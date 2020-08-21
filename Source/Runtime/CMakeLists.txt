add_subdirectory(Core)
add_subdirectory(Platform)
add_subdirectory(Launch)

SET_PROPERTY(TARGET Core PROPERTY FOLDER "Runtime")
SET_PROPERTY(TARGET Platform PROPERTY FOLDER "Runtime")
SET_PROPERTY(TARGET Launch PROPERTY FOLDER "Runtime")