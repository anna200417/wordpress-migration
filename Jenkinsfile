pipeline {
    agent any

    environment {
        IMAGE_NAME = 'anna408/wordpress-legacy'
        IMAGE_TAG = '0.1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/anna200417/wordpress.git', branch: 'main'
            }
        }

        stage('Build Docker') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
    }
}
