# Use official Maven image with OpenJDK 17
FROM maven:3.8.6-openjdk-17

# Set working directory inside container
WORKDIR /target

# The backend project files will be mounted here at runtime

# Install Spring Boot CLI (optional, if needed)
RUN curl -s https://get.sdkman.io | bash && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install springboot"

# Expose port 8080 (default for Spring Boot)
EXPOSE 8080

# Command to run the Spring Boot application
# Assumes the user will mount the project at /app and run this command
CMD ["mvn", "spring-boot:run"]
