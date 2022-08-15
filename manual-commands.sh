#!/bin/bash

function read_command_line_args {
    read -p "command line arguments: " args

    re='^([0-9]|[a-z]|[A-Z]|[\._]|[+-]|\s)*$'
    if ! [[ $args =~ $re ]]; then
        echo "__INVALID__ARGS__"
        return
    fi
    echo args
}

function manual_modbus_tcp_client_shm {
    scriptpath=$1

    args=$(read_command_line_args)

    if [ "$args" = "__INVALID__ARGS__" ]; then
    echo "Invalid characters in argument"
        return
    fi

    $scriptpath/modbus-tcp-client-shm $args
}

function manual_modbus_rtu_client_shm {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

function manual_dump_shm {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

function manual_write_shm {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

function manual_shared_mem_random {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

function manual_stdin_to_modbus_shm {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

