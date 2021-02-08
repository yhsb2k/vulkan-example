cmake_minimum_required(VERSION 3.5)

get_filename_component(CURRENT_DIRNAME "${CMAKE_CURRENT_LIST_DIR}" NAME)
project(${CURRENT_DIRNAME} C CXX ASM)

# For vscode intellisense
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_STANDARD 17)
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Debug)
endif()

include_directories(src)

file(GLOB VulkanSDK "C:/VulkanSDK/*")
if("${VulkanSDK}" STREQUAL "")
    message(FATAL_ERROR "Can't find VulkanSDK directory. See https://vulkan.lunarg.com/sdk/home")
endif()
include_directories(${VulkanSDK}/Include)
link_directories(${VulkanSDK}/Lib)

add_executable(${CMAKE_PROJECT_NAME} src/main.cpp)

target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE
        vulkan-1
)
