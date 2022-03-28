pipeline{
	agent {
		kubernetes {
    	cloud 'kubernetes'
    	inheritFrom 'jenkins-slave'
    	namespace 'jenkins'
		}
	}
	triggers {
        pollSCM('H/2 * * * *')
    }
	environment{
		AWS_ECR_REGISTRY = 'https://062768259532.dkr.ecr.ap-south-1.amazonaws.com'
		AWS_ECR_REPO = 'frontend-app'
		JENKINS_ID_AWS_ECR = 'ecr:ap-south-1:59b8faec-d998-4ac7-af96-1352d86b595e'
	}
	stages {
		stage('docker') {
			steps {
				script {
					sh 'rm -f ~/.dockercfg ~/.docker/config.json || true'
					sh 'docker --version'
					// configure registry
					docker.withRegistry("$AWS_ECR_REGISTRY", "$JENKINS_ID_AWS_ECR") {
						// build image
						def customImage = docker.build("$AWS_ECR_REPO")
						// push image
						customImage.push("${BUILD_NUMBER}")
					}
				}
			}
		}
		stage('Deploying App to Kubernetes') {
			steps {
				script {
					kubernetesDeploy(configs: "deploymentservice.yml | sed s/1.0.0/${BUILD_NUMBER}/g", kubeconfigId: "kubernetes")
				}
			}
		}
	}
}