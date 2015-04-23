function(add_benchmark target)
  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}.cpp
    COMMAND printf "\"#define\\tTOUCHSTONE_CONFIG_MAIN\\n#include<touchstone/touchstone.h>\"" > ${CMAKE_CURRENT_BINARY_DIR}/${target}.cpp)
  add_executable(${target} ${CMAKE_CURRENT_BINARY_DIR}/${target}.cpp ${ARGN})
  if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(NATIVE_FLAG "-march=native")
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(NATIVE_FLAG "-march=native")
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
    set(NATIVE_FLAG "-xHost")
  endif()
  set_target_properties(${target} PROPERTIES COMPILE_FLAGS "-O3 ${NATIVE_FLAG}")
endfunction()
