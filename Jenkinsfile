pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io'  // Registry where your Docker images will be pushed
        DOCKERHUB_USERNAME = credentials('docker-credentials').username
        DOCKERHUB_PASSWORD = credentials('docker-credentials').password
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-credentials'
        SONARQUBE_CREDENTIALS_ID = 'sonarqube-credentials'
    }

    triggers {
        pollSCM '* * * * *'  // Poll SCM for changes every minute
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    def mvnHome = tool 'Maven'
                    sh "${mvnHome}/bin/mvn clean package"
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    docker.withRegistry("$DOCKER_REGISTRY", "${DOCKERHUB_USERNAME}:${DOCKERHUB_PASSWORD}") {
                        def customImage = docker.build("your-docker-image-name")
                        customImage.push('latest')
                    }
                }
            }
        }

        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'SonarQubeScanner'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: "${SONARQUBE_CREDENTIALS_ID}", passwordVariable: 'SONARQUBE_PASSWORD', usernameVariable: 'SONARQUBE_USERNAME')]) {
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.login=${SONARQUBE_USERNAME} -Dsonar.password=${SONARQUBE_PASSWORD}"
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
