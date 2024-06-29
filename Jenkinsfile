pipeline {
    agent any

    environment {
        SONARQUBE_CREDENTIALS_ID = 'sonarqube-credentials'
        DOCKER_CREDENTIALS_ID = 'docker-credentials'
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-credentials'
        GIT_CREDENTIALS_ID = 'git-credentials-id'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/develop']], 
                    doGenerateSubmoduleConfigurations: false, 
                    extensions: [], 
                    userRemoteConfigs: [[
                        credentialsId: "${GIT_CREDENTIALS_ID}", 
                        url: 'https://github.com/Rayan-1/desafio360.git'
                    ]]
                ])
            }
        }

        stage('Build') {
            steps {
                // Adicionar os passos de build
                script {
                    echo 'Building...'
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

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        def image = docker.build('your-image-name')
                        image.push('latest')
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
                    script {
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.login=${SONARQUBE_USERNAME} -Dsonar.password=${SONARQUBE_PASSWORD}"
                    }
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
        failure {
            echo 'Pipeline failed!'
        }
    }
}
