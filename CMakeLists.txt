cmake_minimum_required(VERSION 3.0.0)

project(libexecinfo C)

add_library(execinfo_a STATIC execinfo.c stacktraverse.c)
add_library(execinfo   SHARED execinfo.c stacktraverse.c)

include(GNUInstallDirs)

install(TARGETS execinfo LIBRARY                      DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(FILES   ${PROJECT_BINARY_DIR}/libexecinfo_a.a DESTINATION ${CMAKE_INSTALL_LIBDIR} RENAME libexecinfo.a)
install(FILES   ${PROJECT_SOURCE_DIR}/execinfo.h      DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(FILES   ${PROJECT_SOURCE_DIR}/stacktraverse.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
