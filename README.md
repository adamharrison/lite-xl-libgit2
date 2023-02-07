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
./build.sh clean && BIN=libgit2.dll CC=x86_64-w64-mingw32-gcc AR=x86_64-w64-mingw32-gcc-ar WINDRES=x86_64-w64-mingw32-windres \
  CMAKE_DEFAULT_FLAGS="-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER\ -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=NEVER -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_SYSTEM_INCLUDE_PATH=/usr/share/mingw-w64/include"\
  GIT2_CONFIGURE="-DDLLTOOL=x86_64-w64-mingw32-dlltool" ./build.sh
```

### Cross Compile Linux -> Android

```sh
./build.sh clean &&
```
