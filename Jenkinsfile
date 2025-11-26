pipeline {
    agent any
    environment {
        KUBECONFIG_CREDENTIALS = credentials('kubeconfig-credentials') // si besoin
    }
    stages {
        stage('Deploy Staging') {
            steps {
                // Optionnel : si tu as besoin de kubeconfig
                // sh 'echo "$KUBECONFIG_CREDENTIALS" > /tmp/kubeconfig && export KUBECONFIG=/tmp/kubeconfig'

                // Applique les manifests K8s pour staging
                sh 'kubectl apply -f k8s/staging/'
            }
        }
    }
}
