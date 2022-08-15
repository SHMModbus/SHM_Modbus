#!/bin/bash

function check_reg_count {
    MAX_REG=65536
    MIN_REG=0

    reg_count=$1

    re='^[0-9]+$'
    if ! [[ $reg_count =~ $re ]]; then
        echo "Not a number"
        return
    fi

    if [ $reg_count -gt $MAX_REG ]; then
        echo "To manny registers"
        return
    fi

    if [ $reg_count -lt $MIN_REG ]; then
        echo "To few registers"
        return
    fi 

    echo ""
}

function read_reg_count {
    reg_type=$1
    err_msg=""

    while true; do
        read -p "${err_msg}Number of $reg_type registers: [65536] " num_regs
        if [ "$num_regs" == "" ]; then
            num_regs="65536"
        fi

        check=$(check_reg_count $num_regs)
        if [ "$check" != "" ]; then
            err_msg="${check}. Try again. "
        else
            break;
        fi
    done

    echo $num_regs
}

function guided_modbus_tcp_client_shm {
    scriptpath=$1

    # port
    while true; do
        read -p "Modbus TCP Client port: [502] " port
        if  [ "$port" = "" ]; then
            port="502"
        fi

        re='^[0-9]+$'
        if ! [[ $port =~ $re ]]; then
            echo "Not a number."
            continue
        fi

        break
    done

    # ip
    read -p "Modbus TCP Client listen IP: [0.0.0.0] " listen_ip
    if  [ "$listen_ip" = "" ]; then
        listen_ip="0.0.0.0"
    fi 

    # name prefix
    read -p "Modbus Shared memory name prefix: [modbus_] " name_prefix
    if  [ "$name_prefix" = "" ]; then
        name_prefix="modbus_"
    fi 

    # register count
    do_regs=$(read_reg_count "DO")
    di_regs=$(read_reg_count "DI")
    ao_regs=$(read_reg_count "AO")
    ai_regs=$(read_reg_count "AI")

    # monitor
    while true; do
        read -p "Output modbus telegrams to stdout: [y/N] " yn
        if [ "$yn" == "" ]; then
            yn="N"
        fi
        case $yn in
            [Yy]* ) monitor="true"; break;;
            [Nn]* ) monitor="false"; break;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done

    # reconnect
    while true; do
        read -p "Terminate if master disconnects: [y/N] " yn
        if [ "$yn" == "" ]; then
            yn="N"
        fi
        case $yn in
            [Yy]* ) reconnect="false"; break;;
            [Nn]* ) reconnect="true"; break;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done
    
    # force shm
    while true; do
        read -p "Overwrite existing shared memory: [y/N] " yn
        if [ "$yn" == "" ]; then
            yn="N"
        fi
        case $yn in
            [Yy]* ) force_shm="true"; break;;
            [Nn]* ) force_shm="false"; break;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done

    # print summary
    echo "The following settings were input:"
    echo "  -           Port: $port"
    echo "  -             IP: $listen_ip"
    echo "  -   DO registers: $do_regs"
    echo "  -   DI registers: $di_regs"
    echo "  -   AO registers: $ao_regs"
    echo "  -   AI registers: $ai_regs"
    echo "  - reconnect mode: $reconnect"
    echo "  -   monitor mode: $monitor"
    echo "  -      force shm: $force_shm"

    while true; do
        read -p "Do you want to start the modbus client? [Y/n] " yn
        if [ "$yn" == "" ]; then
            yn="Y"
        fi
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) return;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done

    # create flags
    if [ "$force_shm" == "true" ]; then
        force_shm="--force"
    else
        force_shm=""
    fi

    if [ "$monitor" == "true" ]; then
        monitor="--monitor"
    else
        monitor=""
    fi

    if [ "$reconnect" == "true" ]; then
        reconnect="--reconnect"
    else
        reconnect=""
    fi

    #ececute
    $scriptpath/modbus-tcp-client-shm --ip $listen_ip --port $port --name-prefix $name --do-registers $do_regs --di-registers $di_regs --ao-registers $ao_regs --ai-registers $ai_regs $force_shm $reconnect $monitor
}

function guided_modbus_rtu_client_shm {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

function guided_dump_shm {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

function guided_write_shm {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

function guided_shared_mem_random {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

function guided_stdin_to_modbus_shm {
    scriptpath=$1

    echo "${FUNCNAME[0]}"
}

