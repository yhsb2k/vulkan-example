cmake_minimum_required(VERSION 3.5)

get_filename_component(CURRENT_DIRNAME "${CMAKE_CURRENT_LIST_DIR}" NAME)
project(${CURRENT_DIRNAME} C CXX ASM)

# For vscode intellisense
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_STANDARD 17)
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Debug)
endif()

set(GLFW_BUILD_DOCS OFF CACHE BOOL "")
set(GLFW_INSTALL OFF CACHE BOOL "")
add_subdirectory(src/third_party/glfw)
add_subdirectory(src/third_party/glm)

include_directories(src)

add_executable(${CMAKE_PROJECT_NAME} src/main.cpp)

# Locate Vulkan SDK
if (WIN32)
    file(GLOB VULKAN_SDK "C:/VulkanSDK/*")
    if("${VULKAN_SDK}" STREQUAL "")
        message(FATAL_ERROR "Vulkan SDK not found. See https://vulkan.lunarg.com/sdk/home")
    endif()
    target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${VULKAN_SDK}/Include)
    link_directories(${VULKAN_SDK}/Lib)
endif()
# On linux systems:
# Vulkan SDK headers located in /usr/include
# Vulkan SDK libraries located in /usr/lib/x86_64-linux-gnu

set(VULKAN_LIBS vulkan$<$<PLATFORM_ID:Windows>:-1>)

target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE
        glfw
        glm
        ${VULKAN_LIBS}
)
