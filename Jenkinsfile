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
                sh 'cd site; hugo'
            }
        }
        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                sh 'pwd; ls; cd site; pwd; ls'
                // need to add the deployment instructions here
            }
        }
    }
}
