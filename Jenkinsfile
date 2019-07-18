pipeline {
    agent {
        docker {
            image 'jakemorgan/hugo:latest'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh 'hugo -s site'
            }
        }
        stage('Deploy') {
            steps {
                sshagent (['jenkins-ssh']) {
                    // Remove all files in nginx folder and make sure the html file is present
                    sh 'ssh-add -L'
                    sh 'ssh jenkins@jakemorgan.io sudo rm -rf /usr/share/nginx/html'
                    sh 'ssh jenkins@jakemorgan.io mkdir -p /usr/share/nginx/html'
                    // Copy files into home dir
                    sh 'scp -r site/public jenkins@jakemorgan.io:~/'
                    // Move files from home dir to nginx folder and delete old folder
                    sh 'ssh jenkins@jakemorgan.io "sudo mv ~/public/* /usr/share/nginx/html"'
                    sh 'ssh jenkins@jakemorgan.io rm -rf ~/public'
                }
            }
        }
    }
}
