# Shared Memory Modbus Client Simulator: Shared Memory Dump Example

## 1. Start a Modbus Client
You can find an example for starting the Modbus TCP client [here](tcp_client.md).
This example assumes that the default names of the shared memories are used.

## 2. Use Shared Memory Dump

### Create Hexdump
- Create hexdump of all DO registers
```
dump-shm modbus_DO | hexdump -C
```
- Create complete hexdump of all AI registers
```
dump-shm modbus_AI | hexdump -x -v
```
- Show value of a single DI register
```
i=<reg_index>
dump-shm modbus_DI | head -c $(($i+1)) | tail -c 1 | hexdump | head -1 | cut -d " " -f 2
```
- Show value of a single AO register
```
i=<reg_index> 
dump-shm modbus_AO | head -c $(expr 2 \* $i + 2) | tail -c 2 | hexdump | head -1 | cut -d " " -f 2
```

### Dump to file
- Create image of modbus_DO
```
dump-shm modbus_DO > modbus_DO.img
```
