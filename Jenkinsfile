pipeline {
  agent any

  environment {
    ARM_CLIENT_ID       = credentials('AZURE_CREDENTIALS_JSON')
    ARM_CLIENT_SECRET   = credentials('AZURE_CREDENTIALS_JSON')
    ARM_SUBSCRIPTION_ID = '<your-subscription-id>'
    ARM_TENANT_ID       = credentials('AZURE_CREDENTIALS_JSON')
  }

  parameters {
    choice(name: 'ENVIRONMENT', choices: ['staging', 'production'], description: 'Select environment')
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/your-org/project3-iac.git'
      }
    }

    stage('Init Terraform') {
      steps {
        dir('project3-iac') {
          sh 'terraform init'
        }
      }
    }

    stage('Validate') {
      steps {
        dir('project3-iac') {
          sh 'terraform validate'
        }
      }
    }

    stage('Plan') {
      steps {
        dir('project3-iac') {
          sh 'terraform plan -var-file="envs/${ENVIRONMENT}.tfvars"'
        }
      }
    }

    stage('Apply') {
      when {
        expression { return params.ENVIRONMENT == 'production' || params.ENVIRONMENT == 'staging' }
      }
      steps {
        input message: "Approve deployment to ${params.ENVIRONMENT}?"
        dir('project3-iac') {
          sh 'terraform apply -auto-approve -var-file="envs/${ENVIRONMENT}.tfvars"'
        }
      }
    }
  }
}
