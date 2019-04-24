cmake_minimum_required(VERSION 2.8.12)
project(webrtc_ros)

set (CMAKE_CXX_STANDARD 11)

find_package(webrtc REQUIRED HINTS /webrtc)

add_executable(server server/data_socket.cc
                      server/main.cc
                      server/peer_channel.cc)

message("${webrtc_INCLUDE_DIRS}")
message("${webrtc_LIBRARIES}")
include_directories(${webrtc_INCLUDE_DIRS})
target_link_libraries (server ${webrtc_LIBRARIES})
add_definitions(${webrtc_DEFINITIONS})
