#!/bin/bash

# Colores para mensajes
#green=$(tput setaf 2)
#yellow=$(tput setaf 3)
#reset=$(tput sgr0)

# Comprobar si el script se está ejecutando como root
if [ "$EUID" -ne 0 ]; then
  echo "${yellow}==>${reset} Por favor ejecuta este script como root o usa sudo."
  exit 1
fi

# Detectar la distribución
distro=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
case $distro in
  ubuntu|debian)
    echo "${yellow}==>${reset} Actualizando sistema para Debian/Ubuntu..."
    apt update && apt full-upgrade -y && apt autoclean -y && apt autoremove -y
    ;;
  kali|debian)
    echo "${yellow}==>${reset} Actualizando sistema para Debian/Ubuntu..."
    apt update && apt full-upgrade -y && apt autoclean -y && apt autoremove -y
    ;;
  fedora)
    echo "${yellow}==>${reset} Actualizando sistema para Fedora..."
    dnf upgrade --refresh -y
    ;;
  centos|rhel|rocky|almalinux|ol)
    echo "${yellow}==>${reset} Actualizando sistema para CentOS/RHEL/Oracle Linux..."
    if command -v dnf >/dev/null 2>&1; then
      dnf update -y && dnf clean all
    else
      yum update -y && yum clean all
    fi
    ;;
  suse|opensuse-leap|opensuse-tumbleweed)
    echo "${yellow}==>${reset} Actualizando sistema para openSUSE..."
    zypper refresh && zypper update -y
    ;;
  arch|manjaro)
    echo "${yellow}==>${reset} Actualizando sistema para Arch/Manjaro..."
    pacman -Syu --noconfirm
    ;;
  *)
    echo "${yellow}==>${reset} Distribución no soportada o desconocida: $distro"
    exit 1
    ;;
esac

# Mensaje final
echo "${green}==>${reset} Actualización y limpieza completadas para $distro."
