set -e
cd certs
./gencerts.sh
#./genkeystores.sh
openssl pkcs12 \
 -export \
 -legacy \
 -in ./client/client.pem \
 -passout pass:pass \
 -inkey ./client/client.key \
 -out ./client/keystore.p12 \
 -name "DolphinKeystore"
cd ..
sudo systemctl restart haproxy
sudo docker build -t test:v1 .
# -Djavax.net.ssl.keyStorePassword=123456
# all
# -Djavax.net.debug=ssl
sudo docker run -e \
	JAVA_OPTS='-Djavax.net.debug=ssl,keymanager -Djavax.net.ssl.keyStore=/app/security/keystore.p12 -Djavax.net.ssl.keyStoreType=pkcs12 -Djavax.net.ssl.keyStorePassword=pass' \
	--add-host=bridge.spaceship:192.168.217.141 \
	--hostname dolphin.spaceship \
	--network="host" -it test:v1 https://bridge.spaceship/