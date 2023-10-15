pipeline {
    agent {
        label 'ubuntu22_04'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the Git repository for the current branch
                    checkout scm
                }
            }
        }

        stage('Check Commit Message Length') {
            steps {
                script {
                    def currentBranch = sh(script: 'git rev-parse --abbrev-ref HEAD', returnStatus: true).trim()
                    def commitMessage = sh(script: "git log -n 1 --pretty=format:%B", returnStatus: true).trim()
                    def maxMessageLength = 100  // Set your desired max length

                    if (commitMessage.length() > maxMessageLength) {
                        error("Commit message is too long. Max length is $maxMessageLength characters.")
                    }
                }
            }
        }

        stage('Lint Dockerfile') {
            steps {
                script {
                    // Run a Dockerfile linter on your Dockerfile
                    sh 'docker run --rm -i hadolint/hadolint < Dockerfile'
                }
            }
        }

        stage('Save Artifacts') {
            steps {
                script {
                    // Archive the Dockerfile and any other artifacts
                    archiveArtifacts artifacts: 'Dockerfile', allowEmptyArchive: true
                }
            }
        }
    }

    post {
        failure {
            // Define steps to execute on pipeline failure
            echo "Pipeline failed. You can add additional actions here."
        }
    }
}
