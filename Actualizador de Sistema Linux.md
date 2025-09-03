# Actualizador de Sistema Linux

Este script Bash automatiza la actualización y limpieza de sistemas Linux, detectando la distribución y ejecutando los comandos apropiados para mantener tu sistema al día.  
**Autor:** Javier J. Tapia  
**Año de creación:** 2021

---

## Descripción

El script identifica la distribución de Linux instalada y ejecuta los comandos de actualización y limpieza correspondientes. Es útil para administradores y usuarios que desean mantener su sistema actualizado de forma sencilla y rápida.

---

## Uso

1. **Descarga el script** y guárdalo en tu máquina.
2. **Dale permisos de ejecución:**
   ```bash
   chmod +x actualizador.sh
   ```
3. **Ejecuta el script como root o usando sudo:**
   ```bash
   sudo ./actualizador.sh
   ```

---

## Etapas del Script

### 1. Comprobación de permisos

Verifica si el script se ejecuta como usuario root. Si no es así, muestra un mensaje y termina la ejecución.

```bash
if [ "$EUID" -ne 0 ]; then
  echo "Por favor ejecuta este script como root o usa sudo."
  exit 1
fi
```

### 2. Detección de la distribución

Lee el archivo `/etc/os-release` para identificar la distribución de Linux instalada.

```bash
distro=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
```

### 3. Actualización y limpieza según la distribución

Utiliza un bloque `case` para ejecutar los comandos adecuados:

- **Debian/Ubuntu/Kali:**  
  Usa `apt` para actualizar, limpiar y eliminar paquetes innecesarios.
- **Fedora:**  
  Usa `dnf upgrade`.
- **CentOS/RHEL/Rocky/AlmaLinux/Oracle Linux:**  
  Usa `dnf` o `yum` según disponibilidad.
- **openSUSE:**  
  Usa `zypper`.
- **Arch/Manjaro:**  
  Usa `pacman`.
- **Otros:**  
  Muestra un mensaje de error y termina.

### 4. Mensajes de estado

El script muestra mensajes informativos antes y después de la actualización.  
*Nota:* Las variables de color están comentadas, pero puedes activarlas descomentando las líneas correspondientes.

### 5. Finalización

Al terminar, muestra un mensaje indicando que la actualización y limpieza han sido completadas.

---

## Personalización

Si deseas que los mensajes tengan color, descomenta las siguientes líneas al inicio del script:

```bash
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)
```

---

## Licencia

Este script se distribuye bajo la licencia MIT.

---

**Javier J. Tapia -