#!/bin/bash

read -p "Your email: " E
echo -ne "Your passwd: "
read -s P
echo
read -p "Recipient's email: " R
read -p "No. of spam msgs: " L
echo
echo "initiating..."
echo "Encoding the credentials in base64..."
A="\00"
F=$A$E$A$P
C=$(echo -ne $F | base64)

for (( i = 1; i <= $L; i++ )) 
#for i in {1.."$L"}
do
	trash=`tr -dc A-Za-z0-9 </dev/urandom | head -c 20`
	./maalik_mail_2.sh "$trash" "$i" "$C" "$R" "$E"
	sleep 2
done
