#!/bin/bash

source benchmark.env

readonly DATA=$*

./out/cpp/MandelbrotBenchmark $DATA
./out/cppGCGen/MandelbrotBenchmark $DATA
haxelib run hxcpp out/MandelbrotBenchmark.cppia 
node out/MandelbrotBenchmark.js $DATA
node out/MandelbrotBenchmark.es6.js $DATA
java -jar out/java/MandelbrotBenchmark.jar $DATA
java -jar out/jvm/MandelbrotBenchmark.jar $DATA
hl out/MandelbrotBenchmark.hl $DATA
./out/hl/MandelbrotBenchmark $DATA
mono out/cs/bin/MandelbrotBenchmark.exe $DATA
haxe build/common.hxml --run MandelbrotBenchmark $DATA
php out/php/index.php $DATA
neko out/MandelbrotBenchmark.n $DATA
python3 out/MandelbrotBenchmark.py $DATA
lua out/MandelbrotBenchmark.lua $DATA

# second run to smooth graphs a little
./out/cpp/MandelbrotBenchmark $DATA
./out/cppGCGen/MandelbrotBenchmark $DATA
node out/MandelbrotBenchmark.js $DATA
node out/MandelbrotBenchmark.es6.js $DATA
java -jar out/java/MandelbrotBenchmark.jar $DATA
java -jar out/jvm/MandelbrotBenchmark.jar $DATA
mono out/cs/bin/MandelbrotBenchmark.exe $DATA
php out/php/index.php $DATA
