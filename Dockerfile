# Use Java 21 JDK because Maven needs javac to compile the project
FROM eclipse-temurin:21-jdk-jammy

# Working directory inside the container
WORKDIR /app

# Copy Maven wrapper
COPY mvnw mvnw
COPY .mvn .mvn

# Copy Maven configuration
COPY pom.xml pom.xml

# Copy source code
COPY src src

# Give Maven wrapper execute permission
RUN chmod +x mvnw

# Build the Spring Boot application
RUN ./mvnw clean package -DskipTests

# Application runs on port 8080
EXPOSE 8080

# Start the executable WAR
ENTRYPOINT ["java", "-jar", "target/CarrerRecommedationSystem-0.0.1-SNAPSHOT.war"]