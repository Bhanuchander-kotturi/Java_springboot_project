FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/hello-world-1.0-SNAPSHOT.jar hello-world.jar
EXPOSE 8090
CMD ["java", "-jar", "hello-world.jar"]
