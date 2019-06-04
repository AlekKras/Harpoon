pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh'''
                    echo 'FROM debian:latest’ > Dockerfile
                    echo ‘CMD ["/bin/echo", "HELLO WORLD...."]' >> Dockerfile
                '''
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'calmmytits') {
                        def image = docker.build('snyk/snyk:latest')
                        image.push()
                    }
                }
            }
        }
        stage('analyze') {
            steps {
                sh 'echo "docker.io/snyk/snyk:latest `pwd`/Dockerfile" > anchore_images'
                anchore name: 'anchore_images'
            }
        }
        stage('teardown') {
            steps {
                sh'''
                    for i in `cat anchore_images | awk '{print $1}'`;do docker rmi $i; done
                '''
            }
        }
    }
}
