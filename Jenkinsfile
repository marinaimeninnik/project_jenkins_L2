pipeline {
    agent {
        label 'ubuntu22_04'
    }

    environment {
        GIT_CREDENTIALS = credentials('55bb6d47-49a5-4f07-b4be-300de67195e2')
    }

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
                sh 'sudo docker run --rm -i hadolint/hadolint < Docker/Dockerfile'
            }
        }

        stage('Save artifact') {
            steps {
                archiveArtifacts artifacts: 'index.php', fingerprint: true
            }
        }
    }


   post {
        success {
            script {
                def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                def gitUrl = 'https://github.com/marinaimeninnik/project_jenkins_L2.git'
                def github = github()
                github.setCommitStatus(
                    context: 'Jenkins',
                    state: 'SUCCESS',
                    sha1: gitCommit,
                    targetUrl: env.BUILD_URL,
                    description: 'Build successful'
                )
            }
        }
        failure {
            script {
                def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                def gitUrl = 'https://github.com/marinaimeninnik/project_jenkins_L2.git'
                def github = github()
                github.setCommitStatus(
                    context: 'Jenkins',
                    state: 'FAILURE',
                    sha1: gitCommit,
                    targetUrl: env.BUILD_URL,
                    description: 'Build failed'
                )
            }
        }
    }
}
