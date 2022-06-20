
pipeline {
  agent any

  stages {
    stage("Hello") {
      steps {
        echo "hello"

        // Script blocks can run any Groovy script
        script {
          String res = env.MAKE_RESULT
          if (res != null) {
            echo "Setting build result ${res}"
            currentBuild.result = res
          } else {
            echo "All is well"
          }
        }
      }
      // Post in Stage executes at the end of Stage instead of end of Pipeline
      post {
        aborted {
          echo "Stage 'Hello' WAS ABORTED"
        }
        always {
          echo "Stage 'Hello' finished"
        }
        changed {
          echo "Stage HAVE CHANGED"
        }
        failure {
          echo "Stage FAILED"
        }
        success {
          echo "Stage was Successful"
        }
        unstable {
          echo "Stage is Unstable"
        }
      }
    }

    stage('Build') {
        steps {
            echo 'Building..'
        }
    }
    stage('Test') {
        steps {
            echo 'Testing..'
        }
    }
    stage('Deploy') {
        steps {
            echo 'Deploying....'
        }
    }
  }

  // All Stages and Pipeline can each have their own post section that is executed at different times
  post {
    always {
      echo "Pipeline is done"
    }
  }
}

