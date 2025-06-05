# Use official OpenJDK 17 runtime image
FROM eclipse-temurin:17-jdk

# Set working directory inside container
WORKDIR /app

# The backend project files will be mounted here at runtime

# Expose port 8080 (default for Spring Boot)
EXPOSE 8080

# Command to run the Spring Boot application jar
# Assumes the jar file is present in /app/target/
CMD ["sh", "-c", "java -jar /app/target/*.jar"]
ENTRYPOINT ["sh", "-c", "java -jar /app/target/*.jar"]