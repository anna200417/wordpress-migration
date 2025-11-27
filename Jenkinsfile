podTemplate(
  containers: [
    containerTemplate(
      name: 'docker',
      image: 'docker:24.0.6-dind',
      command: 'dockerd-entrypoint.sh',
      args: '--host=tcp://0.0.0.0:2375 --host=unix:///var/run/docker.sock',
      privileged: true,
      ttyEnabled: true,
      volumeMounts: [
        volumeMount(mountPath: '/home/jenkins/agent', name: 'workspace-volume')
      ]
    ),
    containerTemplate(
      name: 'jnlp',
      image: 'jenkins/inbound-agent:3345.v03dee9b_f88fc-1',
      ttyEnabled: true,
      volumeMounts: [
        volumeMount(mountPath: '/home/jenkins/agent', name: 'workspace-volume')
      ]
    )
  ],
  volumes: [
    emptyDirVolume(mountPath: '/home/jenkins/agent', name: 'workspace-volume')
  ]
) {
  node('docker') {
    stage('Checkout') {
      checkout scm
    }

    stage('Build Docker Image') {
      container('docker') {
        sh """
          docker build -t anna408/wordpress-legacy:0.1.0 -f Dockerfile .
        """
      }
    }

    stage('Push Docker Image') {
      container('docker') {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PSW', usernameVariable: 'DOCKER_USER')]) {
          sh """
            echo $DOCKER_PSW | docker login -u $DOCKER_USER --password-stdin
            docker push anna408/wordpress-legacy:0.1.0
          """
        }
      }
    }
  }
}
