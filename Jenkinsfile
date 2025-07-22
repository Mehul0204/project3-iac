pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['staging', 'production'], description: 'Choose the environment')
    }

    environment {
        ARM_CLIENT_ID     = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
        ARM_SUBSCRIPTION_ID = credentials('azure-subscription-id')
        ARM_TENANT_ID     = credentials('azure-tenant-id')
    }

    stages {
        stage('Init Terraform') {
            steps {
                bat 'terraform init -reconfigure'
            }
        }

        stage('Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Plan') {
            steps {
                bat 'terraform plan -var-file="envs/%ENVIRONMENT%.tfvars"'
            }
        }

        stage('Apply') {
            when {
                expression { return params.ENVIRONMENT == 'production' || params.ENVIRONMENT == 'staging' }
            }
            steps {
                input message: "Apply changes to ${params.ENVIRONMENT}?", ok: "Apply"
                bat 'terraform apply -auto-approve -var-file="envs/%ENVIRONMENT%.tfvars"'
            }
        }
    }
}
