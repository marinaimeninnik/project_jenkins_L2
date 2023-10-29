pipeline {
    agent {
        label 'ubuntu22_04'
    }

    environment {
        GIT_CREDENTIALS = credentials('5f407016-3f8c-4868-8f54-e2e660c91a3c')
        GITHUB_TOKEN = sh(script: 'echo $GIT_CREDENTIALS', returnStdout: true).trim()
    }

    stages {
        stage('Clean workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Clone Git repo') {
            steps {
                withCredentials([usernamePassword(credentialsId: '5f407016-3f8c-4868-8f54-e2e660c91a3c', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    git branch: env.BRANCH_NAME, credentialsId: '5f407016-3f8c-4868-8f54-e2e660c91a3c', url: 'https://github.com/marinaimeninnik/project_jenkins_L2.git'
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

        stage('Test Token') {
            steps {
                script {
                    def gitCredentials = credentials('5f407016-3f8c-4868-8f54-e2e660c91a3c')
                    echo "Git Credentials: ${gitCredentials}"
                }
            }
        }
    }

//    post {
//         failure {
//             script {
//                 def pr = currentBuild.rawBuild.getAction(hudson.plugins.git.util.BuildData).lastBuild.revision.pull
//                 if (pr != null) {
//                     def gh = org.jenkinsci.plugins.github.GitHubPRStatus.createGitHub(client: currentBuild.rawBuild.builtOn, repo: pr.head.repo, sha: pr.head.sha)
//                     gh.createStatus(state: 'FAILURE', targetUrl: env.BUILD_URL, description: 'Jenkins CI', context: 'continuous-integration/jenkins')
//                 }
//                 currentBuild.result = 'FAILURE'
//             }
//         }
//         success {
//             script {
//                 currentBuild.result = 'SUCCESS'
//             }
//         }
//         //     //    publishChecks(name: 'Status Reporter', status: 'FAILURE', summary: 'Buld failed')
//         // }
//         // failure {
//         //     script {
//         //         currentBuild.result = 'FAILURE'
//         //     }
//         // }
//         // always
//         //     script {
//         //         if (currentBuild.resultIsBetterOrEqualTo('FAILURE')) {
//         //             echo 'Merge to main had been blocked'
//         //         }
//         //     }

//     }
    post {
       failure {
            script {
                def commitSha = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()

                // Create a commit status indicating failure
                sh("""
                    curl -L -X POST \\
                    -H "Accept: application/vnd.github+json" \\
                    -H "Authorization: Bearer ${GITHUB_TOKEN}" \\
                    -H "X-GitHub-Api-Version: 2022-11-28" \\
                    https://api.github.com/repos/marinaimeninnik/project_jenkins_L2/statuses/${commitSha} \\
                    -d '{"state":"failure","target_url":"https://your-pipeline-failure-url","description":"Pipeline failed","context":"ci/jenkins"}'
                """)
            }
        }
    }
}

