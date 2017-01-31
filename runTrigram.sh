
#!/bin/bash
option="${1}" 
cd /Users/yashuvinay/Desktop/MyStuff/DS-Principles/Hadoop/hadoop-2.7.3
mkdir HadoopInputFile
inputFileNumber=1
for inputDate in {7..9};
do
    for inputFile in {1..18};
    do
        curl -O http://chroniclingamerica.loc.gov/lccn/sn83030214/1920-0$inputDate-03/ed-1/seq-$inputFile/ocr.txt
        mv ocr.txt HadoopInputFile/File$inputFileNumber.txt
        inputFileNumber=$(($inputFileNumber+1))
    done
done
cp HadoopInputFile/File1.txt HadoopInputFile/File44.txt
cp HadoopInputFile/File2.txt HadoopInputFile/File45.txt

esac case ${option} in 

1)

mkdir HadoopInputFile/singleFile
touch HadoopInputFile/singleFile/singleFile.txt
for placeFile in {1..45};
do
cat HadoopInputFile/File$placeFile.txt >> HadoopInputFile/singleFile/singleFile.txt
done

#uniMapperReducer
./bin/hdfs dfs -rmr /input/Yashu/uniMapperReducerInput
./bin/hdfs dfs -mkdir /input/Yashu/uniMapperReducerInput
./bin/hdfs dfs -put HadoopInputFile/singleFile/singleFile.txt /input/Yashu/uniMapperReducerInput/singleFile.txt

./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/uniMapperReducerInput /input/Yashu/uniMapperReducerOutput1 1
./bin/hdfs dfs -get /input/Yashu/uniMapperReducerOutput1/part-r-00000 uniMapperReducerOutput1.txt
grep $'\t1' uniMapperReducerOutput1.txt | wc -l
 
./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/uniMapperReducerInput /input/Yashu/uniMapperReducerOutput2 2
./bin/hdfs dfs -get /input/Yashu/uniMapperReducerOutput2/part-r-00000 uniMapperReducerOutput2.txt
grep $'\t1' uniMapperReducerOutput2.txt | wc -l
 
./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/uniMapperReducerInput /input/Yashu/uniMapperReducerOutput3 3
./bin/hdfs dfs -get /input/Yashu/uniMapperReducerOutput3/part-r-00000 uniMapperReducerOutput3.txt
grep $'\t1' uniMapperReducerOutput3.txt | wc -l
 

;;

2)

mkdir HadoopInputFile/doubleFile
touch HadoopInputFile/doubleFile/File1.txt
touch HadoopInputFile/doubleFile/File2.txt
for placeFile in {1..24};
do
cat HadoopInputFile/File$placeFile.txt >> HadoopInputFile/doubleFile/File1.txt
done
for placeFile in {25..45};
do
cat HadoopInputFile/File$placeFile.txt >> HadoopInputFile/doubleFile/File2.txt
done

#twoMapper
./bin/hdfs dfs -rmr /input/Yashu/doubleMapperInput
./bin/hdfs dfs -mkdir /input/Yashu/doubleMapperInput
./bin/hdfs dfs -put HadoopInputFile/doubleFile/File1.txt /input/Yashu/doubleMapperInput/File1.txt
./bin/hdfs dfs -put HadoopInputFile/doubleFile/File2.txt /input/Yashu/doubleMapperInput/File2.txt

./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/doubleMapperInput /input/Yashu/doubleMapperReducerOutput1 1
./bin/hdfs dfs -getmerge /input/Yashu/doubleMapperReducerOutput1/ doubleMapperReducerOutput1.txt
grep $'\t1' doubleMapperReducerOutput1.txt | wc -l

./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/doubleMapperInput /input/Yashu/doubleMapperReducerOutput2 2
./bin/hdfs dfs -getmerge /input/Yashu/doubleMapperReducerOutput2/ doubleMapperReducerOutput2.txt
grep $'\t1' doubleMapperReducerOutput2.txt | wc -l

./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/doubleMapperInput /input/Yashu/doubleMapperReducerOutput3 3
./bin/hdfs dfs -getmerge /input/Yashu/doubleMapperReducerOutput3/ doubleMapperReducerOutput3.txt
grep $'\t1' doubleMapperReducerOutput3.txt | wc -l
;;


3)

mkdir HadoopInputFile/trippleFile
touch HadoopInputFile/trippleFile/File1.txt
touch HadoopInputFile/trippleFile/File2.txt
touch HadoopInputFile/trippleFile/File3.txt
for placeFile in {1..15};
do
cat HadoopInputFile/File$placeFile.txt >> HadoopInputFile/trippleFile/File1.txt
done
for placeFile in {16..30};
do
cat HadoopInputFile/File$placeFile.txt >> HadoopInputFile/trippleFile/File2.txt
done
for placeFile in {31..45};
do
cat HadoopInputFile/File$placeFile.txt >> HadoopInputFile/trippleFile/File3.txt
done

#threeMapper
./bin/hdfs dfs -rmr /input/Yashu/trippleMapperInput
./bin/hdfs dfs -mkdir /input/Yashu/trippleMapperInput
./bin/hdfs dfs -put HadoopInputFile/trippleFile/File1.txt /input/Yashu/trippleMapperInput/File1.txt
./bin/hdfs dfs -put HadoopInputFile/trippleFile/File2.txt /input/Yashu/trippleMapperInput/File2.txt
./bin/hdfs dfs -put HadoopInputFile/trippleFile/File3.txt /input/Yashu/trippleMapperInput/File3.txt

./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/trippleMapperInput /input/Yashu/trippleMapperReducerOutput1 1
./bin/hdfs dfs -getmerge /input/Yashu/trippleMapperReducerOutput1/ trippleMapperReducerOutput1.txt
grep $'\t1' trippleMapperReducerOutput1.txt | wc -l

./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/trippleMapperInput /input/Yashu/trippleMapperReducerOutput2 1
./bin/hdfs dfs -getmerge /input/Yashu/trippleMapperReducerOutput2/ trippleMapperReducerOutput2.txt
grep $'\t1' trippleMapperReducerOutput1.txt | wc -l

./bin/hadoop jar MyTrigram.jar MyTrigram.MyTrigram /input/Yashu/trippleMapperInput /input/Yashu/trippleMapperReducerOutput3 1
./bin/hdfs dfs -getmerge /input/Yashu/trippleMapperReducerOutput3/ trippleMapperReducerOutput3.txt
grep $'\t1' trippleMapperReducerOutput1.txt | wc -l

;;

*)  
      echo "`basename ${0}`:usage: " 
      exit 1 # Command to come out of the program with status 1
      ;; 
esac 
