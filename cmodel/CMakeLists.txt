cmake_minimum_required(VERSION 3.5)
project(conv.algo)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(./inc)

if(MSVC)
  add_compile_options(/D "_CRT_SECURE_NO_WARNINGS" /DEBUG /W4)
  add_link_options(/STACK:"33554432")
else()
  add_compile_options(-g -Wall -Wextra)
endif()

find_package(OpenMP REQUIRED)

aux_source_directory(./src SRC_LIST)
aux_source_directory(./main MAIN_LIST)
aux_source_directory(./test TEST_LIST)

add_library(conv_lib ${SRC_LIST})
target_link_libraries(conv_lib PUBLIC OpenMP::OpenMP_CXX)

add_executable(conv ${MAIN_LIST})
target_link_libraries(conv PUBLIC conv_lib)

foreach(test ${TEST_LIST})
  get_filename_component(test_name ${test} NAME_WLE)
  message(STATUS "test: ${test}")
  add_executable(${test_name} ${test})
  target_link_libraries(${test_name} PUBLIC conv_lib)
endforeach(test )

