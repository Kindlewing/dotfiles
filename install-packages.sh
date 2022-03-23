#!/bin/bash

linuxPackages=('stow' 'git' 'zathura' 'neovim')

# Check OS Type
function checkOSType() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        linuxPackageInstall
    else 
        macPackageInstall
    fi
}



function linuxPackageInstall() {
    sudo apt update -y
    echo ""
    echo ""

    echo "The following packages will be installed"
    echo ""
    echo ""

    echo "============================================="
    echo "============================================="   
    
    echo ""
    echo ""
     
    for package in ${linuxPackages[@]}; do
        echo ${package}
    done
    echo ""
    read -p "Do you wish to continue with installation? (y/n):" shouldInstall


    if [[ $shouldInstall == "y" ]]; then
        for package in ${linuxPackages[@]}; do
            sudo apt install $package -y  
        done
    else 
        echo "Quitting"
        exit 0
    fi
}


function macPackageInstall() {
    echo "Mac"
}

checkOSType
