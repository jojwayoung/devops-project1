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
                echo "======== Clone Repository (V.1) ========"
                // Clean workspace before cloning
                deleteDir()

                // Clone git repository
                git branch: "master", url: "https://github.com/jojwayoung/devops-project1-terraform-jenkins.git"

                sh "ls -al"
            }
            /* 
            post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "========A execution failed========"
                }
            }
            */
        }
        /*
        stage("Terraform Init") {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credential-jwayoung']]) {
                    dir("infra") {
                        sh 'echo "========= Terraform Init ========="'
                        sh 'terrafrom init'
                    }
                }
            }
        }
        */
        stage('Terraform Init') {
            sh 'terraform --version'
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credential-jwayoung']]){
                    sh 'whoami; ls -al'
                    dir('infra') {
                        sh 'echo "=================Terraform Init (V.1) =================="'
                        sh 'terraform init'
                    }
                }
            }
        }

        stage("Terraform Plan") {
            steps {
                script {
                    if(params.TERRAFORM_PLAN) {
                        withCredentials() {
                            dir("infra") {
                                sh 'ehco "========= Terraform Plan ========="'
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
                                sh 'ehco "========= Terraform Apply ========="'
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
                                sh 'ehco "========= Terraform Destroy ========="'
                                sh 'terraform destroy'
                            }
                        }
                    }
                }
            }
        }
    }
}
