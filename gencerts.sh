set -e
# Clean
rm -rf ca
rm -rf server
rm -rf client
rm -f spaceship.pem

# CA (spaceship)
openssl genrsa -out ca.key 4096
openssl req -x509 -new -noenc -key ca.key -days 3650 -config spaceship.conf -out ca.pem -extensions extensions
# echo "A"
# read

# Server (bridge.spaceship)
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr -config bridge.conf -reqexts extensions
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out server.crt -days 365 -copy_extensions=copy
# echo "B"
# read

# Client (dolphin.spaceship)
openssl genrsa -out client.key 4096
openssl req -new -key client.key -out client.csr -config dolphin.conf -reqexts extensions
openssl x509 -req -in client.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out client.crt -days 365 -copy_extensions=copy
# echo "C"
# read

cat server.crt server.key > server.pem
cat client.crt client.key > client.pem
cat ca.pem > spaceship.pem
# echo "D"
# read

mkdir server
mkdir client
mkdir ca
# echo "E"
# read

mv server.* ./server
mv client.* ./client
mv ca.* ./ca
# echo "F"
# read