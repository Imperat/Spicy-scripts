cmake_minimum_required(VERSION 3.15)

project(desktop_native_modules LANGUAGES CXX Swift)

set(CMAKE_C_COMPILER "/usr/bin/clang")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
set(CMAKE_Swift_COMPILER "/usr/bin/swiftc")

set(CMAKE_OSX_SYSROOT "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk")

set(CMAKE_CXX_STANDARD 20)
# CMake will not try to configure and build project if compiler does not support required C++ standard.
set(CMAKE_CXX_STANDARD_REQUIRED True)

add_library(my_apple_payments SHARED 
  "./test.swift"
  "./test2.swift"
  "./test3.mm"
  "./test4.cc"
  )
