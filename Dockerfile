# Этап 1: Сборка проекта
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
# Копируем файлы сборщика
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
# Даем права на запуск и собираем JAR (пропуская тесты для экономии времени/памяти)
RUN chmod +x ./gradlew
RUN ./gradlew clean bootJar -x test

# Этап 2: Запуск
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Копируем только готовый JAR из первого этапа
COPY --from=build /app/build/libs/*.jar app.jar

# Настройки для экономии памяти (очень важно для Render 512MB)
# -Xmx300m ограничивает кучу Java, чтобы хватило места остальным процессам
ENV JAVA_OPTS="-Xmx300m -Xms300m"

# Render передает порт в переменной среды PORT
EXPOSE 8080

ENTRYPOINT ["sh", "-Xmx300m", "-Xss512k", "-XX:MaxRAMPercentage=75.0", "-c", "java $JAVA_OPTS -jar app.jar --server.port=${PORT:-8080}"]