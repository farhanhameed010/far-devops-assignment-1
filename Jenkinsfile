pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'far-devops-assignment'
        DOCKER_TAG = 'latest'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/farhanhameed010/far-devops-assignment-1.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker info'  // Test Docker connectivity
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
    }
    
    post {
        always {
            // Clean workspace after build
            cleanWs()
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}