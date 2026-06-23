# std_msgs_stamped

`std_msgs_stamped` is a ROS 2 message-only package that provides stamped
variants of common `std_msgs` data messages.

Each stamped message prepends:

```text
std_msgs/Header header
```

and preserves the payload fields from the corresponding `std_msgs` message.
For example, `std_msgs/msg/UInt8MultiArray` becomes
`std_msgs_stamped/msg/StampedUInt8MultiArray` with `header`, `layout`, and
`data` fields.

## Timestamp contract

`header.stamp` is assigned by the publishing node. This package only defines
message types; it does not set timestamps automatically.

The stamp may represent publish time or a domain-specific source event time,
depending on the publishing node's documented contract. Publishers must assign
`header.stamp` before publishing.

`header.frame_id` is optional in this package contract. For payloads that are
not tied to a specific frame, publishers may leave `header.frame_id` empty.
Only frame-specific messages should populate it with a meaningful frame name.

## Messages

Primitive values:

- `StampedBool`
- `StampedByte`
- `StampedChar`
- `StampedString`
- `StampedFloat32`
- `StampedFloat64`
- `StampedInt8`
- `StampedInt16`
- `StampedInt32`
- `StampedInt64`
- `StampedUInt8`
- `StampedUInt16`
- `StampedUInt32`
- `StampedUInt64`

Multi-array values:

- `StampedByteMultiArray`
- `StampedFloat32MultiArray`
- `StampedFloat64MultiArray`
- `StampedInt8MultiArray`
- `StampedInt16MultiArray`
- `StampedInt32MultiArray`
- `StampedInt64MultiArray`
- `StampedUInt8MultiArray`
- `StampedUInt16MultiArray`
- `StampedUInt32MultiArray`
- `StampedUInt64MultiArray`

Additional useful data messages:

- `StampedColorRGBA`
- `StampedEmpty`

Helper/container types such as `Header`, `MultiArrayLayout`, and
`MultiArrayDimension` are intentionally not stamped in this package.

## Publishing example

```cpp
#include "std_msgs_stamped/msg/stamped_u_int8_multi_array.hpp"

auto publisher =
  node->create_publisher<std_msgs_stamped::msg::StampedUInt8MultiArray>(
    "debug_payload", 10);

std_msgs_stamped::msg::StampedUInt8MultiArray msg;
msg.header.stamp = node->get_clock()->now();
msg.layout.dim.clear();
msg.layout.data_offset = 0;
msg.data = payload;

publisher->publish(msg);
```
