FROM instructure/java:8

USER root
WORKDIR /usr/src/app
# Install fonts into /usr/share/fonts
copy fonts/* /usr/share/fonts/
RUN chmod 0644 /usr/share/fonts/*

RUN mkdir -p  /usr/src/app/output /usr/src/app/cache;  chown -R docker: . /usr/src/app

RUN apt-get update
RUN apt-get -y install maven

ADD pom.xml /usr/src/app/

USER docker
RUN mvn verify clean --fail-never

ADD ./src /usr/src/app/src
ADD ./test.pptx /usr/src/app
RUN mvn package -DskipTests
CMD java -jar target/GroupDocs-1.0-SNAPSHOT.jar test.pptx