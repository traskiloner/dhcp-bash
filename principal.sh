#!/bin/bash

if [ "$EUID" != "0" ];
then
	echo "Debe ejecutar este script como root"
else
	echo "Menú para la configuración de un servidor DHCP:"
	echo
fi

