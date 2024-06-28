pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "localhost:5000"  // Endereço do registro Docker local
        KIND_CLUSTER_NAME = "kind-cluster"  // Nome do cluster Kubernetes Kind
    }
    
    triggers {
        pollSCM('* * * * *')  // Gatilho para verificar alterações no Git a cada minuto
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout do repositório
                git 'https://github.com/Rayan-1/desafio360.git'
            }
        }
        
        stage('Build') {
            steps {
                // Construção da imagem Docker
                script {
                    docker.build("${DOCKER_REGISTRY}/django-crm:${env.BUILD_ID}")
                }
            }
        }
        
        stage('Push') {
            steps {
                // Push da imagem Docker para o registro local
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}", 'docker-credentials') {
                        docker.image("${DOCKER_REGISTRY}/django-crm:${env.BUILD_ID}").push()
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                // Implantar no cluster Kind usando kubectl
                script {
                    withKubeConfig(credentialsId: 'kubeconfig-credentials', kubeconfigFile: '/path/to/your/kubeconfig') {
                        sh "kubectl config use-context ${KIND_CLUSTER_NAME}"
                        sh "kubectl set image deployment/django-crm-app django-crm=${DOCKER_REGISTRY}/django-crm:${env.BUILD_ID}"
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
