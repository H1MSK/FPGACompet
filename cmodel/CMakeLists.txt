cmake_minimum_required(VERSION 3.0)
project(conv.algo)

include_directories(./inc)

add_compile_options(-Wall -Wextra)

aux_source_directory(./src SRC_LIST)

add_executable(conv ${SRC_LIST})