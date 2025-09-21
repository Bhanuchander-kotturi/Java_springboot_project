FROM openjdk:21-jre-slim

WORKDIR /app

COPY target/hello-world-1.0-SNAPSHOT.jar /app/hello-world.jar

EXPOSE 8090

CMD ["java", "-jar", "hello-world.jar", "--server.port=8090"]
