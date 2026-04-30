# Этап 1: Сборка
FROM gradle:8.13-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew clean bootJar -x test

# Этап 2: Запуск
FROM openjdk:17-jdk-slim
WORKDIR /app

# Копируем и сразу переименовываем, чтобы не гадать с именем файла
COPY --from=build /home/gradle/src/build/libs/*.jar app.jar

# Используем "Exec form" (массив строк).
# Это гарантирует, что Java запустится напрямую, минуя оболочку sh.
# Важно: Spring Boot автоматически подхватит переменную PORT из окружения Render.
ENTRYPOINT ["java", "-Xmx300m", "-Xss512k", "-jar", "app.jar"]