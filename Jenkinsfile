pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS = credentials('docker-hub-credentials')
    }
    stages {
        stage('Build Docker') {
            steps {
                sh 'docker build -t anna408/wordpress-legacy:0.1.0 .'
            }
        }
        stage('Push Docker') {
            steps {
                sh "echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin"
                sh 'docker push anna408/wordpress-legacy:0.1.0'
            }
        }
        stage('Deploy Staging') {
            steps {
                sh 'kubectl apply -f k8s/staging/'
            }
        }
    }
}
