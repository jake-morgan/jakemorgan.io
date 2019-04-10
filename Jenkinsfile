pipeline {
    agent { docker { image 'python:3.5.1' } }
    stages {
        stage('build') {
            steps {
                sh 'python --version'
                sh '''
                echo "Hello world"
                ls -al
                '''
            }
        }
    }
    post {
        success {
            echo 'The build succeeded'
        }
        failure {
            echo 'The build failed'
        }
    }
}
