FROM maven:3.9 AS build
WORKDIR /app
COPY /src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package -Dmaven.test.skip

FROM openjdk:21-slim
EXPOSE 8080
COPY --from=build /app/target/*jar app.jar


ENTRYPOINT ["java", "-jar", "app.jar"]