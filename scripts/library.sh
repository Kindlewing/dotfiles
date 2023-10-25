_isInstalledPacman() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

_isInstalledYay() {
    package="$1";
    check="$(yay -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# ------------------------------------------------------
# Function Install all package if not installed
# ------------------------------------------------------
_installPackagesPacman() {
    toInstall=();

    for pkg; do
        if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            echo "${pkg} is already installed.";
            continue;
        fi;

        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All pacman packages are already installed.";
        return;
    fi;

    printf "Packages not installed:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

_installPackagesYay() {
    toInstall=();

    for pkg; do
        if [[ $(_isInstalledYay "${pkg}") == 0 ]]; then
            echo "${pkg} is already installed.";
            continue;
        fi;

        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All packages are already installed.";
        return;
    fi;

    printf "AUR ackages not installed:\n%s\n" "${toInstall[@]}";
    yay --noconfirm -S "${toInstall[@]}";
}


# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------
_installSymLink() {
    name="$1"
    symlink="$2";
    linksource="$3";
    linktarget="$4";

    name="$1"
    symlink="$2"
    linksource="$3"
    linktarget="$4"

    if [ -L "${symlink}" ]; then
        rm "${symlink}"
        echo "Removed existing symlink: ${symlink}"
    elif [ -d "${symlink}" ]; then
        rm -rf "${symlink}"
        echo "Removed existing directory: ${symlink}"
    elif [ -f "${symlink}" ]; then
        rm "${symlink}"
        echo "Removed existing file: ${symlink}"
    fi

    ln -s "${linksource}" "${linktarget}"
    echo "Symlink for ${name}: ${linksource} -> ${linktarget} created."
}

_confirm_installation() {
    read -p "Do you want to install dotfiles? (Existing dotfiles will be removed!) (Yy/Nn): " yn
    case $yn in
        [Yy]* ) return 0 ;;
        [Nn]* ) return 1 ;;
        * ) echo "Please answer yes or no."; return 1 ;;
    esac
}
