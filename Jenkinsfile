pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: kubectl
      image: bitnami/kubectl:latest
      command:
        - cat
      tty: true
"""
        }
    }

    environment {
        KUBECONFIG_CRED = credentials('docker-hub-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy Staging') {
            steps {
                container('kubectl') {
                    sh '''
                        echo "$KUBECONFIG_CRED" > /tmp/kubeconfig
                        export KUBECONFIG=/tmp/kubeconfig
                        kubectl version --client

                        kubectl apply -f k8s/staging/
                        kubectl get pods -n staging
                    '''
                }
            }
        }
    }
}
