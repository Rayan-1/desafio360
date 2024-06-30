pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "django_crm"
        KUBE_CONFIG = credentials('kubeconfig-credentials')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'git-credentials-id', url: 'https://github.com/Rayan-1/desafio360.git', branch: 'develop'
            }
        }

         stages {
        stage('Install Python 3') {
            steps {
                sh 'sudo apt update'
                sh 'sudo apt install -y python3 python3-pip'
            }
        }
        
        stage('Build') {
            steps {
                sh 'python3 ~/desafio360/desafio360/django_crm/manage.py migrate'
                sh 'python3 ~/desafio360/desafio360/django_crm/manage.py collectstatic --noinput'
            }
        }
        
        stage('Build Docker Image') {
            steps {
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
}
