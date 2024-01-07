# Use an official Maven runtime as a parent image
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the pom.xml file to the container
COPY ./pom.xml .

# Copy the rest of the application code to the container
COPY ./src ./src

# Build the application
RUN mvn clean install

# Use the official OpenJDK image for the final runtime
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the JAR file from the build stage to the runtime image
COPY --from=build /usr/src/app/target/your-application.jar ./app.jar

# Expose the port the application runs on
EXPOSE 8080

# Specify the command to run on container start
CMD ["java", "-jar", "app.jar"]
