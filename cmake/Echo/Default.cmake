set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

if ("$CMAKE_CXX_COMPILER_ID" STREQUAL "Clang")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Weverything")
endif()

include_directories(${CMAKE_SOURCE_DIR}/include)
