#!/bin/bash

NAME=$1
VERSION=$2
TARGET=$3

. ./common.sh $NAME $VERSION $TARGET

pushd $SUBMODULES/zlib

myconf=(
    --prefix="$FFBUILD_PREFIX"
    --static
    CFLAGS="-static-libgcc -static-libstdc++ -O2 -pipe -D_FORTIFY_SOURCE=2 -fstack-protector-strong"
    CXXFLAGS="-static-libgcc -static-libstdc++ -O2 -pipe -D_FORTIFY_SOURCE=2 -fstack-protector-strong"
    LDFLAGS="-static -static-libstdc++ -static-libgcc -O2 -pipe -fstack-protector-strong"
)

./configure "${myconf[@]}"
make -j$(nproc)
make install

popd