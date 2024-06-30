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
        
        stage('Build') {
            steps {
                sh 'python manage.py migrate'
                sh 'python manage.py collectstatic --noinput'
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
