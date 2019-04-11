pipeline {
    agent {
        docker {
            image 'python:3.5.1'
        }
    }
    stages {
        stage('build') {
            when {
                branch 'master'
            }
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
            mail to: 'jakeelliotmorgan@gmail.com',
                 subject: "Successful Pipeline: ${currentBuild.fullDisplayName}",
                 body: "Successfully built ${env.BUILD_URL}. The build passed"
        }
        failure {
            mail to: 'jakeelliotmorgan@gmail.com',
                 subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                 body: "Something is wrong with ${env.BUILD_URL}. The build failed"
        }
    }
}
