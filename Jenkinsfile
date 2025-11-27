pipeline {
    agent any

    environment {
        KUBECONFIG_CRED = credentials('kubeconfig-credentials') // ton credential pour kubectl
    }

    stages {
        stage('Deploy Staging') {
            steps {
                // On exporte le kubeconfig pour kubectl
                sh 'echo "$KUBECONFIG_CRED" > /tmp/kubeconfig && export KUBECONFIG=/tmp/kubeconfig'
                
                // On applique les manifests Kubernetes du staging
                sh 'kubectl apply -f k8s/staging/'
                
                // Optionnel : vérifier le statut des pods
                sh 'kubectl get pods -n staging'
            }
        }
    }
}
