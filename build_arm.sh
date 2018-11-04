#!/bin/sh
# Compiles fftw3 for Android
#NDK Version r40e  http://dl.google.com/android/ndk/android-ndk-r103-linux-x86_64.tar.bz2

NDK_DIR="/opt/android-sdk/ndk-bundle"
INSTALL_DIR="`pwd`/jni_arm"

export PATH="$NDK_DIR/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/:$PATH"
export SYS_ROOT="$NDK_DIR/platforms/android-21/arch-arm/"
export CC="arm-linux-androideabi-gcc --sysroot=$SYS_ROOT"
export LD="arm-linux-androideabi-ld"
export LD_LIBRARY_PATH="$NDK_DIR/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/lib/gcc/arm-linux-androideabi/4.9.x"
export AR="arm-linux-androideabi-ar"
export RANLIB="arm-linux-androideabi-ranlib"
export STRIP="arm-linux-androideabi-strip"
export CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=neon -fno-builtin-memmove -mthumb -D__ANDROID_API__=21" 
export C_INCLUDE_PATH="$NDK_DIR/sysroot/usr/include:$NDK_DIR/sysroot/usr/include/arm-linux-androideabi"

mkdir -p $INSTALL_DIR
./configure --host=arm-linux-androideabi \
        --prefix=$INSTALL_DIR \
        LIBS="-L$LD_LIBRARY_PATH -L$SYS_ROOT/usr/lib -lc -lgcc" \
    --enable-shared\
        --enable-float --enable-neon
#        --enable-threads
 

make -j4
make install

exit 0

##如果是armv7a 可开启 --enable-float --enable-neon加速功能，不能单独开一个且cflags里要加上“-march=armv7-a -mfloat-abi=softfp  -mfpu=neon”.
