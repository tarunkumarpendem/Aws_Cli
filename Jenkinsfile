pipeline{
    agent {
        label 'MVN3'
    }
    stages{
        stage('url'){
            steps{
                git url: 'https://github.com/tarunkumarpendem/Aws_Cli.git',
                    branch: 'master'
            }
        }
        stage('script'){
            steps{
                sh 'sh ec2.sh'
            }
        }
    }
}
