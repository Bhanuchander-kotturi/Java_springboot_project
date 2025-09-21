pipeline {
    agent any
    tools {
        jdk 'jdk21'
        maven 'maven3'
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
            }
        }
        stage('Trivy FS Scan'){
            steps {
                echo 'Scanning File System with Trivy FS ...'
            }
        }
        stage('Build & Tag Docker Image'){
            steps {
                echo 'Building the Java App Docker Image'
                }
        }
        stage('Trivy Security Scan'){
            steps {
                echo 'Scanning Docker Image with Trivy'
            }
        }
    }
}






      
