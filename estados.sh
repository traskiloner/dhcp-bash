#!/bin/bash
if [[ -z $1 ]]
then
	if [[ "$1" == "reiniciar" ]]
	then
		systemctl restart isc-dhcp-server.service
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
                        echo "Ha elegido iniciar el servidor DHCP"
                        ./comprobacion.sh
			systemctl start isc-dhcp-server.service
                ;;
                "2")
                        echo "Ha elegido detener el servidor DHCP"
			./comprobacion.sh
			systemctl stop isc-dhcp-server.service
                ;;
                "3")
                        echo "Ha elegido comprobar el estado del servidor DHCP"
			./comprobacion.sh
			systemctl status isc-dhcp-server.service
                ;;
		"4")
			echo "Ha elegido reiniciar el servidor DHCP"
			./comprobacion.sh
			systemctl restart isc-dhcp-server.service
		;;
                "5")
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





