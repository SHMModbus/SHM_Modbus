# Shared Memory Modbus Client Simulator: Shared Memory Write Example

## 1. Start a Modbus Client
You can find an example for starting the Modbus TCP client [here](tcp_client.md).
This example assumes that the default names of the shared memories are used.

## 2. Use Shared Memory Write

- Write DO registers from image file (created with [dump-shm](dump_shm.md))
```
write-shm -n modbus_DO < modbus_DO.img
```
- Write zeroes to DI registers
```
write-shm -n modbus_DI < /dev/zero
```
- Write 0xFFFF to all AI registers
```
write-shm -n modbus_AI -i < /dev/zero
```
- Write pseudo random values to AO registers
```
write-shm -n modbus_AO < /dev/urandom
```
- Write byte sequence to AI registers
```
printf "%b" "\x66\x6f\x6f\x62\x61\x72\x5f" | write-shm -n modbus_AI
```
- Write byte sequence to AO registers (repeat until all registers are written)
```
printf "%b" "\x66\x6f\x6f\x62\x61\x72\x5f" | write-shm -n modbus_AO -r
```
