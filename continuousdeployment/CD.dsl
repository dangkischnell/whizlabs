folder('demo/CD')


pipelineJob("demo/CD/RecreateDeployment") {
	definition {
		cpsScm {
			scm {
				git {
					remote {
						url("https://gitlab.com/ot-external-training/globallogic/trainers/continuousdeployment.git")
                        credentials("globallogicv3")
					}
					branch("*/main")
				}
			}
			scriptPath("tf/RecreateDeployment.Jenkinsfile")
			lightweight(lightweight = true)
		}
	}
}

pipelineJob("demo/CD/RollingDeployment") {
	definition {
		cpsScm {
			scm {
				git {
					remote {
						url("https://gitlab.com/ot-external-training/globallogic/trainers/continuousdeployment.git")
                        credentials("globallogicv3")
					}
					branch("*/main")
				}
			}
			scriptPath("tf/RollingDeployment.Jenkinsfile")
			lightweight(lightweight = true)
		}
	}
}