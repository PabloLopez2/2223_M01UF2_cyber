#!/bin/bash
<<<<<<< HEAD

IP_LOCAL= ip address | grep inet | grep enp0s3 | sed "s/^ *//g" | cut -d " " -f 2 | cut -d "/" -f 1
echo "La IP del servidor es: $IP_LOCAL"

PORT="4242"

echo "Servidor HMTP"

echo "(0) LISTEN - Levantando el servidor"

MSG=`nc -l $PORT`

HANDSHAKE=`echo $MSG | cut -d " " -f 1`
IP_CLIENT=`echo $MSG | cut -d " " -f 2`
IP_CLIENT_MD5=`echo $MSG | cut -d " " -f 3`

echo "(3) SEND - Confirmación Handshake"

MD5_IP=`echo $IP_CLIENT | md5sum | cut -d " " -f 1`

if [ "$IP_CLIENT_MD5" != "$MD5_IP" ]
then
	echo "ERROR 1: IP mal formada"
	exit 1
fi

if [ "$HANDSHAKE" != "GREEN_POWA" ]
then
	echo "KO_HMTP" | nc $IP_CLIENT $PORT
	exit 1
fi

echo "OK_HMTP" | nc $IP_CLIENT $PORT

echo "(4) LISTEN - Escuchando el nombre de archivo"

MSG=`nc -l $PORT`

=======
PORT="4242"

echo "Servidor HMTP" 

echo "(0) - LEVANTANDO EL SERVIDOR"
MSG=`nc -l $PORT`
SALUDO=`echo $MSG | cut -d " " -f 1`
IP_CLIENTE=`echo $MSG | cut -d " " -f 2`
MD5_CLIENTE=`echo $MSG | cut -d " " -f 3`
MD5_IP=`echo $IP_CLIENTE | md5sum | cut -d " " -f 1`

echo "(3) - ENVIANDO CONFIRMACION"
if [ "$MD5_IP" != "$MD5_CLIENTE" ]
then
echo "ERROR 1: IP MALA" 
exit 1
fi

if [ "$SALUDO" != "GREEN_POWA" ]
then
	echo "KO_HMTP" | nc $IP_CLIENTE $PORT
	exit 1
fi

echo "OK_HMTP" | nc $IP_CLIENTE $PORT

echo "(4) - ESCUCHANDO"

MSG=`nc -l $PORT`
FILE_COUNT=`echo $MSG`

if [ "$MSG" != "$FILE_COUNT" ]
then
	echo "KO_FILE_COUNT" | nc $IP_CLIENTE $PORT
	exit 2
fi
	echo "OK_FILE_COUNT" | nc $IP_CLIENTE $PORT
	echo ""

echo "(7) - ENVIANDO CONFIRMACION DE CONTEO"

for ((i=0; i<=$FILE_COUNT-1; i++))
do

echo "(8) - ESCUCHANDO"

MSG=`nc -l $PORT`
>>>>>>> 5e0a2466fea26d89a8c8981a65cb28bc75dad761
PREFIX=`echo $MSG | cut -d " " -f 1`
FILE_NAME=`echo $MSG | cut -d " " -f 2`
FILE_MD5=`echo $MSG | cut -d " " -f 3`

<<<<<<< HEAD
echo "(7) SEND - Confirmación nombre de archivo"

if [ "$PREFIX" != "FILE_NAME" ]
then
	echo "KO_FILE_NAME" | nc $IP_CLIENT $PORT
	exit 2
fi

=======
echo "(11) - ENVIANDO CONFIRMACION"
if [ "$PREFIX" != "FILE_NAME" ]
then
	echo "KO_FILENAME" | nc $IP_CLIENTE $PORT
	exit 3
fi


>>>>>>> 5e0a2466fea26d89a8c8981a65cb28bc75dad761
MD5SUM=`echo $FILE_NAME | md5sum | cut -d " " -f 1`

if [ "$MD5SUM" != "$FILE_MD5" ]
then
<<<<<<< HEAD
	echo "KO_FILE_MD5" | nc $IP_CLIENT $PORT
	exit 3
fi

echo "OK_FILE_NAME" | nc $IP_CLIENT $PORT

echo "(8) LISTEN - Escuchando datos de archivo"

nc -l $PORT > inbox/$FILE_NAME

echo "(11) SEND - Confirmación recepción datos"

echo "OK_DATA_RCPT" | nc $IP_CLIENT $PORT

echo "(12) LISTEN - MD5 de los datos"

MSG=`nc -l $PORT`

PREFIX=`echo $MSG | cut -d " " -f 1`
DATA_MD5=`echo $MSG | cut -d " " -f 2`

if [ "$PREFIX" != "DATA_MD5" ]
then
	echo "KO_MD5_PREFIX" | nc $IP_CLIENT $PORT
	exit 4
fi


FILE_MD5=`cat inbox/$FILE_NAME | md5sum | cut -d " " -f 1`

if [ "$DATA_MD5" != "$FILE_MD5" ]
then
	echo "KO_DATA_MD5" | nc $IP_CLIENT $PORT
	exit 5
fi

echo "OK_DATA_MD5" | nc $IP_CLIENT $PORT

echo "Fin de la recepción"
=======
	echo "KO_FILE_MD5" | nc $IP_CLIENTE $PORT
	exit 4
fi

echo "OK_FILENAME" | nc $IP_CLIENTE $PORT

echo "(12) - ESCUCHAMOS ARCHIVO"

nc -l $PORT > inbox/$FILE_NAME

DATA_MD5=`cat inbox/$FILE_NAME | md5sum | cut -d " " -f 1`
echo "(15) - ENVIAR CONFIRMCION" 

echo "OK_DATA_RCPT" | nc $IP_CLIENTE $PORT

echo "(16) - ESCUCHANDO CONFIRMACION DE ARCHIVO"

MSG=`nc -l $PORT`
if [ "$MSG" != "$DATA_MD5" ]
then
	echo "KO_DATA_MD5" | nc $IP_CLIENTE $PORT
	exit 5
fi
	echo "OK_DATA_MD5" | nc $IP_CLIENTE $PORT
	echo " "

done

COUNT=`ls inbox/ | wc -l`

if [ "$COUNT" != "$FILE_COUNT" ]
then
	echo "DATOS PERDIDOS, SE HAN RECIBIDO UN TOTAL DE $COUNT ARCHIVOS"
	exit 6
fi

echo "DATOS RECIBIDOS CORRECTAMENTE"

echo "FIN DE LA RECEPCION"
>>>>>>> 5e0a2466fea26d89a8c8981a65cb28bc75dad761

exit 0
