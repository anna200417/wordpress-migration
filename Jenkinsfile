pipeline {
    agent any

    environment {
        KUBECONFIG_CRED = credentials('docker-hub-credentials')
    }

    stages {
        stage('Deploy Staging') {
            steps {
                sh 'echo "$KUBECONFIG_CRED" > /tmp/kubeconfig && export KUBECONFIG=/tmp/kubeconfig'
                sh 'kubectl apply -f k8s/staging/'
                sh 'kubectl get pods -n staging'
            }
        }
    }
}
