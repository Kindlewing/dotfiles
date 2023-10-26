_isInstalledPacman() {
	package="$1"
	check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
	if [ -n "${check}" ]; then
		echo 0 #'0' means 'true' in Bash
		return #true
	fi
	echo 1 #'1' means 'false' in Bash
	return #false
}

_isInstalledYay() {
	package="$1"
	check="$(yay -Qs --color always "${package}" | grep "local" | grep "${package} ")"
	if [ -n "${check}" ]; then
		echo 0 #'0' means 'true' in Bash
		return #true
	fi
	echo 1 #'1' means 'false' in Bash
	return #false
}

# ------------------------------------------------------
# Function Install all package if not installed
# ------------------------------------------------------
_installPackagesPacman() {
	toInstall=()

	for pkg; do
		if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
			echo "${pkg} is already installed."
			continue
		fi

		toInstall+=("${pkg}")
	done

	if [[ "${toInstall[@]}" == "" ]]; then
		# echo "All pacman packages are already installed.";
		return
	fi

	printf "Packages not installed:\n%s\n" "${toInstall[@]}"
	sudo pacman --noconfirm -S "${toInstall[@]}"
}

_installPackagesYay() {
	toInstall=()

	for pkg; do
		if [[ $(_isInstalledYay "${pkg}") == 0 ]]; then
			echo "${pkg} is already installed."
			continue
		fi

		toInstall+=("${pkg}")
	done

	if [[ "${toInstall[@]}" == "" ]]; then
		# echo "All packages are already installed.";
		return
	fi

	printf "AUR ackages not installed:\n%s\n" "${toInstall[@]}"
	yay --noconfirm -S "${toInstall[@]}"
}

# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------

_installSymLink() {
	name="$1"
	symlink="$2"
	linksource="$3"
	linktarget="$4"
	if [ -e "${linktarget}" ]; then
		echo "Target file '${linktarget}' already exists. Remove or backup it before creating a symbolic link."
	elif [ -L "${symlink}" ]; then
		rm ${symlink}
		ln -s ${linksource} ${linktarget}
		echo "Symlink ${linksource} -> ${linktarget} created."
		echo ""
	elif [ -d ${symlink} ]; then
		rm -rf ${symlink}/
		ln -s ${linksource} ${linktarget}
		echo "Symlink for directory ${linksource} -> ${linktarget} created."
		echo ""
	elif [ -f ${symlink} ]; then
		rm ${symlink}
		ln -s ${linksource} ${linktarget}
		echo "Symlink to file ${linksource} -> ${linktarget} created."
		echo ""
	else
		ln -s ${linksource} ${linktarget}
		echo "New symlink ${linksource} -> ${linktarget} created."
	fi
	echo "${name} successfully linked"
}
