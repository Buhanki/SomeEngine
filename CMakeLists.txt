cmake_minimum_required(VERSION 3.2)

set(PROJECT_NAME SomeEngine)
project(${PROJECT_NAME} C CXX)

find_package(glfw3 REQUIRED)
find_package(OpenGL REQUIRED)

add_executable(Myexe
  src/main.cpp
  )

target_link_libraries(Myexe
    glfw
    OpenGL::GL 
)
