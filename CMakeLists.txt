cmake_minimum_required(VERSION 3.10)

# Compiler defs
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_CXX_COMPILE_FLAGS 
    ${CMAKE_CXX_COMPILE_FLAGS} 
    "-pedantic"
    "-Wall"
    "-Wextra"
    )


# set the project name
project(st-mfem)


# CUDA
include(CheckLanguage)
check_language(CUDA)
if(DEFINED CMAKE_CUDA_COMPILER AND NOT ${CMAKE_CUDA_COMPILER} MATCHES "NOTFOUND")
    set(CMAKE_CUDA_HOST_COMPILER ${CMAKE_CXX_COMPILER})
    enable_language(CUDA)
    set(CMAKE_CUDA_STANDARD 14)
    set(CMAKE_CUDA_STANDARD_REQUIRED ON)
    set(CMAKE_CUDA_ARCHITECTURES "70")
    set(CMAKE_CUDA_FLAGS "--expt-extended-lambda")
endif()


# CMake modules
message(${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/config/cmake/modules)

find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)
find_package(MPI REQUIRED)
find_package(ZLIB REQUIRED)
find_package(SUITESPARSE REQUIRED)
find_package(METIS REQUIRED)
find_package(HYPRE REQUIRED)
find_package(MFEM REQUIRED)

function(add_mfem_executable executable_name source_file)


# add the executable
add_executable(${executable_name} ${source_file})

target_compile_options(${executable_name}
    PRIVATE ${LAPACK_LINKER_FLAGS}
    PRIVATE ${BLAS_LINKER_FLAGS}
    PRIVATE ${MPI_LINK_FLAGS}
    )

target_link_libraries(${executable_name}
    PRIVATE MFEM::MFEM
    PRIVATE SUITESPARSE::SUITESPARSE
    PRIVATE SUITESPARSE::UMFPACK
    PRIVATE SUITESPARSE::KLU
    PRIVATE METIS::METIS
    PRIVATE HYPRE::HYPRE
    PRIVATE ${LAPACK_LIBRARIES}
    PRIVATE ${BLAS_LIBRARIES}
    PRIVATE ${MPI_C_LIBRARIES}
    PRIVATE ZLIB::ZLIB
    )

target_include_directories(${executable_name}
    PRIVATE ${MPI_C_INCLUDE_DIRS}
    )

if(DEFINED CMAKE_CUDA_COMPILER AND NOT ${CMAKE_CUDA_COMPILER} MATCHES "NOTFOUND")
    set_source_files_properties(${source_file} PROPERTIES LANGUAGE CUDA)
    target_link_libraries(${executable_name}
        PRIVATE cuda
        PRIVATE cusparse
        )
endif()

install(TARGETS ${executable_name}
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    )

endfunction()
add_subdirectory(examples)
