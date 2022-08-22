#!/bin/bash

function read_command_line_args {
    read -p "command line arguments: " args

    re='^([0-9]|[a-z]|[A-Z]|[\._]|[+-]|\s)*$'
    if ! [[ $args =~ $re ]]; then
        echo "__INVALID__ARGS__"
        return
    fi
    echo "$args"
}

function read_redirect_file {
    read -p "file to redirect output (stdout) (press return for none): " fname

    re='^([0-9]|[a-z]|[A-Z]|[/\._]|[+-/])*$'
    if ! [[ $fname =~ $re ]]; then
        echo "__INVALID__ARGS__"
        return
    fi
    echo "$fname"
}

function read_input_file {
    read -p "file to read input (stdin) (press return for none): " fname

    re='^([0-9]|[a-z]|[A-Z]|[/\._]|[+-/])*$'
    if ! [[ $fname =~ $re ]]; then
        echo "__INVALID__ARGS__"
        return
    fi
    echo "$fname"
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


    trap "" INT QUIT TSTP
    if [ "$redir" = "" ]; then
        $scriptpath/modbus-tcp-client-shm ${args}
    else
        $scriptpath/modbus-tcp-client-shm ${args} > $redir
    fi
    trap - INT QUIT TSTP
}

function manual_modbus_rtu_client_shm {
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

    trap "" INT QUIT TSTP
    if [ "$redir" = "" ]; then
        $scriptpath/modbus-rtu-client-shm ${args}
    else
        $scriptpath/modbus-rtu-client-shm ${args} > $redir
    fi
    trap - INT QUIT TSTP
}

function manual_dump_shm {
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

    trap "" INT QUIT TSTP
    if [ "$redir" = "" ]; then
        $scriptpath/dump-shm ${args}
    else
        $scriptpath/dump-shm ${args} > $redir
    fi
    trap - INT QUIT TSTP
}

function manual_write_shm {
    scriptpath=$1

    args=$(read_command_line_args)
    if [ "$args" = "__INVALID__ARGS__" ]; then
        echo "Invalid characters in argument"
        return
    fi

    input=$(read_input_file)
    if [ $"redir" == "__INVALID__ARGS__" ]; then
        echo "Invalid characters in redirection target"
        return
    fi

    redir=$(read_redirect_file)
    if [ $"redir" == "__INVALID__ARGS__" ]; then
        echo "Invalid characters in redirection target"
        return
    fi

    trap "" INT QUIT TSTP
    if [ "$redir" = "" ]; then
        if [ "$input" == "" ]; then
            $scriptpath/write-shm ${args}
        else
            $scriptpath/write-shm ${args} < $input
        fi
    else
        if [ "$input" == "" ]; then
            $scriptpath/write-shm ${args} > $redir
        else
            $scriptpath/write-shm ${args} < $input > $redir
        fi
    fi
    trap - INT QUIT TSTP
}

function manual_shared_mem_random {
    scriptpath=$1

    args=$(read_command_line_args)
    if [ "$args" = "__INVALID__ARGS__" ]; then
        echo "Invalid characters in argument"
        return
    fi

    trap "" INT QUIT TSTP
    $scriptpath/shared-mem-random ${args}
    trap - INT QUIT TSTP
}

function manual_stdin_to_modbus_shm {
    scriptpath=$1

    args=$(read_command_line_args)
    if [ "$args" = "__INVALID__ARGS__" ]; then
        echo "Invalid characters in argument"
        return
    fi

    input=$(read_input_file)
    if [ $"redir" == "__INVALID__ARGS__" ]; then
        echo "Invalid characters in redirection target"
        return
    fi

    trap "" INT QUIT TSTP
    if [ "$input" == "" ]; then
        $scriptpath/stdin-to-modbus-shm ${args}
    else
        $scriptpath/stdin-to-modbus-shm ${args} < $input
    fi
    trap - INT QUIT TSTP
}

