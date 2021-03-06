#!/bin/bash

source common.sh

REPO_TOOL=git
REPO_ADDRESS=https://github.com/qt/qt5.git
SRC_DIR=$QT5_SRC_DIR

check_src_exist $REPO_TOOL $REPO_ADDRESS $SRC_DIR &&\
$REPO_TOOL checkout 5.8 &&\
./init-repository


MKSPECS_DIR="qtbase/mkspecs/linux-arm-gnueabihf-g++"
if [ ! -d "$MKSPECS_DIR" ]; then
	cp -r "qtbase/mkspecs/linux-arm-gnueabi-g++" $MKSPECS_DIR
	sed -i 's/gnueabi/gnueabihf/g' $MKSPECS_DIR/qmake.conf
fi

unset CC CXX CPP AR AS LD CXXFLAGS CFLAGS

# -device linux-rasp-pi-g++

./configure -release \
		-make libs -device-option CROSS_COMPILE=$TARGET- \
		-opensource -confirm-license \
		-platform linux-g++ -xplatform linux-arm-gnueabihf-g++ \
		-nomake examples -nomake tests \
		-skip qtwebkit \
		-reduce-exports \
		-prefix $INSTALL_DIR \
		-extprefix $INSTALL_DIR \
		-hostprefix $QT_HOST_INSTALL_DIR \
		-opengl es2 \
		-qt-xcb \
		-sysroot $TARGET_SYSROOT -v &&\
confirm_building &&\
make -j4
make install

# to clean
# git submodule foreach --recursive "git clean -dfx" && git clean -dfx
# from:
# https://wiki.qt.io/Building_Qt_5_from_Git
