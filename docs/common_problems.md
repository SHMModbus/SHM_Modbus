# Shared Memory Modbus Client Simulator - Common Problems

## Failed to create Shared Memory (Modbus Client: TCP and RTU)
It can happen that the client reports the following error on startup:
```
Failed to create shared memory ...: File exists
```
This can be caused by:
 - Another modbus client is running that uses the shared memory with the given name.  
   If you want to run multiple instances simultaneously use the option ```--name-prefix``` to change the name of the shared memory.
 - Any other application uses a shared memory with the given name (unlikely but possible)  
   Close the Application that created the shared memory or use the option ```--name-prefix``` to change the name of the modbus shared memory.
 - A previous instance of a modbus client crashed or was forcefully terminated (e.g. by SIGKILL) and was not able to unlink the shared memory.  
   In this case, the option ```--force``` can be used to force the use of shared memory.
   In the other cases this option should not be used and **should never be used as a "default option"**.

## Connection frequently times out (Modbus Client: TCP)

If the connection frequently times out, it may be reasonable to increase the tcp timeout with the option ```--tcp-timeout```.
It is per default set to 5 seconds.

The two options ```--byte-timeout``` and ```--response-timeout``` change the timeout behavior of the modbus connection. 
These should only be changed by experienced users.
See the [libmodbus documentation](https://libmodbus.org/docs/v3.1.7/) ([byte timeout](https://libmodbus.org/docs/v3.1.7/modbus_set_byte_timeout.html) and [response timeout](https://libmodbus.org/docs/v3.1.7/modbus_set_response_timeout.html)) for more details.

## No Permission to create a TCP Socket (Modbus Client: TCP)
Ports below 1024 can by default not be used by standard users.

An entry can be added to the iptables that forwards the packets on the actual port to a higher port.
The following example redirects all tcp packets on port 502 to port 5020:
```
iptables -A PREROUTING -t nat -p tcp --dport 502 -j REDIRECT --to-port 5020
```
The Modbus client must than be started with the redirection target port.
```
... -p 5020
```

## Too many open files (Modbus Client: TCP *and RTU*)
It may happen that the start of the Modbus client fails with the error message ```Failed to open shared memory ...: Too many open files```.
This is very unlikely in general use and usually only occurs when the TCP client is started with the option ```--separate``` or ```--separate-all```.

To resolve this issue, the user's open file limit can be adjusted.
Use 
```
ulimit -n
```
to show the current file limit and
```
ulimit -n <new_limit>
```
to set a new open file limit.
