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

    if [[ -x "$scriptpath/modbus-tcp-client-shm" ]]; then
        exe="$scriptpath/modbus-tcp-client-shm"
    elif [[ -x "/bin/modbus-tcp-client-shm" ]]; then
        exe="/bin/modbus-tcp-client-shm"
    elif [[ -x "/usr/bin/modbus-tcp-client-shm" ]]; then
        exe="/usr/bin/modbus-tcp-client-shm"
    elif [[ -x "/snap/bin/shm-modbus.modbus-tcp-client-shm" ]]; then
        exe="/snap/bin/shm-modbus.modbus-tcp-client-shm"
    else
        exe="modbus-tcp-client-shm"
    fi

    if [ "$redir" = "" ]; then
        $exe ${args}
    else
        $exe ${args} > $redir
    fi
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

    if [[ -x "$scriptpath/modbus-rtu-client-shm" ]]; then
        exe="$scriptpath/modbus-rtu-client-shm"
    elif [[ -x "/bin/modbus-rtu-client-shm" ]]; then
        exe="/bin/modbus-rtu-client-shm"
    elif [[ -x "/usr/bin/modbus-rtu-client-shm" ]]; then
        exe="/usr/bin/modbus-rtu-client-shm"
    elif [[ -x "/snap/bin/shm-modbus.modbus-rtu-client-shm" ]]; then
        exe="/snap/bin/shm-modbus.modbus-rtu-client-shm"
    else
        exe="modbus-rtu-client-shm"
    fi

    if [ "$redir" = "" ]; then
        $exe ${args}
    else
        $exe ${args} > $redir
    fi
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

    if [[ -x "$scriptpath/dump-shm" ]]; then
        exe="$scriptpath/dump-shm"
    elif [[ -x "/bin/dump-shm" ]]; then
        exe="/bin/dump-shm"
    elif [[ -x "/usr/bin/dump-shm" ]]; then
        exe="/usr/bin/dump-shm"
    elif [[ -x "/snap/bin/shm-modbus.dump-shm" ]]; then
        exe="/snap/bin/shm-modbus.dump-shm"
    else
        exe="dump-shm"
    fi

    if [ "$redir" = "" ]; then
        $exe ${args}
    else
        $exe ${args} > $redir
    fi
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

    if [[ -x "$scriptpath/write-shm" ]]; then
        exe="$scriptpath/write-shm"
    elif [[ -x "/bin/write-shm" ]]; then
        exe="/bin/write-shm"
    elif [[ -x "/usr/bin/write-shm" ]]; then
        exe="/usr/bin/write-shm"
    elif [[ -x "/snap/bin/shm-modbus.write-shm" ]]; then
        exe="/snap/bin/shm-modbus.write-shm"
    else
        exe="write-shm"
    fi

    if [ "$redir" = "" ]; then
        if [ "$input" == "" ]; then
            $exe ${args}
        else
            $exe ${args} < $input
        fi
    else
        if [ "$input" == "" ]; then
            $exe ${args} > $redir
        else
            $exe ${args} < $input > $redir
        fi
    fi
}

function manual_shared_mem_random {
    scriptpath=$1

    args=$(read_command_line_args)
    if [ "$args" = "__INVALID__ARGS__" ]; then
        echo "Invalid characters in argument"
        return
    fi

    if [[ -x "$scriptpath/shared-mem-random" ]]; then
        exe="$scriptpath/shared-mem-random"
    elif [[ -x "/bin/shared-mem-random" ]]; then
        exe="/bin/shared-mem-random"
    elif [[ -x "/usr/bin/shared-mem-random" ]]; then
        exe="/usr/bin/shared-mem-random"
    elif [[ -x "/snap/bin/shm-modbus.shared-mem-random" ]]; then
        exe="/snap/bin/shm-modbus.shared-mem-random"
    else
        exe="shared-mem-random"
    fi

    $exe ${args}
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

    if [[ -x "$scriptpath/stdin-to-modbus-shm" ]]; then
        exe="$scriptpath/stdin-to-modbus-shm"
    elif [[ -x "/bin/stdin-to-modbus-shm" ]]; then
        exe="/bin/stdin-to-modbus-shm"
    elif [[ -x "/usr/bin/stdin-to-modbus-shm" ]]; then
        exe="/usr/bin/stdin-to-modbus-shm"
    elif [[ -x "/snap/bin/shm-modbus.stdin-to-modbus-shm" ]]; then
        exe="/snap/bin/shm-modbus.stdin-to-modbus-shm"
    else
        exe="stdin-to-modbus-shm"
    fi

    if [ "$input" == "" ]; then
        $exe ${args}
    else
        $exe ${args} < $input
    fi
}

function manual_signal_gen {
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

    if [[ -x "$scriptpath/signal-gen" ]]; then
        exe="$scriptpath/signal-gen"
    elif [[ -x "/bin/signal-gen" ]]; then
        exe="/bin/signal-gen"
    elif [[ -x "/usr/bin/signal-gen" ]]; then
        exe="/usr/bin/signal-gen"
    elif [[ -x "/snap/bin/shm-modbus.signal-gen" ]]; then
        exe="/snap/bin/shm-modbus.signal-gen"
    else
        exe="signal-gen"
    fi

    if [ "$redir" = "" ]; then
        $exe ${args}
    else
        $exe ${args} > $redir
    fi
}

function manual_wago_modbus_coupler_shm {
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

    if [[ -x "$scriptpath/wago-modbus-coupler-shm" ]]; then
        exe="$scriptpath/wago-modbus-coupler-shm"
    elif [[ -x "/bin/wago-modbus-coupler-shm" ]]; then
        exe="/bin/wago-modbus-coupler-shm"
    elif [[ -x "/usr/bin/wago-modbus-coupler-shm" ]]; then
        exe="/usr/bin/wago-modbus-coupler-shm"
    elif [[ -x "/snap/bin/shm-modbus.wago-modbus-coupler-shm" ]]; then
        exe="/snap/bin/shm-modbus.wago-modbus-coupler-shm"
    else
        exe="wago-modbus-coupler-shm"
    fi

    if [ "$redir" = "" ]; then
        $exe ${args}
    else
        $exe ${args} > $redir
    fi
}
