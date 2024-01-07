# Use the official Maven image for building
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the POM file and build the application
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install

