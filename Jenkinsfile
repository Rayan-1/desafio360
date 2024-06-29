pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io'  // Registry where your Docker images will be pushed
        DOCKERHUB_TOKEN = 'docker-credentials'
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
                    // Build Nginx Docker image
                    docker.withRegistry("", "", DOCKERHUB_TOKEN) {
                        def nginxImage = docker.build("nginx")
                        nginxImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Deploy Nginx to Kubernetes
                withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIALS_ID}", variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f k8s/nginx-deployment.yaml'
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
