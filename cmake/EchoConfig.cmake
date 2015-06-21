function(ECHO_ADD_TEST TARGET) 
  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp
    COMMAND printf "\"#define\\tCATCH_CONFIG_MAIN\\n#include<catch.hpp>\"" 
      > ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp)
  add_executable(${TARGET} ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp ${ARGN})
  add_test(${TARGET} ${CMAKE_CURRENT_BINARY_DIR}/${TARGET})
endfunction()

function(ECHO_ADD_DEFAULT_TEST)
  file(GLOB_RECURSE TESTS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
      ${CMAKE_CURRENT_SOURCE_DIR}/unittest/*.cpp)
    ECHO_ADD_TEST(t ${TESTS})
endfunction()

function(ECHO_ADD_BENCHMARK TARGET)
  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp
    COMMAND printf "\"#define\\tTOUCHSTONE_CONFIG_MAIN\\n\
#include<touchstone/touchstone.h>\""
    > ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp)
  add_executable(${TARGET} ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp ${ARGN})
  if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")                                 
    set(NATIVE_FLAG "-march=native")                                               
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")                               
    set(NATIVE_FLAG "-march=native")                                               
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")                             
    set(NATIVE_FLAG "-xHost")                                                      
  endif()                                                                          
  set_TARGET_properties(${TARGET} PROPERTIES COMPILE_FLAGS "-O3 ${NATIVE_FLAG}")
endfunction()

function(ECHO_ADD_DEFAULT_BENCHMARK)
  file(GLOB_RECURSE BENCHMARKS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
      ${CMAKE_CURRENT_SOURCE_DIR}/benchmark/*.cpp)
    ECHO_ADD_BENCHMARK(b ${BENCHMARKS})
endfunction()

function(ECHO_INSTALL_DEFAULT_HEADERS)
  install(DIRECTORY include/echo/ DESTINATION include/echo)
endfunction()
