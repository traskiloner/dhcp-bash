#!/bin/bash
if [[ $1 ]]
then
	if [[ "$1" == "reiniciar" ]]
	then
#		systemctl restart isc-dhcp-server.service
		service isc-dhcp-server restart
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
#			systemctl start isc-dhcp-server.service
			service isc-dhcp-server start
                ;;
                "2")
                        echo "Deteniendo servicio"
			./comprobacion.sh
#			systemctl stop isc-dhcp-server.service
			service isc-dhcp-server stop
                ;;
                "3")
                        echo "Comprobando servicio"
			./comprobacion.sh
#			systemctl status isc-dhcp-server.service
			service isc-dhcp-server status
                ;;
		"4")
			echo "Reiniciando servicio"
			./comprobacion.sh
#			systemctl restart isc-dhcp-server.service
			service isc-dhcp-server restart
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





