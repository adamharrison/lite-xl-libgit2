# lite-xl-libgit2

A library which contains libgit2 bindings for lite-xl.

Designed to be used in conjunction with the write-xl project to provide git services on Android.

## Building

### Linux, MSYS, MacOS

```sh
./build.sh clean && ./build.sh
```

### Cross Compile Linux -> Windows

```sh
./build.sh clean && BIN=libgit2.dll CC=x86_64-w64-mingw32-gcc AR=x86_64-w64-mingw32-gcc-ar \
  CMAKE_DEFAULT_FLAGS="-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=NEVER -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_SYSTEM_INCLUDE_PATH=/usr/share/mingw-w64/include"\
  GIT2_CONFIGURE="-DDLLTOOL=x86_64-w64-mingw32-dlltool" ./build.sh
```

### Cross Compile Linux -> Android

Requires the following variables defined to run the below command:

* `ANDROID_NDK_HOME`
* `ANDROID_ABI_VERSION` (21-32+; default: 21)
* `ANDROID_ARCH` (`aarch64`, `armv7a` `x86_64`, `x86`)

```sh
rm -rf bin && mkdir bin &&
  ./build.sh clean && ANDROID_ARCH=aarch64 ./build-android.sh &&
  ./build.sh clean && ANDROID_ARCH=armv7a ./build-android.sh &&
  ./build.sh clean && ANDROID_ARCH=x86_64 ./build-android.sh &&
  ./build.sh clean && ANDROID_ARCH=x86 ./build-android.sh
```

This script is just a simple wrapper over build.sh that defines `CC`, `AR`, and a few of the
CMake android variables. You can also just run `build.sh` directly by supplying the appropriate
variables.

Compiling all supported platforms at once, except mac, because mac is bullshit:

```
rm -rf bin && mkdir bin &&
  ./build.sh clean && BIN="bin/libgit2.x86_64-linux.so" ./build.sh &&
  ./build.sh clean && CFLAGS="-m32" BIN="bin/libgit2.x86-linux.so" ./build.sh &&
  ./build.sh clean && BIN=bin/libgit2.x86_64-windows.dll CC=x86_64-w64-mingw32-gcc AR=x86_64-w64-mingw32-gcc-ar \
    CMAKE_DEFAULT_FLAGS="-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=NEVER -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_SYSTEM_INCLUDE_PATH=/usr/share/mingw-w64/include"\
    GIT2_CONFIGURE="-DDLLTOOL=x86_64-w64-mingw32-dlltool" ./build.sh &&
  ./build.sh clean && BIN=bin/libgit2.x86-windows.dll CC=i686-w64-mingw32-gcc AR=i686-w64-mingw32-gcc-ar \
    CMAKE_DEFAULT_FLAGS="-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=NEVER -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_SYSTEM_INCLUDE_PATH=/usr/share/mingw-w64/include"\
    GIT2_CONFIGURE="-DDLLTOOL=x86_64-w64-mingw32-dlltool" ./build.sh &&
  ./build.sh clean && BIN="bin/libgit2.x86_64-linux.so" ./build.sh &&
  ./build.sh clean && ANDROID_ARCH=aarch64 ./build-android.sh &&
  ./build.sh clean && ANDROID_ARCH=armv7a ./build-android.sh &&
  ./build.sh clean && ANDROID_ARCH=x86_64 ./build-android.sh &&
  ./build.sh clean && ANDROID_ARCH=x86 ./build-android.sh
```

## Releases

Releases are created automatically via CI for any tagged push;
