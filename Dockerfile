# Этап 1: Сборка
FROM gradle:8.13-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

# ДОБАВЛЯЕМ ЭТУ СТРОКУ: даем права на выполнение скрипта gradlew
RUN chmod +x gradlew

RUN ./gradlew clean bootJar -x test

# Этап 2: Запуск
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /home/gradle/src/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-Xmx300m", "-Xss512k", "-jar", "app.jar"]