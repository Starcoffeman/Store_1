# Этап 1: Сборка
FROM gradle:8.13-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
# Сборка jar-файла
RUN ./gradlew clean bootJar -x test

# Этап 2: Запуск
FROM openjdk:17-jdk-slim
WORKDIR /app

# Копируем jar-файл из этапа сборки
# В Gradle Spring Boot jar обычно лежит в build/libs/
COPY --from=build /home/gradle/src/build/libs/*.jar app.jar

# Настройки для Render (Free Tier 512MB)
# Используем "Shell form" (без квадратных скобок), чтобы переменная $PORT подставилась корректно
CMD java -Xmx300m -Xss512k -Dserver.port=${PORT} -jar app.jar