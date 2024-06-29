pipeline {
    agent any

    environment {
        SONARQUBE_CREDENTIALS_ID = 'sonarcloud-credentials'
        DOCKER_CREDENTIALS_ID = 'docker-credentials'
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-credentials'
        GIT_CREDENTIALS_ID = 'git-credentials-id'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'SonarQubeScanner'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: "${SONARQUBE_CREDENTIALS_ID}", passwordVariable: 'SONARQUBE_PASSWORD', usernameVariable: 'SONARQUBE_USERNAME')]) {
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=${SONARQUBE_USERNAME}"
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIALS_ID}", variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
