# Этап 1: Сборка
FROM gradle:8.13-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

# ОБЯЗАТЕЛЬНАЯ СТРОКА: Даем права на запуск скрипта Gradle
RUN chmod +x gradlew

# Запускаем сборку
RUN ./gradlew clean bootJar -x test

# Этап 2: Запуск
FROM eclipse-temurin:17-jre
WORKDIR /app

# Копируем собранный jar
COPY --from=build /home/gradle/src/build/libs/*.jar app.jar

# Настройки для Render
ENTRYPOINT ["java", "-Xmx300m", "-Xss512k", "-jar", "app.jar"]