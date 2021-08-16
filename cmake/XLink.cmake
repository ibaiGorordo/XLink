set(XLINK_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR}/../)

set(XLINK_INCLUDE ${XLINK_ROOT_DIR}/include)

set(XLINK_PRIVATE_INCLUDE ${XLINK_ROOT_DIR}/src/pc/protocols)

file(GLOB PC_SRC             "${XLINK_ROOT_DIR}/src/pc/*.c")
file(GLOB PC_SRC_CPP         "${XLINK_ROOT_DIR}/pc/*.cpp")
file(GLOB PC_PROTO_SRC       "${XLINK_ROOT_DIR}/src/pc/protocols/*.c")
file(GLOB PC_PROTO_SRC_CPP   "${XLINK_ROOT_DIR}/src/pc/protocols/*.cpp")
file(GLOB_RECURSE SHARED_SRC "${XLINK_ROOT_DIR}/src/shared/*.c")

list(APPEND XLINK_SOURCES ${PC_SRC} ${PC_SRC_CPP} ${PC_PROTO_SRC} ${PC_PROTO_SRC_CPP} ${SHARED_SRC})

if(WIN32)
    set(XLINK_PLATFORM_INCLUDE ${XLINK_ROOT_DIR}/src/pc/Win/include)

    file(GLOB XLINK_PLATFORM_SRC "${XLINK_ROOT_DIR}/src/pc/Win/src/*.c")
    list(APPEND XLINK_SOURCES ${XLINK_PLATFORM_SRC})
else()
    find_package(Threads REQUIRED)
endif()


find_path(LIBUSB_INCLUDE_DIR NAMES libusb.h PATH_SUFFIXES "include" "libusb" "libusb-1.0")
find_library(LIBUSB_LIBRARY NAMES usb-1.0 PATH_SUFFIXES "lib")

if(NOT LIBUSB_INCLUDE_DIR OR NOT LIBUSB_LIBRARY)
    message(FATAL_ERROR "libusb is required")
endif()

if(APPLE)
    set(XLINK_PLATFORM_INCLUDE "${XLINK_ROOT_DIR}/src/pc/MacOS" )
    list(APPEND XLINK_SOURCES "${XLINK_ROOT_DIR}/src/pc/MacOS/pthread_semaphore.c")
endif()

#This is for the Movidius team
set(XLINK_INCLUDE_DIRECTORIES ${XLINK_INCLUDE} ${LIBUSB_INCLUDE_DIR})
