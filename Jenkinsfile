pipeline {
    agent {
        docker {
            image 'jakemorgan/hugo:latest'
        }
    }
    stages {
        stage('Build') {
            when {
                branch 'master'
            }
            steps {
                sh ls
            }
        }
        stage('Test') {
            when {
                branch 'master'
            }
            steps {
                echo 'Tests go here'
            }
        }
        stage('Deploy') {
            when {
                branch 'master'
            } steps {
                echo 'Deploy goes here'
            }
        }
    }
    post {
        success {
            echo "Build successful"
        }
        failure {
            echo "Build successful"
        }
    }
}
