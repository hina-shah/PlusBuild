# Find the Andor SDK
# ANDOR_FOUND - Andor SDK has been found on this system
# ANDOR_INCLUDE_DIR - where to find the header files
# ANDOR_LIBRARY_DIR - libraries to be linked
# ANDOR_BINARY_DIR - common shared libraries to be installed
# ANDOR_WIN32_BINARY_DIR - 32-bit shared libraries to be installed
# ANDOR_WIN64_BINARY_DIR - 64-bit shared libraries to be installed

SET( ANDOR_PATH_HINTS
  "C:/Program Files/Andor SDK"
  )

FIND_PATH(Andor_INCLUDE_DIR ATMCD32D.h
  DOC "ANDOR include directory (contains ATMCD32D.h)"
  PATHS ${ANDOR_PATH_HINTS}
  )  

if( CMAKE_SIZEOF_VOID_P EQUAL 8 ) 
  set(bitness 64) 
else()
  set(bitness 32)
endif()
set(  "atmcd${bitness}m") # suffix m is for Microsoft compiler, d is for Borland

# 
FIND_PATH(ANDOR_WIN_LIBRARY_DIR ${AndorLibName}${CMAKE_STATIC_LIBRARY_SUFFIX}
  DOC "ANDOR ${bitness}-bit library directory (contains ${AndorLibName}${CMAKE_STATIC_LIBRARY_SUFFIX}})"
  PATHS ${ANDOR_PATH_HINTS}
  )

set(AndorDLLName "atmcd${bitness}d")
FIND_PATH(ANDOR_WIN_BINARY_DIR ${AndorDLLName}${CMAKE_SHARED_LIBRARY_SUFFIX}
  DOC "Path to ANDOR ${bitness}-bit binary directory (contains ${bitness}-bit ${AndorDLLName}.dll)"
  PATHS ${ANDOR_PATH_HINTS}
  NO_DEFAULT_PATH # avoid finding installed DLLs in the system folders
  )
  
set( Andor_BINARY_DIR ${ANDOR_WIN_BINARY_DIR} )
set( Andor_LIBRARY_DIR ${ANDOR_WIN_LIBRARY_DIR} )

# handle the QUIETLY and REQUIRED arguments and set ANDOR_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ANDOR DEFAULT_MSG
  Andor_LIBRARY_DIR
  Andor_INCLUDE_DIR
  Andor_BINARY_DIR
  )

IF(ANDOR_FOUND)
  SET( ANDOR_LIBRARY_DIR ${Andor_LIBRARY_DIR} )
  SET( ANDOR_INCLUDE_DIR ${Andor_INCLUDE_DIR} )
  SET( ANDOR_BINARY_DIR ${Andor_BINARY_DIR} )
ENDIF()
