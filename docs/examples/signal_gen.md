# Shared Memory Modbus Client Simulator: Shared Memory Dump Example

## 1. Start a Modbus Client
You can find an example for starting the Modbus TCP client [here](tcp_client.md).
This example assumes that the default names of the shared memories are used.

## 2. Use Signal Generator

### Create sine (32 bit float)
```
shm-modbus-signal-gen -d 0.1 -e f32l sin ao 0x42 | stdin-to-modbus-shm
```

### Create Ramp (64Bit float, 2 Registers)
```
shm-modbus-signal-gen -e f64l ramp ai 0xAA 0xBB | stdin-to-modbus-shm
```

### Toggle bits
```
shm-modbus-signal-gen toggle do 0x1 0x2 0x3 0x17 | stdin-to-modbus-shm
```
