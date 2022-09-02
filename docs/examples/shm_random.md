# Shared Memory Modbus Client Simulator: Shared Memory Random Example

## 1. Start a Modbus Client
You can find an example for starting the Modbus TCP client [here](tcp_client.md).
This example assumes that the default names of the shared memories are used.

## 2. Use Shared Memory Random
- write random values (until user terminates) to the AO registers (interval of 1s):
```
shared-mem-random -n modbus_AO
```

- write random values (until user terminates) to the AI registers with a custom interval (in milliseconds):
```
shared-mem-random -n modbus_AI -i <interval>
```

- write ```n``` times random values to modbus_AO:
```
shared-mem-random -n modbus_AO - l 10
```

- write random values to the lsb of every byte in modbus_DO:
```
shared-mem-random -n modbus_DO -a 1 -m 0x1
```

- write random values to the lsb of every word (16 bit) in modbus_AI.  
*Mind the endiannes of your system when setting the bitmask.*
```
shared-mem-random -n modbus_AI -a 2 -m 0x1
```

- write random values to every second word (16 bit) in mobus_AO.  
*Mind the endiannes of your system when setting the bitmask.*
```
shared-mem-random -n modbus_AI -a 4 -m 0xFFFF
```
