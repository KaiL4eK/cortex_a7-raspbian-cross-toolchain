#!/bin/bash

source ../libs.sh

MKSPECS_DIR="qtbase/mkspecs/linux-arm-gnueabihf-g++"

if [ ! -d "$MKSPECS_DIR" ]; then
	cp -r "qtbase/mkspecs/linux-arm-gnueabi-g++" $MKSPECS_DIR
	sed -i 's/gnueabi/gnueabihf/g' $MKSPECS_DIR/qmake.conf
fi

unset CC CXX CPP AR AS LD CXXFLAGS CFLAGS

./configure -release \
		-device linux-rasp-pi-g++ -make libs -device-option CROSS_COMPILE=$TARGET- \
		-opensource -confirm-license \
		-platform linux-g++ -xplatform linux-arm-gnueabihf-g++ \
		-nomake examples -nomake tests \
		-skip qtwebkit \
		-reduce-exports \
		-opengl es2 \
		-prefix $INSTALL_DIR \
		-extprefix $INSTALL_DIR \
		-hostprefix $QT_HOST_INSTALL_DIR \
		-qt-xcb \
		-sysroot $SYSROOT -v



# to clean
# git submodule foreach --recursive "git clean -dfx" && git clean -dfx
# from:
# https://wiki.qt.io/Building_Qt_5_from_Git
