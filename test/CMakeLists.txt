cmake_minimum_required(VERSION 2.8.12)
project(webrtc_ros)

set (CMAKE_CXX_STANDARD 11)

find_package(catkin REQUIRED COMPONENTS
  roscpp std_msgs
)

find_package(webrtc REQUIRED HINTS /webrtc)

catkin_package(
  CATKIN_DEPENDS
    roscpp
  DEPENDS webrtc
)

add_definitions(${webrtc_DEFINITIONS})
include_directories(${catkin_INCLUDE_DIRS} ${webrtc_INCLUDE_DIRS})

add_executable(server
  server/data_socket.cc
  server/main.cc
  server/peer_channel.cc
)

target_link_libraries(server
  ${webrtc_LIBRARIES}
  ${catkin_LIBRARIES}
)

message("${webrtc_INCLUDE_DIRS}")
message("${webrtc_LIBRARIES}")
