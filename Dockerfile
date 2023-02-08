FROM adoptopenjdk/openjdk8:x86_64-debian-jdk8u242-b08

# Set up the Environment Variable for Application
ENV APP_HOME=/app

WORKDIR ${APP_HOME}

# Create the directories for Application
RUN mkdir -p ${APP_HOME} && mkdir ${APP_HOME}/security

# Import the CA certificate
COPY ./certs/spaceship.pem ${APP_HOME}/security
RUN keytool -importcert -keystore ${JAVA_HOME}/jre/lib/security/cacerts -storepass changeit -file ${APP_HOME}/security/spaceship.pem -alias "spaceship_root_cert" -noprompt

COPY ./Main.java                  ${APP_HOME}
COPY ./certs/client/keystore.p12   ${APP_HOME}/security

# Compile single jar with javac, then you can run main.class with java main
RUN javac Main.java

# Using exec to pass OPTS easily https://www.veracode.com/blog/secure-development/docker-and-javaopts

ENTRYPOINT ["bash", "-c", "exec java $JAVA_OPTS Main $0"]
# ENTRYPOINT /bin/bash