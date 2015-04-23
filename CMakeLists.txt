cmake_minimum_required(VERSION 3.0)

file(GLOB cmake_modules
  RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Echo/*.cmake"
)

install(FILES ${cmake_modules} DESTINATION "${CMAKE_ROOT}/Modules/Echo")
