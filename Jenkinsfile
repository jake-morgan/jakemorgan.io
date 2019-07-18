pipeline {
    agent none
    // agent {
    //     docker {
    //         image 'jakemorgan/hugo:latest'
    //     }
    // }

    stages {
        stage('Build') {
             agent {
                docker {
                    image 'jakemorgan/hugo:latest'
                    args '-v "/tmp/public:/public'
                }
            }
            steps {
                // sh 'docker run --name hugo-container --rm'
                sh 'hugo -s site -d public/'
                sh 'pwd; ls; ls site'
                sh 'ls /; ls /public'
            }
        }
        stage('Deploy') {
            agent any
            steps {
                sh 'ls /tmp/public'
                sshagent (['jenkins-ssh']) {
                    // Remove all files in nginx folder and make sure the html file is present
                    sh 'ssh-add -L'
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io sudo rm -rf /usr/share/nginx/html'
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io sudo mkdir -p /usr/share/nginx/html'
                    // Copy files into home dir
                    sh 'scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r /tmp/public jenkins@jakemorgan.io:~/'
                    // Move files from home dir to nginx folder and delete old folder
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io "sudo mv ~/public/* /usr/share/nginx/html"'
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io rm -rf ~/public'
                }
            }
        }
    }
}
