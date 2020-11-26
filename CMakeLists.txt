cmake_minimum_required(VERSION 3.16)
project(orc_reader)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake_modules")

set(CMAKE_C_FLAGS, "${CMAKE_C_FLAGS}")   #c or use add_compile_options
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -O3 -Wall")  #c++ or use add_compile_options

include(FindORC)
add_subdirectory(c++/src)

file(COPY iris.orc DESTINATION . FOLLOW_SYMLINK_CHAIN)

add_executable(main_test c++/src/main.cpp)
add_executable(orc_reader c++/src/orc_read_test.cpp)
