#!/bin/bash

echo_bold() {
    echo -e "\033[1m$@\033[0m"
}

echo_red() {
    echo -e "\033[1;31m$@\033[0m"
}

echo_green_bold() {
    echo -e "\033[1;32m$@\033[0m"
}

echo_yellow() {
    echo -e "\033[1;33m$@\033[0m"
}

echo_and_run() {
    echo "$*" ;
    eval "$*" ;
}

echo_green() {
    echo -e "\033[0;32m$@\033[0m"
}