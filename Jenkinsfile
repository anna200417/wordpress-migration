pipeline {
    agent any

    stages {
        stage('Build Docker') {
            steps {
                sh 'docker build -t anna408/wordpress-legacy:0.1.0 .'
            }
        }
        stage('Push Docker') {
            steps {
                sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
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
