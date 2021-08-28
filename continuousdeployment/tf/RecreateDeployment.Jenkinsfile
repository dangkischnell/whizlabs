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
                sh '''
                cd tf
                terraform init
                terraform validate
                terraform plan -var='ami_id=ami-077b78992957fe05b' -out myplan
                terraform apply --auto-approve myplan
                terraform output elb_dns_name
                '''
            }
        }
        stage('Bringing down V1 VMs') {
            input {
                message "Shall we bring down V1 VM's?"
                ok "Yes, we should."
            }
            steps {
                sh '''
                cd tf
                terraform init
                terraform validate
                terraform plan -var='ami_id=ami-077b78992957fe05b' -var='min_capacity=0' -var='desired_capacity=0' -out myplan
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
                cd tf
                terraform init
                terraform validate
                terraform plan -var='ami_id=ami-05e003760ad016513' -out myplan
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
                cd tf
                terraform destroy --auto-approve
                '''
            }
        }
    }
}