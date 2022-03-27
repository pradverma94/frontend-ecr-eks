//59b8faec-d998-4ac7-af96-1352d86b595e
//062768259532.dkr.ecr.ap-south-1.amazonaws.com/frontend-app:latest
pipeline{
	agent{
		kubernetes{

		}
	}
	environment{
		AWS_ACCOUNT_NUMBER = "dasdas"
		AWS_REGION = ""
		JENKINS_AWS_ID = "dasdsa"
	}
	stages{
		stage('docker image'){
			steps{
				script{
					// sh 'rm -f ~/.dockercfg ~/.docker/config.json || true'
					// configure registry
					docker.withRegistry('https://062768259532.dkr.ecr.ap-south-1.amazonaws.com', 'ecr:ap-south-1:59b8faec-d998-4ac7-af96-1352d86b595e') {
					// build image
					def customImage = docker.build("frontend-app")
					// push image
					customImage.push("env.BUILD_ID")
					}
				}
			}
		}
		// stage('git login'){
		// 	steps{
		// 		echo "git login"
		// 	}
		// }

	}
}