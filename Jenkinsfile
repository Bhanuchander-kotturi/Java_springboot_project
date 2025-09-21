pipeline {
    agent any
    tools {
        jdk 'jdk21'
        maven 'maven3'
    }
   environment {
       SONAR_SCANNER_HOME= tool 'sonar-scanner'
       IMAGE_NAME = "java-app"
       IMAGE_TAG = "${BUILD_NUMBER}"
   }
    stages {
        stage('Initialize Pipeline'){
            steps {
                echo 'Initializing Pipeline ...'
                sh 'java --version'
                sh 'mvn --version'
                }
        }
        stage('Checkout GitHub Codes'){
            steps {
                echo 'Checking out GitHub Codes ...'
                git branch: 'main', changelog: false, credentialsId: 'GithbubToken', poll: false, url: 'https://github.com/Bhanuchander-kotturi/Java_springboot_project.git'
            }
        }
        stage('Maven Build'){
            steps {
                echo 'Building Java App with Maven'
                sh 'mvn clean package'
                  }
        }
        stage('JUnit Test of Java App'){
            steps {
                echo 'JUnit Testing'
                sh 'mvn test'
            }
        }
        stage('SonarQube Analysis'){
            steps {
                echo 'Running Static Code Analysis with SonarQube'
                withCredentials([string(credentialsId: 'sonar', variable: 'SonarToken')]) {
                    withSonarQubeEnv('sonar-scanner') {
                        sh ''' ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                               -Dsonar.projectKey=jenkinsproject \
                               -Dsonar.sources=. \
                               -Dsonar.host.url=http://13.201.33.110:9000 \
                               -Dsonar.java.binaries=target/classes \
                               -Dsonar.token=$SonarToken                  
                           '''
                 }
            }
        }
        }
        stage('Trivy FS Scan'){
            steps {
                echo 'Scanning File System with Trivy FS ...'
                sh 'trivy fs . --format table -o FSScanReport.html'
            }
        }
        stage('Build & Tag Docker Image'){
            steps {
                echo 'Building the Java App Docker Image'
                script {
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                    // sh 'docker run -d --name java-spring-project -p 8090:8090 ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }
        stage('Trivy Security Scan'){
            steps {
                echo 'Scanning File System with Trivy FS ...'
                sh '''
  			            trivy image --severity HIGH,CRITICAL --cache-dir ${WORKSPACE}/.trivy-cache --no-progress --format table -o trivyFSScanReport.html ${IMAGE_NAME}:${IMAGE_TAG}
     		       '''
            }
        }
        stage('container creation and push to dockerhub'){
            steps {
                echo 'Building the Java App Docker Image'
                script {
                    sh 'docker run -d --name java-spring-project -p 8090:8090 ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }
    }
}






      
