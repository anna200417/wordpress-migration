pipeline {
    agent {
        kubernetes {
            label 'kaniko-agent'
            defaultContainer 'kaniko'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    jenkins: kaniko
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    args:
    - "--dockerfile=Dockerfile"
    - "--context=."
    - "--destination=anna408/wordpress-legacy:0.1.0"
    volumeMounts:
    - name: docker-config
      mountPath: /kaniko/.docker
  volumes:
  - name: docker-config
    projected:
      sources:
      - secret:
          name: docker-hub-credentials
          items:
          - key: .dockerconfigjson
            path: config.json
"""
        }
    }

    stages {

        stage('Build & Push Docker image with Kaniko') {
            steps {
                container('kaniko') {
                    sh '''
                        echo "Kaniko building and pushing image..."
                    '''
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                sh 'kubectl apply -f k8s/staging/'
            }
        }
    }
}
