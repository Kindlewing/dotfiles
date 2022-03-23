#!/bin/bash


linuxPackages=('stow' 'git' 'zathura' 'neovim')

# Check OS Type
function checkOSType() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        linuxPackageInstall()
}


function linuxPackageInstall() {
    sudo apt update -y
    echo "The following packages will be installed"

    for package in ${linuxPackages}; do
        echo ${package}
    done

    read "Do you wish to continue with installation? (y/n)" shouldInstall

    if [ $shouldInstall == 'y' ]; then
        for package in ${linuxPackages}; do
            sudo apt install $package -y  
        done
    else 
        echo "Quitting"
        exit 0
    fi
}

checkOSType()
