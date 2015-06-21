cmake_minimum_required(VERSION 3.0)

if(WIN32 AND NOT CYGWIN)                                                           
  set(DEF_INSTALL_CMAKE_DIR CMake)                                                 
else()                                                                             
  set(DEF_INSTALL_CMAKE_DIR lib/cmake/EchoExecutionContext)                        
endif()                                                                            
set(INSTALL_CMAKE_DIR ${DEF_INSTALL_CMAKE_DIR} CACHE PATH                          
  "Installation directory for CMake files")

file(GLOB cmake_modules
  RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Echo/*.cmake"
)

install(FILES ${cmake_modules} DESTINATION "${CMAKE_ROOT}/Modules/Echo")

install(FILES cmake/EchoConfig.cmake DESTINATION "${INSTALL_CMAKE_DIR}")
