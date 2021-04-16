cmake_minimum_required(VERSION 3.16)
project(webrtc_stream C)

set(CMAKE_C_STANDARD 99)

include_directories(/usr/include/gstreamer-1.0/)
include_directories(/usr/include/glib-2.0/)
include_directories(/usr/lib/x86_64-linux-gnu/glib-2.0/include/)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)


link_libraries(/usr/lib/x86_64-linux-gnu/libgstbase-1.0.so)
link_libraries(/usr/lib/x86_64-linux-gnu/libgstvideo-1.0.so)
link_libraries(/usr/lib/x86_64-linux-gnu/libgstreamer-1.0.so)
link_libraries(/usr/lib/x86_64-linux-gnu/libgobject-2.0.so)
link_libraries(/usr/lib/x86_64-linux-gnu/libgstreamer-1.0.so)
link_libraries(/usr/lib/x86_64-linux-gnu/libglib-2.0.so)
link_libraries(/usr/lib/x86_64-linux-gnu/libgstwebrtc-1.0.so)
link_libraries(/lib/x86_64-linux-gnu/libgstsdp-1.0.so)
add_executable(webrtc_stream main.c)