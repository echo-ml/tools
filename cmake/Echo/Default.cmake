set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} \
      -Weverything \
      -Wno-c++98-compat \
      -Wno-c++98-compat-pedantic \
      -Wno-newline-eof \
      -Wno-unused-parameter \
      -Wno-exit-time-destructors \
      -Wno-padded \
      -Wno-float-equal \
      -Wno-gnu-zero-variadic-macro-arguments \
      -Wno-sign-conversion \
      -Wno-missing-braces \
      -Wno-missing-prototypes \
      -Wno-sign-compare \
      -Wno-weak-vtables \
      -Wno-macro-redefined \
      -Wno-switch-enum \
      -Wno-global-constructors \
      -Wno-source-uses-openmp")
endif()

include_directories(${CMAKE_SOURCE_DIR}/include)
