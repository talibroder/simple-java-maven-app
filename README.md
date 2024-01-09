# Maven and Docker Workflow

[![Maven and Docker Workflow](https://github.com/talibroder/simple-java-maven-app/actions/workflows/main.yml/badge.svg)](https://github.com/talibroder/simple-java-maven-app/actions/workflows/main.yml)

This GitHub Actions workflow automates the Maven build, version increment, Docker image creation, and Ansible playbook deployment for Java project.

## Workflow Overview


### 1. Increment Patch Version

This step is responsible for incrementing the patch version in the `pom.xml` file. It uses Maven build-helper plugin to parse the current version, increments the patch version, commits the change, and pushes it back to the repository.

### 2. Run Tests

To maintain code quality, this step executes Maven tests to ensure that the project passes all defined tests.

### 3. Push Patch Version

After incrementing the version, this step commits and pushes the updated version back to the repository. This helps in keeping track of version changes and ensuring that the latest version is reflected in the repository.

### 4. Build and Push Docker Image

This step builds a Docker image for the Java application. It tags the image with both the project version and `latest`. The Docker image is then pushed to the specified Docker registry (e.g., Docker Hub). This facilitates easy deployment of the application in a containerized environment.

### 5. Push to GitHub

Following the Docker image creation, this step pushes changes, including the updated version, to the GitHub repository. It ensures that the GitHub repository is up-to-date with the latest changes in the project.

### 6. Run Ansible Playbook

The final step deploys the Java application on a remote server using Ansible playbook. It connects to the server using the provided SSH key, and the playbook specified in `playbook.yml` is executed. The inventory file (`./ansibel/.ansible_inventory`) contains the details of the target server, such as IP address.

## Usage

To use this workflow, ensure that you have the following secrets set in your GitHub repository:

- `DOCKER_USERNAME`: Docker Hub username.
- `DOCKER_PASSWORD`: Docker Hub password or access token.
- `SSH_PRIVATE_KEY`: Private SSH key for Ansible playbook.
- `EC2_IP`: IP address of the target EC2 instance.




