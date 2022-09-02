# Shared Memory Modbus Client Simulator: STDIN to Modbus Shared Memory Example

## 1. Start a Modbus Client
You can find an example for starting the Modbus TCP client [here](tcp_client.md).
This example assumes that the default names of the shared memories are used.

## 2. Use STDIN to Modbus Shared Memory

### Interactive mode

#### 1. Start STDIN to Modbus Shared Memory
```
stdin-to-modbus-shm
```

If you changed the name of the modbus shared memory or you want to use a shared memory for a separate client id, use the option ```-n``` to specify a different Modbus shared memory name prefix.

#### 2. Enter commands
##### Command format:
```
reg_type:address:value[:data_type]
```
- reg_type: specifies the register type (do, di, ao, ai)
- address: register address (integer value (format as in C/C++))
- value: value to write to the register (16 bit unsigned integer (format as in C/C++) if no data type is specified)
- data_type: the data type that is to be written. Type ```help types``` as command to show possible data types.

##### Example commands
- write 1 to DO register 5
```
do:5:1
```
- write pi as 64 bit float in little endian starting at AO register 8
```
ao:8:pi:f64l
```

- write 42.24 as 32 bit float in big endian starting at AI register 16 (0x10)
```
ao:0x10:42.24:f32b
```

> **NOTE** The endianness refers to the layout of the data in the shared memory and may differ from the Modbus master's definition of the endianness.

##### passthrough
The option ```--passthrough``` can be used to output all executed commands to stdout. 
By additionally enabling ```--bash```, the output is formatted as a bash script that reproduces the inputs including the timing.

### From file/script

A file or the output of a script can be used as input for the Application.

#### Simple Toggle Script
The following shell script (toggle.sh) can be used to toggle a bit:
```
#!/bin/sh

REGISTER="do:0x1"
PERIOD="3"

v=1
while true
do
    echo "$REGISTER:$v"
    sleep $(echo "scale=2; $PERIOD/2" | bc)
    if [ "$v" -eq "0" ];then
        v=1
    else
        v=0
    fi
done
```

```
./toggle.sh | stdin-to-modbus-shm
```

#### Execute commands from file
Example file (cmd.txt):
```
ao:0x10:42.24:f64b
do:0:1
ao:0x42:64:u16l
ao:0x55:50.5:f32lr
```

The following command writes 
- 42.24 as a big endian 64 bit float to the AO registers 16 - 19
- 1 to the DO register 0
- 64 as little endian 16 bit unsigned integer to the AO register 64
- 50.5 as little endian 32 bit float in reversed register order to the AO register 0x55
```
stdin-to-modbus-shm < cmd.txt
```

#### generate inputs in interactive mode and reproduce later
1. Start in interactive mode
```
stdin-to-modbus-shm -p --bash > sequence.sh
```
2. Input commands
3. Terminate application
```
exit
```
4. Reproduce commands
```
bash sequence.sh | stdin-to-modbus-shm
```
