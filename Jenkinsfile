pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credentials')
        IMAGE_NAME = "anna408/wordpress-legacy"
        IMAGE_TAG = "0.1.0"
    }
    stages {
        stage('Clone & Build Docker') {
            steps {
                git branch: 'main',
                    credentialsId: 'credential',
                    url: 'https://github.com/anna200417/wordpress-migration.git'
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }
        stage('Push Docker') {
            steps {
                sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push $IMAGE_NAME:$IMAGE_TAG"
            }
        }
    }
}
