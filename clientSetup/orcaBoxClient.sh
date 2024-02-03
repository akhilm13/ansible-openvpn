# Generating certificates

client_name=$1

#Checking if a client name has been provided
if [ -z  "$client_name" ]
then
  echo Please enter a client name as the argument.
  exit 1
fi

mkdir -p ~/clientOrcaBox

#Preparing to generate key
echo Changing directories and sourcing
cd /etc/openvpn/easyrsa/
source ./vars
echo Generating keys

#Key Generation
(echo -en "\n\n\n\n\n\n" ; sleep 1; echo -n "$client_name"; echo -en "\n"; sleep 1; echo -en "\n"; sleep 1; echo -en "\n"; sleep 1; echo -en "\n"; sleep 3; echo -en "yes"; echo -en "\n"; sleep 3; echo -en "yes"; echo -en "\n";) | ./build-key $client_name

#Generating ovpn file
cd /etc/openvpn/easyrsa/
mkdir certs_$client_name
mkdir certs_$client_name/certs
cp /etc/openvpn/client.tmp certs_$client_name/"$client_name".ovpn


# Making a tar file

cp keys/ca.crt keys/$client_name.crt keys/$client_name.key ./../keys/vpn.tlsauth certs_$client_name/certs
tar -czf ~/clientOrcaBox/certs_$client_name.tar.gz certs_$client_name
rm -rf certs_$client_name
echo Client keys generated. ~/clientOrcaBox/certs_$client_name.tar.gz
