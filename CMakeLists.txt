cmake_minimum_required(VERSION 3.8)
project(std_msgs_stamped)

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/StampedBool.msg"
  "msg/StampedByte.msg"
  "msg/StampedByteMultiArray.msg"
  "msg/StampedChar.msg"
  "msg/StampedColorRGBA.msg"
  "msg/StampedEmpty.msg"
  "msg/StampedFloat32.msg"
  "msg/StampedFloat32MultiArray.msg"
  "msg/StampedFloat64.msg"
  "msg/StampedFloat64MultiArray.msg"
  "msg/StampedInt8.msg"
  "msg/StampedInt8MultiArray.msg"
  "msg/StampedInt16.msg"
  "msg/StampedInt16MultiArray.msg"
  "msg/StampedInt32.msg"
  "msg/StampedInt32MultiArray.msg"
  "msg/StampedInt64.msg"
  "msg/StampedInt64MultiArray.msg"
  "msg/StampedString.msg"
  "msg/StampedUInt8.msg"
  "msg/StampedUInt8MultiArray.msg"
  "msg/StampedUInt16.msg"
  "msg/StampedUInt16MultiArray.msg"
  "msg/StampedUInt32.msg"
  "msg/StampedUInt32MultiArray.msg"
  "msg/StampedUInt64.msg"
  "msg/StampedUInt64MultiArray.msg"
  DEPENDENCIES std_msgs
)

ament_export_dependencies(rosidl_default_runtime)
ament_package()
