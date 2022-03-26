pipeline{
    agent{
        label 'docker && maven'
    }
    tools {
        maven '3.8.5'
    }
    environment {
        IMAGE_NAME = 'aline-underwriter'
        APP_VERSION = '0.1.0'
        REGISTRY_URI = 'public.ecr.aws/l4g0u1s9'
        AWS_REGION = 'us-east-1'
    }
    stages{
        stage('Get AWS Credentials') {
            steps {
                sh """
                    aws ecr-public get-login-password --region ${AWS_REGION} |\
                     docker login --username AWS --password-stdin ${REGISTRY_URI}
                """
            }
        }
        stage('Package Jar') {
            steps{
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Build Image'){
            steps{
                // get microservice name and version from pom.xml, then build image
                sh """
                    VERSION=\$(grep -m 1 "<version>" pom.xml | awk -F'[><]' \'{print \$3}\')
                    echo \$VERSION
                    MODULE=\$(grep -m 2 "<module>" pom.xml | tail -1 | awk -F'[><]' \'{print \$3}\')
                    docker build . \
                        --build-arg NAME=\${MODULE} \
                        --build-arg VERSION=\${VERSION} \
                        --build-arg DIR=\${MODULE} \
                        -t ${IMAGE_NAME}:${APP_VERSION}
                """
            }
        }
        stage('Deploy to ECR'){
            steps{
                // create repo if it doesn't already exist
                sh """
                    aws ecr-public create-repository --repository-name ${IMAGE_NAME} || true
                """
                // add repo tag and push to aws
                sh """
                    docker tag ${IMAGE_NAME}:${APP_VERSION} ${REGISTRY_URI}/${IMAGE_NAME}:${APP_VERSION}
                    docker push ${REGISTRY_URI}/${IMAGE_NAME} --all-tags
                """
            }
        }
    }
}