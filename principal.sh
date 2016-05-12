#!/bin/bash

clear

repetir=1

if [ "$EUID" != "0" ]
then
	echo "Debe ejecutar este script como root"
else
	echo "Para un correcto funcionamiento se debe ejecutar desde el directorio de su extracción"
	echo
	echo "Menú para la configuración de un servidor DHCP:"
	echo

	while [ $repetir -eq 1 ]
	do
		echo "Introduzca 1 para instalar un servidor DHCP"
		echo
		echo "Introduzca 2 para configurar el servidor DHCP"
		echo
		echo "Introduzca 3 para comprobar el estado del servidor DHCP"
		echo
		echo "Introduzca 4 para salir del script"
		read -p "¿Que opción elige?: " opcion
		case $opcion
		in
		"1")
			echo "Ha elegido instalar un servidor DHCP"
			./comprobacion.sh
		;;
		"2")
			echo "Ha elegido configurar el servidor DHCP"
			./configuracion.sh
		;;
		"3")
			echo "Ha elegido comproba el estado del servidor DHCP"
			./estados.sh
		;;
		"4")
			echo "¡Hasta pronto!"
			repetir=0
		;;
		*)
			echo
			echo "No ha introducido un valor correcto"
			echo
		esac
	done
fi
