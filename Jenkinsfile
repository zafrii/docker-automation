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
        sh 'echo $EC2_DS_USR'
      }
    }
    // stage('Docker Login on EC2') {
    //   steps {
    //       sh '$EC2_DS_USR'
    //       sh """
    //           ssh -o StrictHostKeyChecking=no -i $EC2_DS_key centos@$EC2_INSTANCE_IP \
    //           "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
    //       """
    //   }
    // }
    // stage('Docker Pull on EC2') {
    //     steps {
    //         script {
    //             // Retrieve the EC2 SSH private key from Jenkins credentials
    //             withCredentials([sshUserPrivateKey(credentialsId: EC2_DS, keyFileVariable: 'SSH_KEY_FILE')]) {
    //                 // Execute Docker pull command on the remote EC2 instance
    //                 sh "ssh -o StrictHostKeyChecking=no -i $SSH_KEY_FILE centos@${EC2_INSTANCE_IP} docker pull zafrii/private_repo:docker_automation_testing"
    //             }
    //         }
    //     }
    // }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}