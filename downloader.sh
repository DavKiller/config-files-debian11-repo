#!/bin/bash
# DavKiller
clear

# Localizacion del directorio de descarga de los paquetes Debian
R_PACK="/var/www/repo"
R_REPO="/var/packages/debian"
CODENAME="testing"
# Variable donde almacenamos los colores que usaremos en el script, en erorres y avisos.
RESTORE='\033[0m'
RED='\033[01;31m'
GREEN='\033[00;32m'
BLUE='\033[01;32m'
YELLOW='\033[01;33m'

# Comprobamos que se ha introducido como minimo un parametro.
if [ -z $1 ]; then 
	echo -e "${RED}Debe pasar como minimo un parametro para continuar. ${RESTORE}"
	exit 1
fi

# Creamos un bucle para poder pasar varios parametros al script.
for PACK in "$@"
do

#Guardamos la busqueda en una variable, si no encuentra el paquete el resultado de busqueda sera un string de 0 caracteres.
BUSQUEDA=$(apt search $PACK 2>/dev/null | cut -d/ -f1  | grep -x "$PACK")

# Si el parametro no existe en el repositorio de Debian, se muestra un aviso y se sale del script.
if [ -z $BUSQUEDA ]; then
	echo -e "${YELLOW}El paquete $PACK no existe o el nombre del paquete es incorrecto.${RESTORE}"
	exit 1

# Si el parametro es correcto, comienza a descargar el paquete.
elif [ $BUSQUEDA != "" ]; then
	echo -e "${GREEN}El paquete $BUSQUEDA ha sido encontrado para su descarga.${RESTORE}"
	cd $R_PACK
	apt-get download $BUSQUEDA
	apt-get download -q $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances --no-pre-depends $BUSQUEDA | grep "^\w" )	
echo -e "El paquete ${BLUE}$BUSQUEDA${RESTORE} ha sido descargado." 
fi 
done

# Una vez terminado el bucle se añaden al repositorio local los paquetes descargados.
echo -e "Añadiendo al repositorio el/los paquetes..."
	cd $R_REPO 
	# Testing es la rama que he usado para la creacion del repositorio de prueba.
	# Si se ha creado con el codename bullseye se debera cambiar el nombre de testing a bullseye en la variable del script para su funcionamiento.
	reprepro -s includedeb $CODENAME $R_PACK/*.deb 2>skip-error.txt
rm skip-error.txt
