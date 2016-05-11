#!/bin/bash

#Comprobar si hay internet:

if ping -c3 google.com &>/dev/null;
then
        echo
	echo "Actualizando repositorios"

	aptitude update

	echo
	echo "Instalando isc-dhcp-server"
	aptitude install -y isc-dhcp-server

	read -p "¿Desea configurar el servidor DHCP ahora? (Si/No)" siono
#Convertir $siono a minusculas para evitar codigo
        opcion=$(echo "$siono" | tr '[:upper:]' '[:lower:]')

        case $opcion
        in
        "si")
                echo "Se va a configurar isc-dhcp-server"
                ./configuracion.sh
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
        echo "El script no consigue conectarse a internet, revise su configuración de red";
fi
