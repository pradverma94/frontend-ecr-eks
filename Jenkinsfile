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
		stage('deploy') {
            steps{
                sh script: '''
                #!/bin/bash
				pwd
                cd $WORKSPACE/
				ls | grep yaml
                #get kubectl for this demo
                curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
                chmod +x ./kubectl
				./kubectl version --client --short
				cat ./frontend-app.yaml | sed s/IMG_TAG/${BUILD_NUMBER}/g
				echo "=============="
                cat ./frontend-app.yaml | sed s/IMG_TAG/${BUILD_NUMBER}/g | ./kubectl apply -f -
                '''
        }
    }
		// stage('Deploying App to Kubernetes') {
		// 	steps {
		// 		script {
		// 			sh "ls -a"
		// 			sh "cat frontend-app.yaml | sed s/latest/${BUILD_NUMBER}/g >> ./frontend-app-tmp.yaml"
		// 			sh "ls -a"
		// 			sh "cat frontend-app-tmp.yaml"
		// 			kubernetesDeploy(configs: "frontend-app-tmp.yaml", kubeconfigId: "kubernetes")
		// 		}
		// 	}
		// }
	}
}