
# Java App -  Docker Image Update & deployment Pipeline
In This project a simple *"Hello World!"* Java app is updated using a GitHub Actions workflow for re-building the updated app, testing, and deploying a Docker image. The pipeline is triggered on push events.

## Features 
Pipeline is defined in a yaml config file *".github/workflows/maven.yml"*.

The Pipeline uses *Maven* to build and test the Java app.

The pipline updates a *Docker* image of the app using an included *Dockerfile*.

A mvn build-helper:parse-version is used in the pipeline to increase the app version on each pipeline run. the version is updated in the "pom.xml" file.

The pipeline pushes the Docker image updates in a *DockerHub* registry with *<version>* and *"latest"* tags.

The pipeline runs an *Ansible* playbook that deploys the app on *EC2*.

The app execution can be viewed in a terminal using *"AWS EC2 Instance Connect"* platform.

## Installation
How to Setup the pipeline, trigger it and view the results:

1. **Fork and pull this repo:**
    - In the main menu of this repo click "Fork" to copy to your GitHub account.
    - On your local machine initialize git and pull your new repo.

    ```bash
    git init
    git pull <url of your new repo>
     
    ```
     
2. **Add GitHub Actions secrets:**
    Go to settings --> security --> Secrets and variables --> Actions.
    Add the following secrets using these exact names:
    - DOCKER_USERNAME - Dockerhub user for creating a registry.
    - DOCKER_PASSWORD - Dockerhub password.
    - EC2_IP - enter: [webserver] <ip target where app will run> ansible_user=ubuntu.
    - SSH_PRIVATE_KEY - content of your pem file (private key).

3. **Create a EC2 instance based ubuntu image.**

4. **Make some changes to repo, commit and push:**

    ```bash
    git add .
    git commit -m "My changes commit"
    git push origin master
    ```
    
5. **View pipeline workflow in GitHub Actions:**
    - Click the "Actions" tab to follow the pipeline workflow of your last commit.

6. **Connect and review deployed EC2:**
    - In the EC2 service dashboard navigate to "Instances".
    - Locate your deployed EC2.
    - Navigate to "Connect", choose "EC2 instance connect" and click "Connect".
    - Run the following command: 
    
    ```bash
    sudo docker logs $(sudo docker ps -aq)
    
    ```
    - Check the log output: Should return "Hello World!" message.

## Workflow Jobs:

1. **Build and test with Maven:**
    - Builds and tests the new java app update using Maven.

2. **Docker image build and push:**
    - Updates the version file with new version tag.
    - Builds a new updated Docker image.
    - Pushes the new image to DockerHub with "version" and "latest" tags.

3. **Deployment to EC2:**
    - Using ansible playbook: Logs into instance AWS-cli using GitHub Actions Secrets. 
    Pulls and runs the updated image as a Docker container.
