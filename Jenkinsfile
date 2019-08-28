pipeline {
    agent none

    options {
        disableConcurrentBuilds()
        buildDiscarder(
            logRotator(
                daysToKeepStr: '365',
                artifactDaysToKeepStr: '365'
            )
        )
        skipDefaultCheckout(false)
    }

    stages {
        stage('Build') {
             agent {
                docker {
                    image 'jakemorgan/hugo:latest'
                    args '-v /disk1/jenkins_home/workspace/jakemorgan.io_master/public:/disk1/jenkins_home/workspace/jakemorgan.io_master/site/public -u 0'
                    alwaysPull true
                }
            }
            steps {
                sh 'hugo version'
                sh 'hugo -s site'
            }
        }
        stage('Deploy') {
            agent any
            options { skipDefaultCheckout(true) }
            steps {
                sshagent (['jenkins-ssh']) {
                    sh 'pwd; ls public/; ls site/; ls site/public'
                    // Remove all files in nginx folder and make sure the html file is present
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io sudo rm -rf /usr/share/nginx/html'
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io sudo mkdir -p /usr/share/nginx/html'
                    // Copy files into home dir
                    sh 'scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r public jenkins@jakemorgan.io:~/'
                    // Move files from home dir to nginx folder and delete old folder
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io "sudo mv ~/public/* /usr/share/nginx/html"'
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io rm -rf ~/public'
                }
                sh 'sudo rm -rf /tmp/public'
            }
            post {
                always {
                    echo 'Pipeline finished, cleaning up'
                    sh 'sudo rm -rf public/'
                    sh 'sudp rm -rf site/public/'
                }
            }
        }
    }
}
