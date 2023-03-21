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
        stage('Step1 of Rolling Deployment') {
            input {
                message "Shall we bring first VM with V2 ?"
                ok "Yes, we should."
            }
            steps {
                withCredentials([
                usernamePassword(credentialsId: '63715168-c881-45f2-a269-873208bf331e', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY')
              ]) { 
                sh '''
                cd cd/tf
                terraform init
                terraform validate
                terraform apply --auto-approve -var ami_id=ami-01a2825a801771f57 -var desired_capacity=3  -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
                terraform apply --auto-approve -var ami_id=ami-01a2825a801771f57 -var desired_capacity=2   -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
                '''
              }
            }
        }
        stage('Step2 of Rolling Deployment') {
            input {
                message "Shall we bring second VM with V2 ?"
                ok "Yes, we should."
            }
            steps {
                withCredentials([
                usernamePassword(credentialsId: '63715168-c881-45f2-a269-873208bf331e', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY')
              ]) {                
                sh '''
                cd cd/tf
                terraform init
                terraform validate
                terraform apply --auto-approve -var ami_id=ami-01a2825a801771f57 -var desired_capacity=3  -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
                terraform apply --auto-approve -var ami_id=ami-01a2825a801771f57 -var desired_capacity=3  -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
                '''
              }
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
                terraform destroy --auto-approve -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
                '''
            }
        }
    }
}