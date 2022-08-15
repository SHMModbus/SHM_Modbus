#!/bin/bash

function read_command_line_args {
    read -p "command line arguments: " args

    re='^([0-9]|[a-z]|[A-Z]|[\._]|[+-]|\s)*$'
    if ! [[ $args =~ $re ]]; then
        echo "__INVALID__ARGS__"
        return
    fi
    echo ${args}
}

function read_redirect_file {
    read -p "file to redirect output (press return for none): " fname

    re='^([0-9]|[a-z]|[A-Z]|[/\._]|[+-/])*$'
    if ! [[ $fname =~ $re ]]; then
        echo "__INVALID__ARGS__"
        return
    fi
    echo $fname
}

function manual_modbus_tcp_client_shm {
    scriptpath=$1

    args=$(read_command_line_args)

    if [ "$args" = "__INVALID__ARGS__" ]; then
        echo "Invalid characters in argument"
        return
    fi

    redir=$(read_redirect_file)
    if [ $"redir" == "__INVALID__ARGS__" ]; then
        echo "Invalid characters in redirection target"
        return
    fi

    if [ "$redir" = "" ]; then
        $scriptpath/modbus-tcp-client-shm ${args}
    else
        $scriptpath/modbus-tcp-client-shm ${args} > $redir
    fi
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

