#!/bin/bash
distro=$(lsb_release -r | grep -i Release | cut -d : -f 2 | cut -c 2)

if [ $distro -eq 8 ]
then
#debian jessie
	detener='systemctl stop isc-dhcp-server'
	reiniciar='systemctl restart isc-dhcp-server'
	iniciar='systemctl start isc-dhcp-server'
	estado='systemctl status isc-dhcp-server'

elif [ $distro -eq 7 ]
then
#debian wheezy
        detener='service isc-dhcp-server stop'
        reiniciar='service isc-dhcp-server restart'
        iniciar='service isc-dhcp-server start'
        estado='service isc-dhcp-server status'
fi

if [[ $1 ]]
then
	if [[ "$1" == "reiniciar" ]]
	then
		echo "Reiniciando servicio"
		$reiniciar
	fi
fi

repetir=1

while [ $repetir -eq 1 ]
do
	echo "Introduzca 1 para iniciar el servidor DHCP"
        echo
        echo "Introduzca 2 para detener el servidor DHCP"
        echo
        echo "Introduzca 3 para comprobar el estado actual del servidor DHCP"
	echo
	echo "Introduzca 4 para reiniciar el servidor DHCP"
        echo
        echo "Introduzca 5 para regresar al menú principal"
                read -p "¿Que opción elige?: " opcion
                case $opcion
                in
                "1")
                        echo "Iniciando servicio"
                        ./comprobacion.sh
			$iniciar
                ;;
                "2")
                        echo "Deteniendo servicio"
			./comprobacion.sh
			$detener
                ;;
                "3")
                        echo "Comprobando servicio"
			./comprobacion.sh
			$estado
                ;;
		"4")
			echo "Reiniciando servicio"
			./comprobacion.sh
			$reiniciar
		;;
                "5")
                        echo "¡Hasta pronto!"
                        repetir=0
                ;;
                *)
                        echo
                        echo "No ha introducido un valor correcto"
                        echo
		;;
                esac
        done
fi





