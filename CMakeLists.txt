cmake_minimum_required(VERSION 3.2)

set(PROJECT_NAME SomeEngine)
project(${PROJECT_NAME} C CXX)

#find_package(glfw3 REQUIRED)
#find_package(OpenGL REQUIRED)

add_executable(${PROJECT_NAME} 
  src/main.cpp
  )

set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

add_subdirectory(external/glfw)

target_link_libraries(${PROJECT_NAME}
    glfw
)
