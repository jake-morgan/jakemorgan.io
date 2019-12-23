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

    environment {
        IMAGE_NAME = 'jakemorgan/jakemorgan.io'
        DOCKER_USERNAME = credentials('docker-username')
        DOCKER_PASSWORD = credentials('docker-password')
    }

    stages {
        stage('Build') {
             agent {
                docker {
                    image 'jakemorgan/hugo:latest'
                    args '-v /var/run/docker.sock:/var/run/docker.sock \
                          -v /disk1/jenkins_home/workspace/jakemorgan.io_master/public:/disk1/jenkins_home/workspace/jakemorgan.io_master/site/public -u 0'
                    alwaysPull true
                }
            }
            steps {
                sh 'pwd; ls;'
                sh 'hugo version'
                sh 'hugo -s site'
                sh 'docker build -t ${IMAGE_NAME} .'
                sh 'echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin'
                sh 'docker push ${IMAGE_NAME}'
            }
            post {
                always {
                    echo 'Pipeline finished, cleaning up'
                    sh 'sudo rm -rf public/'
                }
            }
        }
        // stage('Deploy') {
        //     agent any
        //     options { skipDefaultCheckout(true) }
        //     steps {
        //         sshagent (['jenkins-ssh']) {
        //             sh 'pwd; ls public/; ls site/; ls site/public'
        //             // Remove all files in nginx folder and make sure the html file is present
        //             sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io sudo rm -rf /usr/share/nginx/html'
        //             sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io sudo mkdir -p /usr/share/nginx/html'
        //             // Copy files into home dir
        //             sh 'scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r public jenkins@jakemorgan.io:~/'
        //             // Move files from home dir to nginx folder and delete old folder
        //             sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io "sudo mv ~/public/* /usr/share/nginx/html"'
        //             sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io rm -rf ~/public'
        //         }
        //     }
        //     post {
        //         always {
        //             echo 'Pipeline finished, cleaning up'
        //             sh 'sudo rm -rf public/'
        //             sh 'sudo rm -rf site/public/'
        //         }
        //     }
        // }
        stage('Docker Deploy') {
            agent any
            options { skipDefaultCheckout(true) }
            steps {
                sshagent (['jenkins-ssh']) {
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io "cd /home/jake/jakemorgan.io; sudo docker-compose pull && sudo docker-compose up -d"'
                }
            }
        }
    }
}
