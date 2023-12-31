FROM openjdk:11
#LABEL maintainer="javaguides.net"
#ADD target/CRUD-0.0.1-SNAPSHOT.jar crud.jar

# Refer to Maven build -> finalName
ARG JAR_FILE=target/CRUD-0.0.1-SNAPSHOT.jar

# cd /opt/app
WORKDIR /opt/app

# cp target/frg-cin.jar /opt/app/sic-service.jar
COPY ${JAR_FILE} crud.jar


RUN mkdir /opt/app/log
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.13.0-amd64.deb
RUN dpkg -i filebeat-7.13.0-amd64.deb
COPY filebeat.yml /etc/filebeat/filebeat.yml
CMD ["--network","elknetwork"]

RUN chmod go-w /etc/filebeat/filebeat.yml




ENTRYPOINT ["java", "-jar", "crud.jar"]

