pipeline{
    agent any

    parameters {
        booleanParam(name: "TERRAFORM_PLAN", defaultValue: false, description: "")
        booleanParam(name: "TERRAFORM_APPLY", defaultValue: false, description: "")
        booleanParam(name: "TERRAFORM_DESTROY", defaultValue: false, description: "")
    }

    stages{
        stage("Clone Repo") {
            steps {
                echo "================== Clone Repository =================="
                // Clean workspace before cloning
                deleteDir()

                // Clone git repository
                git branch: "master", url: "https://github.com/jojwayoung/devops-project1-terraform-jenkins.git"

                sh "ls -al"
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credential-jwayoung']]){
                    dir('infra') {
                        sh 'echo "================== TERRAFORM INIT =================="'
                        sh 'terraform init'
                    }
                }
            }
        }

        stage("Terraform Plan") {
            steps {
                script {
                    if(params.TERRAFORM_PLAN) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credential-jwayoung']]){
                            dir("infra") {
                                sh 'ehco "================== TERRAFORM PLAN =================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage("Terraform Apply"){
            steps {
                script {
                    if (params.TERRAFORM_APPLY) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credential-jwayoung']]) {
                            dir("infra") {
                                sh 'ehco "================== TERRAFORM APPLY =================="'
                                sh 'terraform apply'
                            }
                        }
                    }
                }
            }
        }

        stage("Terraform Destroy") {
            steps {
                script {
                    if (params.TERRAFORM_DESTROY) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credential-jwayoung']]) {
                            dir("infra") {
                                sh 'ehco "================== TERRAFORM DESTROY =================="'
                                sh 'terraform destroy'
                            }
                        }
                    }
                }
            }
        }
    }
}
