pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub_muzaffar')
  }
  stages {
    stage('Build') {
      steps {
        sh 'sudo docker build -t zafrii/private_repo:docker_automation_testing .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'sudo docker push zafrii/private_repo:docker_automation_testing'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}