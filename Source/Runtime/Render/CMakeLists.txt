file(GLOB BASERHI_HEADER_LIST "BaseRHI/Public/*.h")
file(GLOB BASERHI_SOURCE_LIST "BaseRHI/Private/*.c" "BaseRHI/Private/*.cpp" "BaseRHI/Private/*.m" "BaseRHI/Private/*.mm")
source_group(BaseRHI/Public FILES ${BASERHI_HEADER_LIST})
source_group(BaseRHI/Private FILES ${BASERHI_SOURCE_LIST})

file(GLOB OPENGLRHI_HEADER_LIST "OpenGLRHI/Public/*.h")
file(GLOB OPENGLRHI_SOURCE_LIST "OpenGLRHI/Private/*.c" "OpenGLRHI/Private/*.cpp" "OpenGLRHI/Private/*.m" "OpenGLRHI/Private/*.mm")
source_group(OpenGLRHI/Public FILES ${OPENGLRHI_HEADER_LIST})
source_group(OpenGLRHI/Private FILES ${OPENGLRHI_SOURCE_LIST})

file(GLOB METALRHI_HEADER_LIST "MetalRHI/Public/*.h")
file(GLOB METALRHI_SOURCE_LIST "MetalRHI/Private/*.c" "MetalRHI/Private/*.cpp" "MetalRHI/Private/*.m" "MetalRHI/Private/*.mm")
source_group(MetalRHI/Public FILES ${METALRHI_HEADER_LIST})
source_group(MetalRHI/Private FILES ${METALRHI_SOURCE_LIST})


add_library(Render STATIC
    ${BASERHI_HEADER_LIST}
    ${BASERHI_SOURCE_LIST}
    ${OPENGLRHI_HEADER_LIST}
    ${OPENGLRHI_SOURCE_LIST}
    ${METALRHI_HEADER_LIST}
    ${METALRHI_SOURCE_LIST}
)