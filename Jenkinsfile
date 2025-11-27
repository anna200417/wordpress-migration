pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: jenkins-agent
spec:
  serviceAccountName: default
  containers:
    - name: docker
      image: docker:24.0.6-dind
      securityContext:
        privileged: true
      tty: true
      command: [ "dockerd-entrypoint.sh" ]
      args: [ "--host=tcp://0.0.0.0:2375", "--host=unix:///var/run/docker.sock" ]
      volumeMounts:
        - name: dind-storage
          mountPath: /var/lib/docker

    - name: kubectl
      image: lachlanevenson/k8s-helm:latest
      command: [ "cat" ]
      tty: true

  volumes:
    - name: dind-storage
      emptyDir: {}
"""
            defaultContainer 'docker'
        }
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credentials')  // tes credentials Docker Hub
        IMAGE_NAME = "anna408/wordpress-legacy"
        IMAGE_TAG = "0.1.0"
    }

    stages {

        stage('Clone repository') {
            steps {
                container('docker') {
                    git branch: 'main',
                        credentialsId: 'credential', // ton credential GitHub
                        url: 'https://github.com/anna200417/wordpress-migration.git'
                }
            }
        }

        stage('Build Docker image') {
            steps {
                container('docker') {
                    sh """
                        docker build -t $IMAGE_NAME:$IMAGE_TAG -f Dockerfile .
                    """
                }
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                container('docker') {
                    sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push $IMAGE_NAME:$IMAGE_TAG"
                }
            }
        }
    }
}
