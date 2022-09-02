# Shared Memory Modbus Client Simulator: TCP Client Example

## 1. Setup Port Redirection
The port redirection must only be activated if the port is below 1024.
This is the case for the Modbus default port (502).
In this example, port 5020 is used as the forwarding port.
*change the ports according to your configuration.*

```
sudo iptables -A PREROUTING -t nat -p tcp --dport 502 -j REDIRECT --to-port 5020
```

## 2. Start the Client
Next, the Modbus client is started using the following command:
```
modbus-tcp-client-shm -p 5020
```
This starts the client with the following properties.:
- The client terminates when the Modbus Server disconnects.
- It uses the shared memories ```modbus_DO```, ```modbus_DI```, ```modbus_AO``` and ```modbus_AI``` to store it's register values.
- Each register type has 65536 entries.
- The connection times out after approx. 5 seconds without connection to the Modbus server.
- The Modbus packets are not output to stdout.
- The Modbus server can connect via any ip.
- The Client serves all requests using the four shared memories.

Command line options to manipulate the clients properties:
- do not terminate if the Modbus Server disconnects: 
```
-r
```
- change the shared memory name. 
This will only change the name prefix (```modbus_```). 
The register suffixes will always be present.
```
-n <name_prefix>
```
- change the number of DO registers:
```
--do-registers <regs>
```
- change the number of DI registers:
```
--di-registers <regs>
```
- change the number of AO registers:
```
--ao-registers <regs>
```
- change the number of AI registers:
```
--ai-registers <regs>
```
- change the connection timeout (in seconds):
```
-t <timeout>
```
- print all modbus packets to stdout:
```
-m
```
- specify ip via which the Modbus Server can connect:
```
-i <ip>
```
- use separate shared memories for selected client ids.
It is possible to supply multiple ids separated with a comma.
It is also possible to use this option multiple times.  
Using this option results in the creation of additional shared memories for each specified id in addition to the normally created Modbus shared memories.
These shared memories have the corresponding client id in their name (as a hex value). E.g ```modbus_0f_DO``` or ```modbus_a2_AI```.
```
-s <id>
```
- use separate shared memories for selected client ids.
This option is like using ```-s``` for all client ids.
```
--separate-all
```

## 3. Use (Modbus) Shared Memory Tools to Read and Manipulate the Shared Memory

- [Shared Memory Dump](dump_shm.md)
- [Shared Memory Write](write_shm.md)
- [Shared Memory Random](shm_random.md)
- [STDIN to Modbus Shared Memory](stdin_to_shm.md)

## 4. Clenup
If port redirection is used, the following command should be executed to disable the port redirection after closing the client. *change the ports according to your configuration.*
```
sudo iptables -D PREROUTING -t nat -p tcp --dport 502 -j REDIRECT --to-port 5020
```