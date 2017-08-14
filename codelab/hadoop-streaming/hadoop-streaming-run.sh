#!/usr/bin/env bash

hdfs_input_path='/tmp/input'
hdfs_output_path='/tmp/output'
hadoop  fs -test -d  $hdfs_output_path
if [ $? -ne 0 ];then
	echo "hdfs outpath is not exist; test return num is:$?"
	else
	echo "hdfs outpath is exist,prepare to remove it!"
	hadoop fs -rm -r $hdfs_output_path
fi                    
streaming_jar='/usr/lib/hadoop-current/share/hadoop/tools/lib/hadoop-streaming-*.jar'
hadoop jar $streaming_jar \
	-mapper hadoop-streaming-map.py \
	-reducer hadoop-streaming-reduce.py \
	-file hadoop-streaming-*.py \
	-input $hdfs_input_path \
	-output $hdfs_output_path

        #-D mapred.map.tasks=20 \  
        #-D mapred.reduce.tasks=10 \
