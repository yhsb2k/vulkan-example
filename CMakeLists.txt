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

# Locate Vulkan SDK
if(DEFINED ENV{VULKAN_SDK})
    message(STATUS "Vulkan SDK: " $ENV{VULKAN_SDK})
    include_directories($ENV{VULKAN_SDK}/Include)
    link_directories($ENV{VULKAN_SDK}/Lib)
else()
    if(WIN32)
        file(GLOB VULKAN_SDK "C:/VulkanSDK/*")
        include_directories(${VULKAN_SDK}/Include)
        link_directories(${VULKAN_SDK}/Lib)
    else()
        file(GLOB VULKAN_SDK "~/vulkan/*")
        include_directories(${VULKAN_SDK}/x86_64/include)
        link_directories(${VULKAN_SDK}/x86_64/lib)
        # If Vulkan SDK was installed using .deb package:
        #include_directories(/usr/include)
        #link_directories(/usr/lib/x86_64-linux-gnu)
    endif()
    message(STATUS "Vulkan SDK: " ${VULKAN_SDK})
endif()

add_executable(${CMAKE_PROJECT_NAME} src/main.cpp)

target_link_options(${CMAKE_PROJECT_NAME} PRIVATE
    $<$<CXX_COMPILER_ID:GNU>:-static>
)

target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE
        glfw
        glm
        vulkan$<$<PLATFORM_ID:Windows>:-1>
)
