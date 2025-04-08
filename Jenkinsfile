pipeline {
    agent any

    environment {
        RESULTS_DIR = 'results'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                bat '''
                pip install robotframework robotframework-seleniumlibrary robotframework-xunit
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat '''
                mkdir %RESULTS_DIR%
                robot --outputdir %RESULTS_DIR% --xunit xunit.xml tests/
                '''
            }
        }

        stage('Generate Xray Token') {
            steps {
                withCredentials([
                    string(credentialsId: 'Clien_ID', variable: 'CLIENT_ID'),
                    string(credentialsId: 'Client_Secret', variable: 'CLIENT_SECRET')
                ]) {
                    bat '''
                    curl -X POST https://xray.cloud.getxray.app/api/v2/authenticate ^
                         -H "Content-Type: application/json" ^
                         -d "{\\"client_id\\": \\"%CLIENT_ID%\\", \\"client_secret\\": \\"%CLIENT_SECRET%\\"}" ^
                         -o token.txt
                    '''
                }
            }
        }

        stage('Upload Results to Xray') {
            steps {
                bat '''
                set /p TOKEN=<token.txt
                curl -X POST https://xray.cloud.getxray.app/api/v2/import/execution/junit ^
                     -H "Content-Type: application/xml" ^
                     -H "Authorization: Bearer %TOKEN%" ^
                     --data @%RESULTS_DIR%\\xunit.xml
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
