cmake_minimum_required(VERSION 3.0)
project(conv.algo)

include_directories(./inc)

add_compile_options(-g)

if(MSVC)
  add_compile_options(/Wall /openmp)
else()
  add_compile_options(-Wall -Wextra -fopenmp)
endif()

add_link_options(-fopenmp)

aux_source_directory(./src SRC_LIST)
aux_source_directory(./main MAIN_LIST)
aux_source_directory(./test TEST_LIST)

add_executable(conv ${SRC_LIST} ${MAIN_LIST})

foreach(test ${TEST_LIST})
  get_filename_component(test_name ${test} NAME_WLE)
  message(STATUS "test: ${test}")
  add_executable(${test_name} ${test} ${SRC_LIST})
endforeach(test )

