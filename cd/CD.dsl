folder('demo')
folder('demo/CD')

pipelineJob("demo/CD/RecreateDeployment") {
	definition {
		cpsScm {
			scm {
				git {
					remote {
						url("git@github.com:dangkischnell/whizlabs.git")
					}
					branch("*/main")
				}
			}
			scriptPath("cd/tf/RecreateDeployment.Jenkinsfile")
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
						url("git@github.com:dangkischnell/whizlabs.git")
					}
					branch("*/main")
				}
			}
			scriptPath("cd/tf/RollingDeployment.Jenkinsfile")
			lightweight(lightweight = true)
		}
	}
}
