#!/bin/bash

IP_SERVER="localhost"
IP_LOCAL="127.0.0.1"

PORT="4242"

echo "Cliente HMTP"

echo "(1) SEND - Enviando el Handshake"

echo "GREEN_POWA $IP_LOCAL" | nc $IP_SERVER $PORT

echo "(2) LISTEN - Escuchando confirmación"

echo "(1) SEND - Enviando el handshake"

echo "GREEN_POWA $IP_LOCAL" | nc $IP_SERVER $PORT

echo "(2) LISTEN - Escuchando confirmación"

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_HMTP" ]
then 
	echo "ERROR 1: Hamshake mal formado"
	exit 1
fi

echo "(5) SEND - Enviamos el archivo"

FILE_NAME="elon_musk.jpg"	

FILE_MD5=`echo $FILE_NAME | md5sum | cut -d " " -f 1`

echo "FILE_NAME $FILE_NAME $FILE_MD5" | nc $IP_SERVER $PORT

echo "(6) LISTEN - Escuchando confirmación nombre archivo"

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_FILE_NAME" ]
then 
	echo "ERROR 2: Nombre de archivo enviado incorrectamente"

	echo "Mensaje de error: $MSG"

	exit 2 
fi

echo "(9) SEND - Enviamos datos del archivo"

cat memes/$FILE_NAME | nc $IP_SERVER $PORT

echo "(10) LISTEN - Escuchamos confirmación del archivo"

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_DATA_RCPT" ]
then 
	echo "ERROR 3: Datos enviados incorrectamente"
	exit 3
fi

echo "Fin del envío"

exit 0

echo "(13) SEND - MD5 de los datos" 

DATA_MD5=`cat memes/$FILE_NAME | md5sum | cut -d " " -f 1`

echo "DATA_MD5 $DATA_MD5" | nc $IP_SERVER $PORT

echo "(14) LISTEN - MD5 Comprobación"

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_DATA_MD5" ]
then
	echo "ERROR 4: MD5 incorrecto"
	echo "Mensaje de error: $MSG"
	exit 4
fi

echo "Fin del envío"

exit 0

