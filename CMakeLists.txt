cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(cuda2cpp LANGUAGES CXX CUDA)
project(cuda_base CXX CUDA)

include(CTest)

add_library(cuda_base 
    cudaHeaders.h
    cudaMain.h
    cudaMain.cu
    func.cu
    func.h
  )

# Request that cuda_base be built with -std=c++11
# As this is a public compile feature anything that links to cuda_base
# will also build with -std=c++11
target_compile_features(cuda_base PUBLIC cxx_std_11)

# We need to explicitly state that we need all CUDA files in the cuda_base
# library to be built with -dc as the member functions could be called by
# other libraries and executables
set_target_properties( cuda_base
                       PROPERTIES CUDA_SEPARABLE_COMPILATION ON
                      )

set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -gencode arch=compute_50,code=sm_50")

if(BUILD_TESTING)

  add_executable(cuda2cpp main.cpp)

  set_target_properties(cuda2cpp PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
  target_link_libraries(cuda2cpp PRIVATE cuda_base)

  if(APPLE)
    # We need to add the default path to the driver (libcuda.dylib) as an rpath,
    # so that the static cuda runtime can find it at runtime.
    set_property(TARGET particle_test PROPERTY BUILD_RPATH ${CMAKE_CUDA_IMPLICIT_LINK_DIRECTORIES})
  endif()
endif()