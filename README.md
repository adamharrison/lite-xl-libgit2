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

Requires the following variables defined:

* `ANDROID_NDK_HOME`

```sh
./build.sh clean &&
  CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android21-clang\
  AR=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar
  CFLAGS="-Dinline="\
  CMAKE_DEFAULT_FLAGS="-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER -DCMAKE_ANDROID_NDK=$ANDROID_NDK_HOME -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=NEVER -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_SYSTEM_NAME=Android -DCMAKE_SYSTEM_INCLUDE_PATH=$ANDROID_SYSROOT_NDK/sysroot/usr/include"\
  ./build.sh
```

## Releases

Releases are created automatically via CI for any tagged push;
