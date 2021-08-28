folder('demo')
folder('demo/packer')

pipelineJob("demo/packer/v1_ami") {
	definition {
		cpsScm {
			scm {
				git {
					remote {
						url("https://github.com/OT-TRAINING/whizlabs.git")
					}
					branch("*/main")
				}
			}
			scriptPath("packer/v1_packer/V1AMI.jenkinsfile")
			lightweight(lightweight = true)
		}
	}
}


pipelineJob("demo/packer/v2_ami") {
	definition {
		cpsScm {
			scm {
				git {
					remote {
						url("https://github.com/OT-TRAINING/whizlabs.git")
					}
					branch("*/main")
				}
			}
			scriptPath("packer/v2_packer/V2AMI.jenkinsfile")
			lightweight(lightweight = true)
		}
	}
}