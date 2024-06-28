pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "localhost:5000"  // Endereço do registro Docker local
        KIND_CLUSTER_NAME = "kind-cluster"  // Nome do cluster Kubernetes Kind
        SONARQUBE_URL = 'http://localhost:9000'  // URL do servidor SonarQube
        SONARQUBE_CREDENTIALS_ID = 'sonarqube-credentials'  // ID das credenciais do SonarQube armazenadas no Jenkins
        DOCKER_CREDENTIALS_ID = 'docker-credentials'  // ID das credenciais do Docker armazenadas no Jenkins
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-credentials'  // ID das credenciais do kubeconfig armazenadas no Jenkins
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
                    docker.withRegistry("${DOCKER_REGISTRY}", DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_REGISTRY}/django-crm:${env.BUILD_ID}").push()
                    }
                }
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                // Análise do código-fonte com SonarQube
                script {
                    withSonarQubeEnv('SonarQube') {  // Nome da instalação do SonarQube no Jenkins
                        withCredentials([string(credentialsId: SONARQUBE_CREDENTIALS_ID, variable: 'SONARQUBE_TOKEN')]) {
                            sh 'sonar-scanner -Dsonar.projectKey=desafio360 -Dsonar.sources=. -Dsonar.host.url=$SONARQUBE_URL -Dsonar.login=$SONARQUBE_TOKEN'
                        }
                    }
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                // Verifica o resultado do Quality Gate do SonarQube
                script {
                    timeout(time: 1, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                // Implantar no cluster Kind usando kubectl
                script {
                    withKubeConfig(credentialsId: KUBECONFIG_CREDENTIALS_ID, kubeconfigFile: '/path/to/your/kubeconfig') {
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
