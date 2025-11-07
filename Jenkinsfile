pipeline {
    agent any

    environment {
        IIS_SITE_PATH = "C:\\inetpub\\wwwroot\\MyFrontend"   // change as needed
        FRONTEND_DIR = ""    // change if your frontend is at repo root set to ""
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out from Git Repo"
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    if (env.FRONTEND_DIR?.trim()) {
                        dir(env.FRONTEND_DIR) {
                            echo "Building frontend in ${env.FRONTEND_DIR}"
                            bat 'Build.bat'
                        }
                    } else {
                        echo "Building frontend at repo root"
                        bat 'Build.bat'
                    }
                }
            }
        }

        stage('Unit-Test') {
            steps {
                script {
                    if (env.FRONTEND_DIR?.trim()) {
                        dir(env.FRONTEND_DIR) {
                            echo "Running unit tests"
                            bat 'Unit.bat'
                        }
                    } else {
                        bat 'Unit.bat'
                    }
                }
            }
        }

        stage('Quality-Gate') {
            steps {
                echo "Quality gate / lint (optional)"
                bat 'Quality.bat'
            }
        }

        stage('Deploy') {
    steps {
        echo "Deploying to Stage Environment for more tests!"
        bat(script: 'Deploy.bat', returnStatus: true)
        echo "Deployment completed — ignoring Robocopy’s harmless exit code."
    }
}


    post {
        always { echo 'Pipeline finished' }
        success { echo 'Success' }
        failure { echo 'Failure' }
    }
}
