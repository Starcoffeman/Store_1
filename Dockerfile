# Этап 1: Сборка
FROM gradle:8.13-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew clean bootJar -x test

# Этап 2: Запуск
# Используем поддерживаемый образ Eclipse Temurin (JRE — он легче и лучше для Render)
FROM eclipse-temurin:17-jre
WORKDIR /app

# Копируем jar-файл
COPY --from=build /home/gradle/src/build/libs/*.jar app.jar

# Настройки для Render
# Используем массив [], чтобы избежать ошибки "sh: illegal option -X"
ENTRYPOINT ["java", "-Xmx300m", "-Xss512k", "-jar", "app.jar"]