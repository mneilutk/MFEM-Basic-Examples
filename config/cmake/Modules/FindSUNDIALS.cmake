#[=======================================================================[.rst:
FindSUNDIALS
-------

Finds the SUNDIALS library.

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``SUNDIALS_FOUND``
  True if the system has the SUNDIALS library.
``SUNDIALS_INCLUDE_DIRS``
  Include directories needed to use SUNDIALS.
``SUNDIALS_LIBRARIES``
  Libraries needed to link to SUNDIALS.
#]=======================================================================]

find_package(SUNDIALS QUIET NO_MODULE)
if(SUNDIALS_FOUND)
    message("SUNDIALS ${SUNDIALS_FIND_VERSION} found.")
    if(SUNDIALS_FIND_COMPONENTS)
        message("SUNDIALS components found:")
        message("${SUNDIALS_FIND_COMPONENTS}")
    endif()
    return()
endif()

set(SUNDIALS_FOUND TRUE)

## Find headers and libraries
find_path(SUNDIALS_CONFIG_INCLUDE_DIR sundials/sundials_config.h)
if(NOT SUNDIALS_CONFIG_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

find_library(SUNDIALS_NVECTOR_SERIAL_LIBRARY sundials_nvecserial)
find_path(SUNDIALS_NVECTOR_SERIAL_INCLUDE_DIR nvector/nvector_serial.h)
if(NOT SUNDIALS_NVECTOR_SERIAL_LIBRARY OR NOT SUNDIALS_NVECTOR_SERIAL_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

find_library(SUNDIALS_NVECTOR_PARHYP_LIBRARY sundials_nvecparhyp)
find_path(SUNDIALS_NVECTOR_PARHYP_INCLUDE_DIR nvector/nvector_parhyp.h)
if(NOT SUNDIALS_NVECTOR_PARHYP_LIBRARY OR NOT SUNDIALS_NVECTOR_PARHYP_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

find_library(SUNDIALS_NVECTOR_PARALLEL_LIBRARY sundials_nvecparallel)
find_path(SUNDIALS_NVECTOR_PARALLEL_INCLUDE_DIR nvector/nvector_parallel.h)
if(NOT SUNDIALS_NVECTOR_PARALLEL_LIBRARY OR NOT SUNDIALS_NVECTOR_PARALLEL_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

find_library(SUNDIALS_NVECTOR_MPIPLUSX_LIBRARY sundials_nvecmpiplusx)
find_path(SUNDIALS_NVECTOR_MPIPLUSX_INCLUDE_DIR nvector/nvector_mpiplusx.h)
if(NOT SUNDIALS_NVECTOR_MPIPLUSX_LIBRARY OR NOT SUNDIALS_NVECTOR_MPIPLUSX_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

find_library(SUNDIALS_CVODE_LIBRARY sundials_cvode)
find_path(SUNDIALS_CVODE_INCLUDE_DIR cvode/cvode.h)
if(NOT SUNDIALS_CVODE_LIBRARY OR NOT SUNDIALS_CVODE_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

find_library(SUNDIALS_CVODES_LIBRARY sundials_cvodes)
find_path(SUNDIALS_CVODES_INCLUDE_DIR cvodes/cvodes.h)
if(NOT SUNDIALS_CVODES_LIBRARY OR NOT SUNDIALS_CVODES_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

find_library(SUNDIALS_ARKODE_LIBRARY sundials_arkode)
find_path(SUNDIALS_ARKODE_INCLUDE_DIR arkode/arkode.h)
if(NOT SUNDIALS_ARKODE_LIBRARY OR NOT SUNDIALS_ARKODE_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

find_library(SUNDIALS_KINSOL_LIBRARY sundials_kinsol)
find_path(SUNDIALS_KINSOL_INCLUDE_DIR kinsol/kinsol.h)
if(NOT SUNDIALS_KINSOL_LIBRARY OR NOT SUNDIALS_KINSOL_INCLUDE_DIR)
    set(SUNDIALS_FOUND FALSE)
endif()

if(DEFINED CMAKE_CUDA_COMPILER AND NOT ${CMAKE_CUDA_COMPILER} MATCHES "NOTFOUND")
    find_library(SUNDIALS_NVECTOR_CUDA_LIBRARY sundials_nveccuda)
    find_path(SUNDIALS_NVECTOR_CUDA_INCLUDE_DIR nvector/nvector_cuda.h)
    if(NOT SUNDIALS_NVECTOR_CUDA_LIBRARY OR NOT SUNDIALS_NVECTOR_CUDA_INCLUDE_DIR)
        set(SUNDIALS_FOUND FALSE)
    endif()
endif()

list(APPEND SUNDIALS_LIBRARIES
    ${SUNDIALS_NVECTOR_SERIAL_LIBRARY}
    ${SUNDIALS_NVECTOR_PARHYP_LIBRARY}
    ${SUNDIALS_NVECTOR_PARALLEL_LIBRARY}
    ${SUNDIALS_NVECTOR_MPIPLUSX_LIBRARY}
    ${SUNDIALS_CVODE_LIBRARY}
    ${SUNDIALS_CVODES_LIBRARY}
    ${SUNDIALS_ARKODE_LIBRARY}
    ${SUNDIALS_KINSOL_LIBRARY}
    )

list(APPEND SUNDIALS_INCLUDE_DIRS
    ${SUNDIALS_CONFIG_INCLUDE_DIR}
    ${SUNDIALS_NVECTOR_SERIAL_INCLUDE_DIR}
    ${SUNDIALS_NVECTOR_PARHYP_INCLUDE_DIR}
    ${SUNDIALS_NVECTOR_PARALLEL_INCLUDE_DIR}
    ${SUNDIALS_NVECTOR_MPIPLUSX_INCLUDE_DIR}
    ${SUNDIALS_CVODE_INCLUDE_DIR}
    ${SUNDIALS_CVODES_INCLUDE_DIR}
    ${SUNDIALS_ARKODE_INCLUDE_DIR}
    ${SUNDIALS_KINSOL_INCLUDE_DIR}
    ${SUNDIALS_NVECTOR_CUDA_INCLUDE_DIR}
    )

if(DEFINED CMAKE_CUDA_COMPILER AND NOT ${CMAKE_CUDA_COMPILER} MATCHES "NOTFOUND")
    list(APPEND SUNDIALS_LIBRARIES
        ${SUNDIALS_NVECTOR_CUDA_LIBRARY}
        )
    list(APPEND SUNDIALS_INCLUDE_DIRS
        ${SUNDIALS_NVECTOR_CUDA_INCLUDE_DIR}
        )
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SUNDIALS DEFAULT_MSG
                                  SUNDIALS_FOUND
                                  SUNDIALS_LIBRARIES
                                  SUNDIALS_INCLUDE_DIRS)

if (SUNDIALS_FOUND)
    add_library(SUNDIALS::nvecserial UNKNOWN IMPORTED)
    set_target_properties(SUNDIALS::nvecserial PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_NVECTOR_SERIAL_INCLUDE_DIR}"
        IMPORTED_LOCATION ${SUNDIALS_NVECTOR_SERIAL_LIBRARY})
    add_library(SUNDIALS::nvecparhyp UNKNOWN IMPORTED)
    set_target_properties(SUNDIALS::nvecparhyp PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_NVECTOR_PARHYP_INCLUDE_DIR}"
        IMPORTED_LOCATION ${SUNDIALS_NVECTOR_PARHYP_LIBRARY})
    add_library(SUNDIALS::nvecparallel UNKNOWN IMPORTED)
    set_target_properties(SUNDIALS::nvecparallel PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_NVECTOR_PARALLEL_INCLUDE_DIR}"
        IMPORTED_LOCATION ${SUNDIALS_NVECTOR_PARALLEL_LIBRARY})
    add_library(SUNDIALS::nvecmpiplusx UNKNOWN IMPORTED)
    set_target_properties(SUNDIALS::nvecmpiplusx PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_NVECTOR_MPIPLUSX_INCLUDE_DIR}"
        IMPORTED_LOCATION ${SUNDIALS_NVECTOR_MPIPLUSX_LIBRARY})
    add_library(SUNDIALS::cvode UNKNOWN IMPORTED)
    set_target_properties(SUNDIALS::cvode PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_CVODE_INCLUDE_DIR}"
        IMPORTED_LOCATION ${SUNDIALS_CVODE_LIBRARY})
    add_library(SUNDIALS::cvodes UNKNOWN IMPORTED)
    set_target_properties(SUNDIALS::cvodes PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_CVODES_INCLUDE_DIR}"
        IMPORTED_LOCATION ${SUNDIALS_CVODES_LIBRARY})
    add_library(SUNDIALS::arkode UNKNOWN IMPORTED)
    set_target_properties(SUNDIALS::arkode PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_ARKODE_INCLUDE_DIR}"
        IMPORTED_LOCATION ${SUNDIALS_ARKODE_LIBRARY})
    add_library(SUNDIALS::kinsol UNKNOWN IMPORTED)
    set_target_properties(SUNDIALS::kinsol PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_KINSOL_INCLUDE_DIR}"
        IMPORTED_LOCATION ${SUNDIALS_KINSOL_LIBRARY})
    if(DEFINED CMAKE_CUDA_COMPILER AND NOT ${CMAKE_CUDA_COMPILER} MATCHES "NOTFOUND")
        add_library(SUNDIALS::nveccuda UNKNOWN IMPORTED)
        set_target_properties(SUNDIALS::nveccuda PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${SUNDIALS_NVECTOR_CUDA_INCLUDE_DIR}"
            IMPORTED_LOCATION ${SUNDIALS_NVECTOR_CUDA_LIBRARY})
    endif()
endif()

mark_as_advanced(SUNDIALS_LIBRARIES SUNDIALS_INCLUDE_DIRS SUNDIALS_FOUND)