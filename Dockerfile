
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

COPY src/ ./src/

RUN mkdir -p out \
    && javac -d out src/main/java/com/veterinaria/ApiServer.java

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/out ./out

ENV PORT=8080
ENV DATA_DIR=/data

EXPOSE 8080

CMD ["java", "-cp", "out", "com.veterinaria.ApiServer"]
