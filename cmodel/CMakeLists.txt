cmake_minimum_required(VERSION 3.5)
project(conv.algo)

include_directories(./inc)

if(MSVC)
  add_compile_options(/D "_CRT_SECURE_NO_WARNINGS")
  add_compile_options(/DEBUG)
  add_compile_options(/W4 /openmp)
  add_link_options(/STACK:"33554432" /openmp)
else()
  add_compile_options(-g)
  add_compile_options(-Wall -Wextra -fopenmp)
  add_link_options(-fopenmp)
endif()


aux_source_directory(./src SRC_LIST)
aux_source_directory(./main MAIN_LIST)
aux_source_directory(./test TEST_LIST)

add_executable(conv ${SRC_LIST} ${MAIN_LIST})

foreach(test ${TEST_LIST})
  get_filename_component(test_name ${test} NAME_WLE)
  message(STATUS "test: ${test}")
  add_executable(${test_name} ${test} ${SRC_LIST})
endforeach(test )

