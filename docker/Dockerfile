# Stage 1: Build
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM amazoncorretto:17-alpine
WORKDIR /app

# New Relic Agent Integration
ADD https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-agent.jar /app/newrelic.jar
ENV NEW_RELIC_APP_NAME="Java-REST-API"
ENV NEW_RELIC_LOG_FILE_NAME="STDOUT"
RUN chmod 644 /app/newrelic.jar

# Best Practice: Non-root user for security
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# Health check configuration
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/health || exit 1

ENTRYPOINT ["java", "-javaagent:/app/newrelic.jar", "-Dnewrelic.config.license_key=${NEW_RELIC_LICENSE_KEY}", "-jar", "app.jar"]