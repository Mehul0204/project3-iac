pipeline {
  agent any

  environment {
    ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
    ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
    ARM_SUBSCRIPTION_ID = '8864012c-7ea2-49ae-9990-16d93f7f357f'
    ARM_TENANT_ID       = '27b36dcb-0186-4824-9333-52aae811a4b8'
  }

  parameters {
    choice(name: 'ENVIRONMENT', choices: ['staging', 'production'], description: 'Select environment')
  }

  stages {
    stage('Init Terraform') {
      steps {
        bat 'terraform init'
      }
    }

    stage('Validate') {
      steps {
        bat 'terraform validate'
      }
    }

    stage('Plan') {
      steps {
        bat 'terraform plan -var-file="envs/${ENVIRONMENT}.tfvars"'
      }
    }

    stage('Apply') {
      when {
        expression { return params.ENVIRONMENT == 'production' || params.ENVIRONMENT == 'staging' }
      }
      steps {
        input message: "Approve deployment to ${params.ENVIRONMENT}?"
        bat 'terraform apply -auto-approve -var-file="envs/${ENVIRONMENT}.tfvars"'
      }
    }
  }
}
