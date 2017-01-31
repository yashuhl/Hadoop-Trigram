Name: Yashaswini Huskur Lingarajaiah
UBID: 50204545
UBIT NAME: yhuskurl

JOB IDS:UniMapReduce:           job_1480947435876_0510UniMapDualReduce:       job_1480947435876_0511UniMapTripleReduce:     job_1480947435876_0513DualMapUniReduce:       job_1480947435876_0512DualMapDualReduce:      job_1480947435876_0514DualMapTripleReduce:    job_1480947435876_0516TripleMapUniReduce:     job_1480947435876_0515TripleMapDualReducer:   job_1480947435876_0517TripleMapTripleReducer: job_1480947435876_0518

Instruction for running
Need to run in the terminal mac or linux
create the jar file in the hadoop-2.7.3/share/hadoop/mapreduce folder where the wordcount inbuilt jar file is present.
in the script give the username of the system like in my system /User/yashuvinay
change accordingly and run.

Run according to cases,
1 for Uni mapper
2 for Dualmapper
3 for Triplemapper

sh runTrigram.sh 1
sh runTrigram.sh 2
sh runTrigram.sh 3
 
check the output files in hadoop-2.7.3/