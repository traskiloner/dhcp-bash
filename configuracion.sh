#!/bin/bash

correcto=0

#Comprobación de que está instalado isc-server-dhcp
./comprobacion.sh

# Para ver las tarjetas de red disponibles
tarjetas=$(ip l | grep 'eth[0-9]' | cut -d : -f 2)

for tarjeta in $tarjetas
do
	echo "Nombre de la tarjeta: " $tarjeta
done

read -p "Escriba el nombre de la tarjeta de red por la cual quiere ofrecer direcciones: " seleccionada

while [ $correcto -ne 1 ]
do

	for tarjeta in $tarjetas
	do
		if [[ $seleccionada == $tarjeta ]]
			then
				correcto=1
			fi
	done
	if [ $correcto -ne 1 ]
	then
		echo
		echo "Ha escrito mal el nombre"
		echo
		read -p "Escriba de nuevo el nombre de la tarjeta de red por la cual quiere ofrecer direcciones: " seleccionada
	fi
done

echo "Ha seleccionado una tarjeta correctamente"

./parametros.sh $seleccionada
