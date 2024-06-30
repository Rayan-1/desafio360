pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "django_crm"
        KUBE_CONFIG = credentials('kubeconfig-credentials')
    }

    tools {
        // Definindo a instalação do Python 3 como uma ferramenta global no Jenkins
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
                // Checkout do código-fonte do GitHub
                git credentialsId: 'git-credentials-id', url: 'https://github.com/Rayan-1/desafio360.git'
            }
        }

        stage('Build') {
            steps {
                // Executa as migrações do Django
                sh 'python manage.py migrate'
                sh 'python manage.py collectstatic --noinput'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Constrói a imagem Docker e a envia para o registro Docker
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
                // Implanta no cluster Kubernetes gerenciado pelo Kind
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
