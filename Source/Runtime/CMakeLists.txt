add_subdirectory(Core)
add_subdirectory(Platform)
add_subdirectory(Launch)
add_subdirectory(Render)

SET_PROPERTY(TARGET Core PROPERTY FOLDER "Runtime")
SET_PROPERTY(TARGET Platform PROPERTY FOLDER "Runtime")
SET_PROPERTY(TARGET Launch PROPERTY FOLDER "Runtime")
SET_PROPERTY(TARGET Render PROPERTY FOLDER "Runtime")