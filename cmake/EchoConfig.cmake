option(ECHO_BUILD_TESTS "controls whether or not to build tests" ON)
option(ECHO_BUILD_BENCHMARKS "controls whether or not to build benchmarks" ON)

set(ECHO_DEFAULT_TEST_TARGET t)
set(ECHO_DEFAULT_BENCHMARK_TARGET b)

#################
# ECHO_ADD_TEST #
#################
function(ECHO_ADD_TEST TARGET) 
  if(ECHO_BUILD_TESTS)
    add_custom_command(
      OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp
      COMMAND printf "\"#define\\tCATCH_CONFIG_MAIN\\n#include<catch.hpp>\"" 
      > ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp)
    add_executable(${TARGET} EXCLUDE_FROM_ALL 
        ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp ${ARGN})
    add_test(${TARGET} ${CMAKE_CURRENT_BINARY_DIR}/${TARGET})
  endif()
endfunction()

#########################
# ECHO_ADD_DEFAULT_TEST #
#########################
function(ECHO_ADD_DEFAULT_TEST)
  file(GLOB_RECURSE TESTS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/unittest/*.cpp)
  ECHO_ADD_TEST(${ECHO_DEFAULT_TEST_TARGET} ${TESTS})
endfunction()

######################
# ECHO_ADD_BENCHMARK #
######################
function(ECHO_ADD_BENCHMARK TARGET)
  if(ECHO_BUILD_BENCHMARKS)
    add_custom_command(
      OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp
      COMMAND printf "\"#define\\tTOUCHSTONE_CONFIG_MAIN\\n\
#include<touchstone/touchstone.h>\""
      > ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp)
    add_executable(${TARGET} EXCLUDE_FROM_ALL 
        ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.cpp ${ARGN})
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")                                 
      set(NATIVE_FLAG "-march=native")                                               
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")                               
      set(NATIVE_FLAG "-march=native")                                               
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")                             
      set(NATIVE_FLAG "-xHost")                                                      
    endif()                                                                          
    set_TARGET_properties(${TARGET} 
        PROPERTIES COMPILE_FLAGS "-O3 -DNDEBUG ${NATIVE_FLAG}")
  endif()
endfunction()

##############################
# ECHO_ADD_DEFAULT_BENCHMARK #
##############################
function(ECHO_ADD_DEFAULT_BENCHMARK)
  file(GLOB_RECURSE BENCHMARKS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
      ${CMAKE_CURRENT_SOURCE_DIR}/benchmark/*.cpp)
    ECHO_ADD_BENCHMARK(${ECHO_DEFAULT_BENCHMARK_TARGET} ${BENCHMARKS})
endfunction()

################################
# ECHO_INSTALL_DETAULT_HEADERS #
################################
function(ECHO_INSTALL_DEFAULT_HEADERS)
  install(DIRECTORY include/echo/ DESTINATION include/echo
    FILES_MATCHING PATTERN "*.h")
endfunction()

##############################
# ECHO_TARGET_LINK_LIBRARIES #
##############################
function(ECHO_TARGET_LINK_LIBRARIES)
  if(ECHO_BUILD_TESTS)
    target_link_libraries(${ECHO_DEFAULT_TEST_TARGET} ${ARGN})
  endif()
  if(ECHO_BUILD_BENCHMARKS)
    target_link_libraries(${ECHO_DEFAULT_BENCHMARK_TARGET} ${ARGN})
  endif()
endfunction()
