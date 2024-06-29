pipeline {
    agent any

    environment {
        SONARQUBE_CREDENTIALS_ID = 'sonarqube-credentials'  // ID das credenciais do SonarQube armazenadas no Jenkins
        DOCKER_CREDENTIALS_ID = 'docker-credentials'  // ID das credenciais do Docker armazenadas no Jenkins
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-credentials'  // ID das credenciais do kubeconfig armazenadas no Jenkins
        GIT_CREDENTIALS_ID = 'git-credentials-id' // ID das credenciais do Git armazenadas no Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: "${GIT_CREDENTIALS_ID}", url: 'https://github.com/Rayan-1/desafio360.git', branch: 'develop'
            }
        }
        stage('Build') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        // Build steps go here, e.g., Docker login and build
                    }
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: "${SONARQUBE_CREDENTIALS_ID}") {
                        // Run SonarQube analysis here
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${KUBECONFIG_CREDENTIALS_ID}", passwordVariable: 'KUBECONFIG_PASSWORD', usernameVariable: 'KUBECONFIG_USERNAME')]) {
                        // Deployment steps go here
                    }
                }
            }
        }
    }
    post {
        failure {
            echo 'Pipeline failed!'
        }
    }
}
