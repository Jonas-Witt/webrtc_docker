cmake_minimum_required(VERSION 2.8.12)
project(webrtc_ros)

find_package(webrtc REQUIRED HINTS /webrtc)

add_executable(ros_test hello.cc)

message("${webrtc_INCLUDE_DIRS}")
message("${webrtc_LIBRARIES}")
include_directories(${webrtc_INCLUDE_DIRS})
target_link_libraries (ros_test ${webrtc_LIBRARIES})

