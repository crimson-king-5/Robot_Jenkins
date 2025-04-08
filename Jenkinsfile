pipeline {
    agent any

    environment {
        RESULTS_DIR = 'results'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                pip install robotframework robotframework-seleniumlibrary robotframework-xunit
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                sh '''
                mkdir -p ${RESULTS_DIR}
                robot --outputdir ${RESULTS_DIR} --xunit xunit.xml tests/
                '''
            }
        }

        stage('Generate Xray Token') {
            steps {
                withCredentials([
                    string(credentialsId: 'Clien_ID', variable: 'CLIENT_ID'),
                    string(credentialsId: 'Client_Secret', variable: 'CLIENT_SECRET')
                ]) {
                    script {
                        def token = sh(
                            script: """
                            curl -s -X POST https://xray.cloud.getxray.app/api/v2/authenticate \\
                            -H "Content-Type: application/json" \\
                            -d '{
                                "client_id": "${CLIENT_ID}",
                                "client_secret": "${CLIENT_SECRET}"
                            }'
                            """,
                            returnStdout: true
                        ).trim()
                        env.XRAY_TOKEN = token.replaceAll('"', '')
                    }
                }
            }
        }

        stage('Upload Results to Xray') {
            steps {
                sh '''
                curl -X POST https://xray.cloud.getxray.app/api/v2/import/execution/junit \\
                     -H "Content-Type: application/xml" \\
                     -H "Authorization: Bearer ${XRAY_TOKEN}" \\
                     --data @${RESULTS_DIR}/xunit.xml
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/*', fingerprint: true
        }
    }
}
