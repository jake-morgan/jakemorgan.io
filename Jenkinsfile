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
                sh 'hugo version'
                sh 'hugo -s site'
                sh 'docker build --no-cache -t ${IMAGE_NAME}:latest .'
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
        stage('Docker Deploy') {
            agent any
            options { skipDefaultCheckout(true) }
            steps {
                sshagent (['jenkins-ssh']) {
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@jakemorgan.io "cd /home/jake/morganj.co.uk; sudo docker-compose pull && sudo docker-compose up -d"'
                }
            }
        }
    }
}
