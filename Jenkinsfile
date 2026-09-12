pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh 'uv run pytest'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker compose up -d --build'
            }
        }
    }
}
