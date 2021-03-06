#!/bin/bash

source common.sh

REPO_TOOL=git
REPO_ADDRESS=https://github.com/opencv/opencv
SRC_DIR=$OPENCV_SRC_DIR

check_src_exist $REPO_TOOL $REPO_ADDRESS $SRC_DIR &&\
$REPO_TOOL checkout 3.1.0 &&\
rm -rf $BUILD_DIRECTORY &&\
mkdir $BUILD_DIRECTORY &&\
cd $BUILD_DIRECTORY &&\
cmake   -D WITH_TBB=ON -D TBB_INCLUDE_DIRS=$INCLUDE_DIR -D TBB_LIB_DIR=$LIBRARY_DIR \
        -D WITH_EIGEN=ON -D EIGEN_INCLUDE_PATH=$INCLUDE_DIR/eigen3 \
	-D WITH_QT=ON \
        -D INSTALL_PYTHON_EXAMPLES=ON -D WITH_IPP=ON \
        -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$INSTALL_DIR \
        -D CMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN \
        -D CMAKE_PREFIX_PATH=$CMAKE_LIB_DIR \
	-D BUILD_EXAMPLES=ON \
        .. &&\
confirm_building &&\
make install -j4

