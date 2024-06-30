pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "django_crm"
        KUBE_CONFIG = credentials('kubeconfig-credentials')
    }
    
    tools {
        // Define a instalação do Python 3 como uma ferramenta
        // Certifique-se de configurar esta ferramenta nas configurações globais do Jenkins
        python 'Python 3'
    }
    
    stages {
        stage('Install Python') {
            steps {
                // Script para instalar o Python 3 se não estiver disponível
                script {
                    def pythonHome = tool name: 'Python 3', type: 'hudson.plugins.python.PythonInstallation'
                    if (pythonHome == null) {
                        error "Instalação do Python 3 não encontrada. Verifique as configurações do Jenkins."
                    }
                    echo "Python 3 está instalado em: ${pythonHome}"
                }
            }
        }
        
        stage('Checkout') {
            steps {
                // Checkout the source code from GitHub
                git credentialsId: 'git-credentials-id', url: 'https://github.com/Rayan-1/desafio360.git', branch: 'main'
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
