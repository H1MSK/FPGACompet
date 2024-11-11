cmake_minimum_required(VERSION 3.0)
project(comm.slave)

include_directories(./common)

add_subdirectory(./algo)

aux_source_directory(./common SRC_COMMON)
aux_source_directory(./sim SRC_SIM)

add_executable(sim ${SRC_COMMON} ${SRC_SIM})
target_link_libraries(sim conv_lib)
