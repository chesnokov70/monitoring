pipeline {
    agent any
    tools {
     terraform 'tf1.9'
    }
    environment {
        AWS_REGION = 'us-east-1' // Set the AWS region
    }
    options {
        ansiColor('xterm')
    }
    stages {
        stage('Clone Git repo') {
            steps {
                git(branch: 'master', url: 'git@github.com:LocalCoding/DevOps_May_24.git', credentialsId: 'github_access')
            }
        }
        stage('Plan') {
            steps {
                sh '''
                cd ./Lesson_15_simple_instance_setup/terraform/
                terraform init
                terraform plan -out=terraform.tfplan
                '''
            }
        }
        stage('Plan verification and user input') {
            steps {
                input message: 'proceed or abort?', ok: 'ok'
            }
        }
        stage('Apply') {
            steps {
                sh '''
                cd ./Lesson_15_simple_instance_setup/terraform/
                terraform apply terraform.tfplan
                '''
            }
        }
        stage('Plan verification and user input destroy') {
            steps {
                input message: 'proceed or abort?', ok: 'ok'
            }
        }
        stage('Destroy') {
            steps {
                sh '''
                cd ./Lesson_15_simple_instance_setup/terraform/
                terraform plan -destroy -out=terraform-destroy.tfplan
                terraform apply terraform-destroy.tfplan
                '''
            }
        }
    }
}
