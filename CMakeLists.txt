cmake_minimum_required(VERSION 3.13)

get_filename_component(CURRENT_DIRNAME "${CMAKE_CURRENT_LIST_DIR}" NAME)
project(${CURRENT_DIRNAME} C CXX)

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

# VULKAN_SDK environment variable is used to locate Vulkan SDK
find_package(Vulkan)
if(NOT Vulkan_FOUND)
    message(FATAL_ERROR "Vulkan SDK not found. See https://vulkan.lunarg.com/sdk/home")
endif()

add_executable(${CMAKE_PROJECT_NAME} src/main.cpp)

target_link_options(${CMAKE_PROJECT_NAME} PRIVATE
    $<$<CXX_COMPILER_ID:GNU>:-static-libgcc>
    $<$<CXX_COMPILER_ID:GNU>:-static-libstdc++>
    $<$<CXX_COMPILER_ID:GNU>:$<$<PLATFORM_ID:Windows>:-static>>
)

target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE
        glfw
        glm
        Vulkan::Vulkan
)
