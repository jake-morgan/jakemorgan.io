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
                sh 'cd site'
                sh 'pwd'
                sh 'ls'
            }
        }
    }
}
