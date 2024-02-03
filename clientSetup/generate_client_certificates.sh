client_name=$1

#Checking if a client name has been provided
if [ -z  "$client_name" ]
then
  echo Please enter a client name as the argument.
  exit 1 
fi

#Preparing to generate key
echo Changing directories and sourcing  
cd /etc/openvpn/easyrsa/
source ./vars
echo Generating keys

#Key Generation
(echo -en "\n\n\n\n\n\n" ; sleep 1; echo -n "$client_name"; echo -en "\n"; sleep 1; echo -en "\n"; sleep 1; echo -en "\n"; sleep 1; echo -en "\n"; sleep 3; echo -en "yes"; echo -en "\n"; sleep 3; echo -en "yes"; echo -en "\n";) | ./build-key $client_name

# Making a tar file
mkdir temp_$client_name
cp keys/ca.crt keys/$client_name.crt keys/$client_name.key temp_$client_name
tar -czf ~/client/certs_$client_name.tar.gz temp_$client_name
rm -rf temp_$client_name
echo Client keys generated. ~/client/certs_$client_name.tar.gz
