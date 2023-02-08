# Truststore (CA + Bridge)
keytool -genkey -keyalg RSA -alias temp0 -keystore ./client/keystore.ks \
 -noprompt \
 -dname "CN=TEMP, OU=TEMP, O=TEMP, L=TEMP, S=TEMP, C=US" \
 -storepass 123456 \
 -keypass 123456
keytool -delete -alias temp0 -keystore ./client/keystore.ks \
 -noprompt \
 -storepass 123456 \
 -keypass 123456

keytool -import \
 -v \
 -alias dolphin_spaceship \
 -file ./client/client.pem \
 -keystore ./client/keystore.ks \
 -noprompt \
 -storepass 123456 \
 -keypass 123456
 # -trustcacerts