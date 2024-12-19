// Save this as 'Jenkinsfile' in your repository root
pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'far-devops-assignment'
        DOCKER_TAG = 'latest'
        // Add any environment variables needed
    }
    

    
    stages {
        stage('Checkout') {
            steps {
                // Clean workspace before build
                cleanWs()
                git branch: 'main',
                    url: 'https://github.com/farhanhameed010/far-devops-assignment-1.git'
            }
        }
        
        // stage('SonarQube Analysis') {
        //     environment {
        //         SONAR_SCANNER_HOME = tool 'SonarQubeScanner'
        //     }
        //     steps {
        //         withSonarQubeEnv('SonarQube') {
        //             sh """
        //                 ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
        //                 -Dsonar.projectKey=far-devops-assignment \
        //                 -Dsonar.projectName=far-devops-assignment \
        //                 -Dsonar.sources=. \
        //                 -Dsonar.host.url=http://sonarqube:9000
        //             """
        //         }
        //         timeout(time: 1, unit: 'HOURS') {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
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