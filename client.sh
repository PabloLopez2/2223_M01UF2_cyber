#!/bin/bash

echo "Cliente HMTP"

echo "(1) SEND - Enviando el handshake"
echo "GREEN_POWA 127.0.0.1" | nc localhost 4242

echo "(2) LISTEN - Escuchando confirmación"
MSG=`nc -l 4242`

echo $MSG

if [ "$MSG" != "OK_HMTP" ]
then 
	echo "ERROR 1: Hamshake mal formado"
	exit 1
fi
	
