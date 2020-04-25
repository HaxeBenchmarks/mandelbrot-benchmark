pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS')
        disableConcurrentBuilds()
    }
    triggers {
        cron 'H H/6 * * *'
    }

    stages {
        stage('Prepare Testdata') {
            steps {
                echo 'Prepare results folders'
                sh '''
                mkdir -p results/Haxe-3
                mkdir -p results/Haxe-4
                mkdir -p results/Haxe-nightly
                '''

                echo "Download / update test data (Haxe stdlib, OpenFl and Lime sources)"
                sh '''
                echo "not updating inputdata"
                '''
            }
        }

        stage('Prepare build folders') {
            steps {
                echo 'Preparing build folders for Haxe 3'
                sh '''
                cd versions/Haxe-3
                ln -sfn ../../benchmark.sh . 
                ln -sfn ../../installAndCompileHxcpp.sh . 
                ln -sfn ../../build 
                ln -sfn ../../buildAll.hxml . 
                ln -sfn ../../buildConvertCsv.hxml 
                ln -sfn ../../haxe3_libraries/ haxe_libraries 
                ln -sfn ../../haxelib.json . 
                ln -sfn ../../data data
                ln -sfn /home/benchmarkdata/mandelbrot-benchmark/Haxe-3 results 
                ln -sfn ../../src 
                '''

                echo 'Preparing build folders for Haxe 4'
                sh '''
                cd versions/Haxe-4
                ln -sfn ../../benchmark.sh . 
                ln -sfn ../../installAndCompileHxcpp.sh . 
                ln -sfn ../../build 
                ln -sfn ../../buildAll.hxml . 
                ln -sfn ../../buildConvertCsv.hxml 
                ln -sfn ../../haxe_libraries/ haxe_libraries 
                ln -sfn ../../haxelib.json . 
                ln -sfn ../../data data
                ln -sfn /home/benchmarkdata/mandelbrot-benchmark/Haxe-4 results 
                ln -sfn ../../src 
                '''

                echo 'Preparing build folders for Haxe nightly'
                sh '''
                cd versions/Haxe-nightly
                ln -sfn ../../benchmark.sh . 
                ln -sfn ../../installAndCompileHxcpp.sh . 
                ln -sfn ../../build 
                ln -sfn ../../buildAll.hxml . 
                ln -sfn ../../buildConvertCsv.hxml 
                ln -sfn ../../haxe_libraries/ haxe_libraries 
                ln -sfn ../../haxelib.json . 
                ln -sfn ../../data data
                ln -sfn /home/benchmarkdata/mandelbrot-benchmark/Haxe-nightly results 
                ln -sfn ../../src 
                '''
            }
        }

        stage('Update lix dependencies') {
            steps {
                echo 'Update lix dependencies for Haxe 3'
                sh '''
                cd versions/Haxe-3
                lix download 
                lix install github:HaxeFoundation/hxcpp
                '''

                echo 'Update lix dependencies for Haxe 4'
                sh '''
                cd versions/Haxe-4
                lix download 
                lix install github:HaxeFoundation/hxcpp
                '''

                echo 'Update lix dependencies for Haxe nightly'
                sh '''
                cd versions/Haxe-nightly
                lix download haxe nightly
                lix use haxe nightly
                lix download
                '''

            }
        }

        stage('Build Haxe 3') {
            steps {
                echo 'Build targets for Haxe 3'
                sh '''
                cd versions/Haxe-3
                ./installAndCompileHxcpp.sh
                ./build.sh
                '''
            }
        }

        stage('Build Haxe 4') {
            steps {
                echo 'Build targets for Haxe 4'
                sh '''
                cd versions/Haxe-4
                ./installAndCompileHxcpp.sh
                ./build.sh
                '''
            }
        }

        stage('Build Haxe nightly') {
            steps {
                echo 'Build targets for Haxe nightly'
                sh '''
                cd versions/Haxe-nightly
                ./installAndCompileHxcpp.sh
                ./build.sh
                '''
            }
        }

        stage('Run Haxe 3 benchmarks') {
            steps {
                echo 'Run benchmarks for Haxe 3'
                sh '''
                cd versions/Haxe-3
                readonly VER=`haxe -version`
                echo "Running Haxe $VER benchmark"
                ./benchmark.sh | tee results.csv
                '''
            }
        }

        stage('Run Haxe 4 benchmarks') {
            steps {
                echo 'Run benchmarks for Haxe 4'
                sh '''
                cd versions/Haxe-4
                readonly VER=`haxe -version`
                echo "Running Haxe $VER benchmark"
                ./benchmark.sh | tee results.csv
                '''
            }
        }

        stage('Run Haxe nightly benchmarks') {
            steps {
                echo 'Run benchmarks for Haxe nightly'
                sh '''
                cd versions/Haxe-nightly
                readonly VER=`haxe -version`
                echo "Running Haxe $VER benchmark"
                ./benchmark.sh | tee results.csv
                '''
            }
        }

        stage('Convert results for Haxe 3') {
            steps {
                echo 'Convert results for Haxe 3'
                sh '''
                cd versions/Haxe-3
                haxe buildConvertCsv.hxml
                '''
            }
        }

        stage('Convert results for Haxe 4') {
            steps {
                echo 'Convert results for Haxe 4'
                sh '''
                cd versions/Haxe-4
                haxe buildConvertCsv.hxml
                '''
            }
        }

        stage('Convert results for Haxe nightly') {
            steps {
                echo 'Convert results for Haxe nightly'
                sh '''
                cd versions/Haxe-nightly
                haxe buildConvertCsv.hxml
                '''
            }
        }
    }
}
