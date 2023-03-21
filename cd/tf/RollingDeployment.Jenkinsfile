pipeline {
    agent any
    stages {
        stage('Intializing the project') {
            steps {
                echo 'Welcome to Opstree Labs' 
            }
        }
        stage('Wait for user Input for Rolling deployment') {
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
                cd cd/tf
                terraform init
                terraform validate
                terraform plan -var='ami_id=ami-01a2825a801771f57' -out myplan -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
                terraform apply --auto-approve myplan -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
                terraform output elb_dns_name -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
                '''
            }
        }
        stage('Step1 of Rolling Deployment') {
            input {
                message "Shall we bring first VM with V2 ?"
                ok "Yes, we should."
            }
            steps {
                sh '''
                cd cd/tf
                terraform init
                terraform validate
                terraform plan -var='ami_id=ami-0dfbacb1982b17aba' -var='desired_capacity=3' -out myplan
                terraform apply --auto-approve myplan
                terraform plan -var='ami_id=ami-0dfbacb1982b17aba' -var='desired_capacity=2' -out myplan
                terraform apply --auto-approve myplan
                '''
            }
        }
        stage('Step2 of Rolling Deployment') {
            input {
                message "Shall we bring second VM with V2 ?"
                ok "Yes, we should."
            }
            steps {
                sh '''
                cd cd/tf
                terraform init
                terraform validate
                terraform plan -var='ami_id=ami-0dfbacb1982b17aba' -var='desired_capacity=3' -out myplan
                terraform apply --auto-approve myplan
                terraform plan -var='ami_id=ami-0dfbacb1982b17aba' -var='desired_capacity=2' -out myplan
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