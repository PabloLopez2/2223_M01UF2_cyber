#!/bin/bash
<<<<<<< HEAD
 

if [ "$1" == "-h" ]
then

	SCRIPT=`basename $0`

	echo "Ejemplo de uso: "
	echo " $SCRIPT 127.0.0.1"
	exit 0
fi

IP_SERVER="localhost"
IP_LOCAL=`ip address | grep inet | grep enp0s3 | sed "s/^ *//g" | cut -d " " -f 2 | cut -d "/" -f 1`


PORT="4242"


if [ "$1" != "" ]
then 
	IP_SERVER=$1
	echo "IP del servidor: $IP_SERVER"
fi


echo "Cliente HMTP"

echo "(1) SEND - Enviando el Handshake"

MD5_IP=`echo $IP_LOCAL | md5sum | cut -d " " -f 1`

echo "GREEN_POWA $IP_LOCAL $MD5_IP" | nc $IP_SERVER $PORT

echo "(2) LISTEN - Escuchando confirmación"

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_HMTP" ]
then
	echo "ERROR 1: Handshake mal fomado"
	exit 1
fi

echo "(5) SEND - Enviamos el nombre de archivo"

FILE_NAME="elon_musk.jpg"

=======

IP_SERVER="localhost"
IP_LOCAL="127.0.0.1"
PORT="4242"
MD5_IP=`echo $IP_LOCAL | md5sum | cut -d " " -f 1`

echo "Cliente HMTP"

echo "(1) - ENVIANDO EL SALUDO"

echo "GREEN_POWA $IP_LOCAL $MD5_IP" | nc $IP_SERVER $PORT 

echo "(2) - RECIBIENDO CONFIRMACION"
MSG=`nc -l $PORT`

if [ "$MSG" != "OK_HMTP" ]
then 
	echo "ERROR 1:SALUDO MAL HECHO"
	exit 1
fi

echo "(5) - CONTANDO Y ENVIANDO CONTEO"

FILE_COUNT=`ls memes/ | wc -l`

echo "$FILE_COUNT" | nc $IP_SERVER $PORT

echo "(6) - ESCUCHANDO CONFIRMACION DE CONTEO"
MSG=`nc -l $PORT`

if [ "$MSG" != "OK_FILE_COUNT" ]
then 
	echo "ERROR 2: NUMERO ERRONEO"
	exit 2
fi

echo " "
for ((i=0; i<=$FILE_COUNT-1; i++))
do
FILE_NAME="ElonMusk$i.jpg"
echo "(9) - ENVIANDO MENSAJE"
>>>>>>> 5e0a2466fea26d89a8c8981a65cb28bc75dad761
FILE_MD5=`echo $FILE_NAME | md5sum | cut -d " " -f 1`

echo "FILE_NAME $FILE_NAME $FILE_MD5" | nc $IP_SERVER $PORT

<<<<<<< HEAD
echo "(6) LISTEN - Escuchando confirmación nombre archivo"

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: Nombre de archivo enviado incorrectamente"
	echo "	Mensaje de error: $MSG"

	exit 2
fi

echo "(9) SEND - Enviamos datos del archivo"

cat memes/$FILE_NAME | nc $IP_SERVER $PORT

echo "(10) LISTEN - Escuchamos confirmación datos archivo"
=======
echo "(10) - ESCUCHANDO"

MSG=`nc -l $PORT`
if [ "$MSG" != "OK_FILENAME" ]
then
	echo "ERROR 3: EL NOMBRE DEL ARCHIVO ES ERRONEO"
	echo "Mensaje de error: $MSG"
	exit 3
fi

echo "(13) - ENVIAMOS DATOS"

cat memes/$FILE_NAME | nc $IP_SERVER $PORT

DATA_MD5=`cat memes/$FILE_NAME | md5sum | cut -d " " -f 1`

echo "(14) - ESCUCHAMOS RESPUESTA" 
>>>>>>> 5e0a2466fea26d89a8c8981a65cb28bc75dad761

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_DATA_RCPT" ]
then
<<<<<<< HEAD
	echo "ERROR 3: Datos enviados incorrectamente"
	exit 3
fi


echo "(13) SEND - MD5 de los datos"

DATA_MD5=`cat memes/$FILE_NAME | md5sum | cut -d " " -f 1`

echo "DATA_MD5 $DATA_MD5" | nc $IP_SERVER $PORT

echo "(14) LISTEN - MD5 Comprobación"
=======
	echo "ERROR 4: DATOS INCORRECTOS"
	exit 4
fi

echo "(17) - ENVIAMOS CONFIRMACION DE ARCHIVO"

echo $DATA_MD5 | nc $IP_SERVER $PORT

echo "(18) - RECIBIMOS CONFIRMACION"
>>>>>>> 5e0a2466fea26d89a8c8981a65cb28bc75dad761

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_DATA_MD5" ]
then
<<<<<<< HEAD
	echo "ERROR 4: MD5 incorrecto"
	echo "	Mensaje de error: $MSG"
	exit 4
fi


echo "Fin del envío"

=======
	echo "ERROR 5: DATOS FALSOS"
	echo "MENSAJE DE ERROR: $MSG"
 	exit 5
fi
echo " "

done

echo "DATOS ENVIADOS CORRECTAMENTE"

echo "FIN DEL ENVIO"
>>>>>>> 5e0a2466fea26d89a8c8981a65cb28bc75dad761
exit 0
