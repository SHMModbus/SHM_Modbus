# Shared Memory Modbus Client Simulator

This project is a a collection of applications to simulate a Modbus TCP/RTU client. 

It contains the following tools:

- General Shared Memory Tools:
  - [Shared Memory Dump](https://nikolask-source.github.io/dump_shm/)
  - [Shared Memory Write](https://nikolask-source.github.io/write_shm/)
  - [Shared Memory Random](https://nikolask-source.github.io/shared_mem_random/)
- Modbus Clients:
  - [RTU](https://nikolask-source.github.io/modbus_rtu_client_shm/)
  - [TCP](https://nikolask-source.github.io/modbus_tcp_client_shm/)
- Modbus Shared Memory Tools:
  - [STDIN to Modbus SHM](https://nikolask-source.github.io/stdin_to_modbus_shm/)
  - [SHM Modbus Signal Generator](https://nikolask-source.github.io/shm-modbus-signal-gen/)

In addition, a start script is included, which also provides a guided mode.

## Install

### Using the Arch User Repository (recommended for Arch based Linux distributions)
The application is available as [shm-modbus](https://aur.archlinux.org/packages/shm-modbus) in the [Arch User Repository](https://aur.archlinux.org/).
See the [Arch Wiki](https://wiki.archlinux.org/title/Arch_User_Repository) for information about how to install AUR packages.

Unlike the flatpak variant, no ```.desktop``` file is included in the AUR package.
It is therefore a terminal only application.


### Snap
The application is available as snap package.
You can download it via the [github releases page](https://github.com/NikolasK-source/SHM_Modbus/releases).

Like the AUR package, the snap package is a terminal only application.


### Flatpak
The application is available as flatpak and published on flathub as ```io.github.shmmodbus.shm-modbus```.

The installation can be done with the following command: 
```
flatpak install io.github.shmmodbus.shm-modbus
```


## Use

The primary use case of this application is the use of the individual tools from the command line.
A desktop launcher with a guided mode is available, but it only provides limited functionality.

> **_Note_:** All tools in this application are developed for testing purposes. They are not intended to be used in production systems.  

Usage Examples (Commands like in AUR package or flatpak with launch commands (long)):
- [Modbus TCP client](examples/tcp_client.md)
- [Shared Memory Dump](examples/dump_shm.md)
- [Shared Memory Write](examples/write_shm.md)
- [Shared Memory Random](examples/shm_random.md)
- [STDIN to Modbus Shared Memory](examples/stdin_to_shm.md)
- [Signal Generator](examples/signal_gen.md)

### Command overview

A list of alias commands for each package type can be downloaded [here](https://gist.github.com/NikolasK-source/8e45d7509487e9b23dca1fa452c35aa4) ([zip](https://gist.github.com/NikolasK-source/8e45d7509487e9b23dca1fa452c35aa4/archive/ec201a93b6f79389000824339b799dacf216b96b.zip)).
This simplifies the invocation of the tools and ensures that the same commands can be used regardless of the selected package.

>**_Note_:** The AUR package provides the long commands for each tool, therefore no such alias list exists.

>**_Note_:**: Before applying the alias list, make sure that the target command is not used by any other installed application.

The following table shows the commands to invoke each tool.
| Tool | long command | short command | Snap | Flatpak |
| - | - | - | - | - |
| Modbus TCP Client | ```modbus-tcp-client-shm``` | ```mbtcp``` | ```shm-modbus.modbus-tcp-client-shm``` | ```flatpak run io.github.shmmodbus.shm-modbus modbus-tcp-client-shm``` |
| Modbus RTU Client | ```modbus-rtu-client-shm``` | ```mbrtu``` | ```shm-modbus.modbus-rtu-client-shm``` | ```flatpak run io.github.shmmodbus.shm-modbus modbus-rtu-client-shm``` |
| STDIN to Modbus SHM | ```stdin-to-modbus-shm``` | ```stdin2mb ``` | ```shm-modbus.stdin-to-modbus-shm``` | ```flatpak run io.github.shmmodbus.shm-modbus stdin-to-modbus-shm``` |
| Shared Memory Dump | ```dump-shm``` | ```dshm``` | ```shm-modbus.dump-shm``` | ```flatpak run io.github.shmmodbus.shm-modbus dump-shm``` |
| Shared Memory Write | ```write-shm``` | ```wshm``` | ```shm-modbus.write-shm``` | ```flatpak run io.github.shmmodbus.shm-modbus write-shm``` |
| Shared Memory Random | ```shared-mem-random``` | ```shmrnd``` | ```shm-modbus.shared-mem-random``` | ```flatpak run io.github.shmmodbus.shm-modbus shared-mem-random``` |
| WAGO Modbus Coupler SHM | ```wago-modbus-coupler-shm``` | ```wagomb``` | ```shm-modbus.wago-modbus-coupler-shm``` | ```flatpak run io.github.shmmodbus.shm-modbus wago-modbus-coupler-shm``` |
| Signal Generator | ```shm-modbus-signal-gen```  | ```mbsig``` | ```shm-modbus.signal-gen``` | ```flatpak run io.github.shmmodbus.shm-modbus signal-gen``` |

### Steps for Simulating a Modbus Client.

1. Start the appropriate Modbus client ([modbus-tcp-client-shm](https://nikolask-source.github.io/modbus_tcp_client_shm/) or [modbus-rtu-client-shm](https://nikolask-source.github.io/modbus_rtu_client_shm/)).
Information about the configuration of the clients can be found in their documentation.
([TCP](https://nikolask-source.github.io/modbus_tcp_client_shm/) / [RTU](https://nikolask-source.github.io/modbus_rtu_client_shm/))

2. Use the following tools to read and manipulate the modbus registers:
  - [dump-shm](https://nikolask-source.github.io/dump_shm/) can be used to read the content of a shared memory. 
  Especially useful in connection with ```hexdump```.
  - [write-shm](https://nikolask-source.github.io/write_shm/) can be used to write the content of a shared memory.
  - [shared-mem-random](https://nikolask-source.github.io/shared_mem_random/) is a tool to write random values to a shared memory
  - [stdin-to-modbus-shm](https://nikolask-source.github.io/stdin_to_modbus_shm/) is a tool to write values to the modbus registers. It can handle various data types and endiannes.

### Memory layout
Each instance of a Modbus client creates 4 shared memories.
Two of them store binary coils (binary values). 
The other two store the Modbus registers. 
(See the [Modbus specification](https://modbus.org/docs/Modbus_Application_Protocol_V1_1b3.pdf) for details.)

Each coil is represented by one byte in the shared memory.
As they are representing binary values, every non zero value of the byte is interpreted as 1.

The 16 bit modbus registers are stored as 16 bit values (16 bit aligned) in the shared memory.

## Common Problems
A list of common problems can be found [here](common_problems.md).

## License

MIT License

Copyright (c) 2022 Nikolas Koesling

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
