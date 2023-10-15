pipeline {
    node {
        label 'ubuntu22_04'
    }
    stages {
           stage('Testing stage') {
               steps {
                sh "echo 'test'"
               }
           }

    //     stage('Checkout') {
    //         steps {
    //             // Checkout your source code repository
    //             checkout scmGit(branches: [[name: '**']],
    //                 extensions: [],
    //                 userRemoteConfigs: [[credentialsId: '55bb6d47-49a5-4f07-b4be-300de67195e2',
    //                 url: 'https://github.com/marinaimeninnik/Docker-L2.git']])
    //         }
    //     }

    //     stage('Lint Dockerfile') {
    //         steps {
    //             script {
    //                 // Install hadolint (assuming it's available in the system)
    //                 sh "apt-get update && apt-get install -y hadolint"

    //                 // Specify the path to your Dockerfile
    //                 def dockerfilePath = 'Dockerfile'

    //                 // Run hadolint to lint the Dockerfile
    //                 sh "hadolint ${dockerfilePath}"
    //             }
    //         }
    //     }

    //     // Add more stages for building and deploying your Docker image, if needed.
    // }

    // post {
    //     always {
    //         // This block will be executed no matter whether the pipeline succeeds or fails.
    //         cleanWs()  // Clean up workspace (delete project files and directories)
    //         // archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true  // Archive artifacts
    //         deleteDir()  // Delete the entire Jenkins workspace
    //     }

    //     success {
    //         // This block will be executed only if the pipeline succeeds.
    //         echo 'Job was successful.'
    //     }

    //     failure {
    //         // This block will be executed only if the pipeline fails.
    //         echo 'Job failed.'
        // }
    }
}
