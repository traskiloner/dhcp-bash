#!/bin/bash

ipred_ok=0
ipmask_ok=0
rango_min_ok=0
rango_max_ok=0
ipgw_ok=0
ipdns_ok=0
ruta_dhcp="/etc/default/isc-dhcp-server"
ruta_dhcpd="/etc/dhcp/dhcpd.conf"
#Nombre de la interfaz a configurar
#echo $1

function ip_valida()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

read -p "Introduzca la direccion de red: " valor

while [ $ipred_ok -ne 1 ]
do
	if ip_valida $valor
	then
		ipred=$valor
		ipred_ok=1
	else
		echo "Ha introducido una direccion de red invalida"
		read -p "Introduzca de nuevo la direccion de red: " valor
	fi
done


read -p "Introduzca la mascara de red: " valor

while [ $ipmask_ok -ne 1 ]
do
        if ip_valida $valor
        then
                ipmask=$valor
                ipmask_ok=1
        else
                echo "Ha introducido una mascara de red invalida"
                read -p "Introduzca de nuevo la mascara de red: " valor
        fi
done

read -p "Rango: Introduzca la direccion IP de inicio a ofrecer: " valor

while [ $rango_min_ok -ne 1 ]
do
        if ip_valida $valor
        then
                rango_min=$valor
                rango_min_ok=1
        else
                echo "Ha introducido una direccion IP de inicio invalida"
                read -p "Introduzca de nuevo la direccion IP de inicio a ofrecer: " valor
        fi
done

read -p "Rango: Introduzca la direccion IP maxima a ofrecer: " valor

while [ $rango_max_ok -ne 1 ]
do
        if ip_valida $valor
        then
                rango_max=$valor
                rango_max_ok=1
        else
                echo "Ha introducido una direccion IP maxima invalida"
                read -p "Introduzca de nuevo la direccion IP maxima a ofrecer: " valor
        fi
done

read -p "Introduzca la puerta de enlace: " valor

while [ $ipgw_ok -ne 1 ]
do
        if ip_valida $valor
        then
                ipgw=$valor
                ipgw_ok=1
        else
                echo "Ha introducido una direccion para la puerta de enlace invalida"
                read -p "Introduzca de nuevo la puerta de enlace: " valor
        fi
done

read -p "Introduzca la direccion de un servidor dns: " valor

while [ $ipdns_ok -ne 1 ]
do
        if ip_valida $valor
        then
                ipdns=$valor
                ipdns_ok=1
        else
                echo "Ha introducido un servidor dns invalido"
                read -p "Introduzca de nuevo un servidor dns: " valor
        fi
done

sed '$d' $ruta_dhcp > $ruta_dhcp
echo INTERFACES="$1" >> $ruta_dhcp
#echo "default-lease-time 600;" >> $ruta_dhcp
#echo "max-lease-time 7200;" >> $ruta_dhcp
echo "subnet" $ipred "netmask" $ipmask "{" >> $ruta_dhcpd
echo "range" $rango_min $rango_max ";" >> $ruta_dhcpd
echo "option routers" $ipgw ";" >> $ruta_dhcpd
echo "option subnet-mask" $ipmask ";" >> $ruta_dhcpd
echo "option domain-name-servers" $ipdns ";" >> $ruta_dhcpd
echo "}" >> $ruta_dhcpd

echo
echo "Se ha terminado de configurar su servidor DHCP"
echo "Ya debe ofrecer direcciones a través de " $1

./estados.sh reiniciar
