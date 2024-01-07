# Use the official Maven image for building
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the POM file and build the application
COPY . .

# Build the application
RUN mvn clean package

# Stage 2: Create the final runtime image
FROM openjdk:11-jre-slim

# Copy the built artifact from the build stage
COPY --from=build /app/target/my-app-*.jar ./my-app.jar

# Run the application
ENTRYPOINT ["java","-jar","./my-app.jar"]
