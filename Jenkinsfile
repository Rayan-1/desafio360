pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "django_crm"
        KUBE_CONFIG = credentials('kubeconfig-credentials')
    }

    tools {
        // Define a instalação do Python 3 como uma ferramenta
        python 'Python 3'
    }

    stages {
        stage('Install Python Dependencies') {
            steps {
                // Instala as dependências Python do projeto
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Checkout') {
            steps {
                // Checkout the source code from GitHub
                git credentialsId: 'git-credentials-id', url: 'https://github.com/Rayan-1/desafio360.git'
            }
        }

        stage('Build') {
            steps {
                // Build your Django application
                sh 'python3 manage.py migrate'
                sh 'python3 manage.py collectstatic --noinput'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image and push to Docker registry
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-credentials') {
                        def customImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                        customImage.push()
                    }
                }
            }
        }

        stage('Deploy to Kind Kubernetes') {
            steps {
                // Deploy to Kubernetes cluster managed by Kind
                withCredentials([file(credentialsId: 'kubeconfig-credentials', variable: 'KUBECONFIG')]) {
                    sh 'kubectl --kubeconfig=$KUBECONFIG apply -f kubernetes-manifests/'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! Deployment completed.'
        }
        failure {
            echo 'Pipeline failed! Deployment unsuccessful.'
        }
    }
}
