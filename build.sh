#!/bin/bash

find_cuda_compiler () {
  if command -v nvcc &> /dev/null
  then
    echo "$(command -v nvcc)"
  elif [ -f "/usr/local/cuda/bin/nvcc" ]; then
    echo "/usr/local/cuda/bin/nvcc"
  else
    echo ""
  fi
}

mkdir -p build
cd build

cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DAV_BUILD_JPEG=OFF \
  -DAV_BUILD_PNG=OFF \
  -DALICEVISION_BUILD_DEPENDENCIES=ON \
  -DCMAKE_INSTALL_PREFIX=$PWD/../install \
  -DCMAKE_DETECTED_CUDA_COMPILER=$(find_cuda_compiler) \
  ..

make -j12
