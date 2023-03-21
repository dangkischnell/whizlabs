pipeline {
    agent any
    stages {
        stage('Intializing the project') {
            steps {
                echo 'Welcome to Opstree Labs' 
            }
        }
        stage('Wait for user Input for Recreate deployment') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            steps {
                sh 'echo "Moving ahead"'
            }
        }
        stage('Deploying Basic Infra with V1 VMS') {
            steps {
              withCredentials([
                usernamePassword(credentialsId: '63715168-c881-45f2-a269-873208bf331e', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY')
              ]) {
                sh '''
                cd cd/tf
                terraform init
                terraform validate
                
                terraform apply --auto-approve -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET} -var ami_id=ami-01a2825a801771f57
                terraform output elb_dns_name 
                '''
              }
            }
        }
        stage('Bringing down V1 VMs') {
            input {
                message "Shall we bring down V1 VM's?"
                ok "Yes, we should."
            }
            steps {
                sh '''
                cd cd/tf
                terraform init
                terraform validate
                terraform plan -var='ami_id=ami-0772503ce7123061b' -var='min_capacity=0' -var='desired_capacity=0' -out myplan
                terraform apply --auto-approve myplan
                '''
            }
        }
        stage('Bringing up V2 VMs') {
            input {
                message "Shall we start bring up V2 VM's?"
                ok "Yes, we should."
            }
            steps {
                sh '''
                cd cd/tf
                terraform init
                terraform validate
                terraform plan -var='ami_id=ami-0dfbacb1982b17aba' -out myplan
                terraform apply --auto-approve myplan
                '''
            }
        }
        stage('Terminate') {
            input {
                message "Terminate setup?"
                ok "Yes, we should."
            }
            steps {
                sh '''
                cd cd/tf
                terraform destroy --auto-approve
                '''
            }
        }
    }
}