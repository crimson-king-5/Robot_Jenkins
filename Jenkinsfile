pipeline {
    agent any

    environment {
        XRAY_AUTH_URL = 'https://xray.cloud.getxray.app/api/v2/authenticate'
        XRAY_EXPORT_URL = 'https://xray.cloud.getxray.app/api/v2/export/cucumber?keys=POEI20252-526'
        CLIENT_ID = '4605A4D2C42F45CB8F9DC2D31F907A61'
        CLIENT_SECRET = '1afa35803d7e7503def56778a40f15ac6558bf4590e85c838a0386ea41ffa829'
        XRAY_TOKEN = ""
    }

    stages {
        stage('Authenticate with Xray') {
            steps {
                script {
                    def response = bat(script: """
                        curl -H "Content-Type: application/json" -X POST ^
                        ${env.XRAY_AUTH_URL} ^
                        --data "{ \\"client_id\\": \\"${env.CLIENT_ID}\\", \\"client_secret\\": \\"${env.CLIENT_SECRET}\\" }"
                    """, returnStdout: true).trim()

                    def lines = response.readLines()
                    def token = lines[1].replaceAll('"', '').trim()
                   XRAY_TOKEN = token
                   echo "Xray Token: ${XRAY_TOKEN}"
                }
            }
        }
       stage('test'){
            steps{
                bat 'robot -d ./outputs ./tests'
            }
        
        }
        stage('Send Results to Xray') {
            steps {
                script {
                    bat """
                        curl -X POST https://xray.cloud.getxray.app/api/v2/import/execution/robot?projectKey=POEI20252 ^
                        -H "Content-Type: application/xml" ^
                        -H "Authorization: Bearer ${XRAY_TOKEN}" ^
                        --data @"outputs/output.xml"
                    """
                }
            }
        }

        stage('Discord Notification') {
            steps {
                script {
                    bat """
                        curl -X POST https://discordapp.com/api/webhooks/1359154405147934992/2RwoZD57gNSStkB8yxAUT4O7jAe7OOAECZTCuMj9tDW6RBHYUaCjgon1E05MoTjsaQlg ^
                        -H "Content-Type: application/json" ^
                        -d "{\\"username\\": \\"POKAWA Poké bowls\\", \\"content\\": \\"Nous poke Bowls seulement a 18Euros @landrien \\"}" ^ 
                    """
                }
            }
        }

    }}