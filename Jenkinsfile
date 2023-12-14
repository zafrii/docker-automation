pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub_muzaffar')
    EC2_DS = credentials('ec2-ds')
    EC2_INSTANCE_IP = '18.218.50.110'
  }
  stages {
    stage('Build') {
      steps {
        sh 'whoami'
        sh 'docker build -t zafrii/private_repo:docker_automation_testing .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push zafrii/private_repo:docker_automation_testing'
      }
    }
    stage('Login on EC2') {
      steps {
          sh """
              ssh -o StrictHostKeyChecking=no -i $EC2_DS centos@$EC2_INSTANCE_IP \
              "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
          """
      }
    }
    stage('Docker Pull') {
        steps {
            sh "ssh -o StrictHostKeyChecking=no -i $EC2_DS centos@${EC2_INSTANCE_IP} docker pull zafrii/private_repo:docker_automation_testing"
        }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}