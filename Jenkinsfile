pipeline {
    agent any

    environment {
        CLIENT_ID     = credentials('Xray_Client_ID')
        CLIENT_SECRET = credentials('Xray_Client_Secret')
        PROJECT_KEY   = 'POEI20252'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/crimson-king-5/Robot_Jenkins.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'pip install robotframework robotframework-seleniumlibrary'
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat '''
                    mkdir results
                    robot --outputdir results --xunit xunit.xml tests/
                '''
            }
        }

        stage('Generate Xray Token') {
            steps {
                bat """
                    curl -X POST https://xray.cloud.getxray.app/api/v2/authenticate ^
                    -H "Content-Type: application/json" ^
                    -d "{\\"client_id\\": \\"${CLIENT_ID}\\", \\"client_secret\\": \\"${CLIENT_SECRET}\\"}" ^
                    -o token.txt
                """
            }
        }

        stage('Upload Results to Xray') {
            steps {
                bat '''
                    set /p TOKEN=<token.txt
                    curl -X POST "https://xray.cloud.getxray.app/api/v2/import/execution/junit?projectKey=%PROJECT_KEY%" ^
                    -H "Content-Type: application/xml" ^
                    -H "Authorization: Bearer %TOKEN%" ^
                    --data @results\\xunit.xml
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**/*.*', fingerprint: true
        }
    }
}
