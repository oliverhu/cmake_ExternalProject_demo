# cmake_ExternalProject_demo

```
.
├── c++
│   ├── include
│   ├── src
│   │   ├── CMakeLists.txt
│   │   ├── main.cpp
│   │   └── orc_read_test.cpp
│   └── test
├── CMakeLists.txt
├── cmake_modules
│   └── FindORC.cmake
└── iris.orc

```

### build
```
mkdir build
cd build
cmake..
make
```

### test
```./orc_reader```
