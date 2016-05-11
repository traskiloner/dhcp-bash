#!/bin/bash

#Comprobación de si está instalado isc-dhcp-server
esp="Estado: sin instalar"
ing="State: not installed"

estado=$(aptitude show isc-dhcp-server | grep -iE '(estado|state)')

#Añadir a la condición el valor en ingles:

if [[ $estado =~ $esp|$ing ]]
then
	echo "El programa no se encuentra instalado"
	echo
	read -p "¿Desea instalarlo? (Si/No)" siono

#Convertir $siono a minusculas para evitar codigo
	opcion=$(echo "$siono" | tr '[:upper:]' '[:lower:]')

	case $opcion
	in
	"si")
		echo "Se va a instalar isc-dhcp-server"
		./instalacion.sh
	;;
	"no")
		echo "Regresamos al menú"
	;;
	*)
		echo "No ha introducido una opción correcta"
		echo "Regresando al menú principal"
		sleep 1
	;;
	esac
else
	echo "El servidor DHCP ya se encuentra instalado"
fi
