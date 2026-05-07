pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/blackwatermelon0000/midlab.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install scikit-learn joblib pandas numpy fastapi uvicorn --break-system-packages'
            }
        }

        stage('Train Model') {
            steps {
                sh 'python3 train.py'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh 'docker stop midlab-api || true'
                sh 'docker rm midlab-api || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t midlab-api .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 8000:8000 --name midlab-api --restart unless-stopped midlab-api'
            }
        }
    }

    post {
        success {
            echo 'Pipeline done! API running at port 8000.'
        }
        failure {
            echo 'Pipeline failed. Check console output.'
        }
    }
}
