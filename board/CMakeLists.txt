cmake_minimum_required(VERSION 3.0)
project(comm.slave)

include_directories(./common)
include_directories(./algo/inc)

add_subdirectory(./algo)

if(MSVC)
  add_compile_options(/D "_CRT_SECURE_NO_WARNINGS" /DEBUG /W4 -openmp:llvm)
  add_link_options(/STACK:"33554432")
else()
  add_compile_options(-g -Wall -Wextra)
endif()

aux_source_directory(./common SRC_COMMON)
aux_source_directory(./sim SRC_SIM)

add_executable(sim ${SRC_COMMON} ${SRC_SIM})
target_link_libraries(sim conv_lib)
