
include(ExternalProject)
# ----------------------------------------------------------------------
# ORC
message("Building Apache ORC from source")

set(ORC_VERSION "1.6.5")

set(ORC_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/orc_ep-install")
set(ORC_STATIC_LIB "${ORC_PREFIX}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}orc${CMAKE_STATIC_LIBRARY_SUFFIX}")
set(ORC_INCLUDE_DIR "${ORC_PREFIX}/include")
set(THIRDPARTY_DIR "${CMAKE_BINARY_DIR}/orc_ep-prefix/src/orc_ep-build/c++/libs/thirdparty")

set(EP_CXX_FLAGS "${EP_CXX_FLAGS} ${CMAKE_CXX_FLAGS} -fPIC")
set(ORC_CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${ORC_PREFIX}
        -DCMAKE_CXX_FLAGS=${EP_CXX_FLAGS}
        -DSTOP_BUILD_ON_WARNING=OFF
        -DBUILD_LIBHDFSPP=OFF
        -DCMAKE_BUILD_TYPE=RELEASE
        -DBUILD_JAVA=OFF
        -DBUILD_TOOLS=OFF
        -DBUILD_CPP_TESTS=OFF
        -DINSTALL_VENDORED_LIBS=OFF)

ExternalProject_Add (orc_ep
        URL "https://github.com/apache/orc/archive/rel/release-${ORC_VERSION}.tar.gz"
        URL_HASH MD5=e4d8efa8c5d23983b1078746ed8899b0
        CMAKE_ARGS ${ORC_CMAKE_ARGS}
        )

#message("---------------------------include dir is ${ORC_PREFIX}/c++/src")
include_directories (SYSTEM ${ORC_INCLUDE_DIR})

link_directories(
        ${THIRDPARTY_DIR}/lz4_ep-install/lib
        ${THIRDPARTY_DIR}/protobuf_ep-install/lib
        ${THIRDPARTY_DIR}/snappy_ep-install/lib
        ${THIRDPARTY_DIR}/zlib_ep-install/lib
        ${THIRDPARTY_DIR}/zstd_ep-install/lib
)
link_libraries(
        orc
        lz4
        protobuf
        snappy
        zstd
        z   #zlib
)

add_library (orc STATIC IMPORTED)
set_target_properties (orc PROPERTIES IMPORTED_LOCATION ${ORC_STATIC_LIB})
add_dependencies (orc orc_ep)
#---------------------------------