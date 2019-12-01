#! /usr/bin/bash
printf "***\nchocolatey-install\n***"

# Name: make_install_executable
# Description: Make the install file executable for the user
# Note: Why? - Because I do not think ps1 files are executable by default. 
function make_install_executable() {
    printf "***make_install_executable***"
    chmod 755 $1
}

# Name: microphone_check
# Description: Sanity check; inspired by A Tribe Called Quest
function microphone_check() {
    printf $1
}
# Name: find_powershell_path
# Description: Find the powershell executable
# Return: (Not really) Return the found file path.
# Note: Kind of overkill. Maybe.
function find_powershell_path() {
    local powershell_path=$(which powershell)
    echo $powershell_path
}

function install_from_powershell() {
    printf "\n***install_from_powershell***\n"
    local powershell_path=$(find_powershell_path)
    $powershell_path "./$1"
}



microphone_check "\nMicrophone check; Yo, what is this?\n"
make_install_executable install.ps1
# I sense a miracle occurred in the area
install_from_powershell install.ps1