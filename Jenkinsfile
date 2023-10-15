pipeline {
    agent {
        label 'ubuntu22_04'
    }

    environment {
        GIT_CREDENTIALS = credentials('55bb6d47-49a5-4f07-b4be-300de67195e2')
    }

// [credentialsId: '55bb6d47-49a5-4f07-b4be-300de67195e2', url: 'https://github.com/marinaimeninnik/Docker-L2.git']]

    stages {
        stage('Clone Git repo') {
            steps {
                withCredentials([usernamePassword(credentialsId: '55bb6d47-49a5-4f07-b4be-300de67195e2', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    git branch: env.BRANCH_NAME, credentialsId: '55bb6d47-49a5-4f07-b4be-300de67195e2', url: 'https://github.com/marinaimeninnik/Docker-L2.git'
                }
            }
        }

        stage('Check commit message length') {
            steps {
                sh 'COMMIT_MSG=$(git log -1 --pretty=%B); if [ ${#COMMIT_MSG} -gt 50 ]; then echo "Commit message too long"; exit 1; fi'
            }
        }

        stage('Lint Dockerfile') {
            steps {
                sh 'docker run --rm -i hadolint/hadolint < Docker/Dockerfile'
            }
        }

        stage('Save artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
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
