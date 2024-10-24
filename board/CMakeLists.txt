cmake_minimum_required(VERSION 3.0)
project(comm.slave.sim)

include_directories(./common)

add_compile_options(-Wall -Wextra)

aux_source_directory(./common SRC_COMMON)
aux_source_directory(./sim SRC_SIM)

add_executable(sim ${SRC_COMMON} ${SRC_SIM})
