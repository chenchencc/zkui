#!/bin/sh

BASE_DIR=$(pwd)
LIB="${BASE_DIR}/lib/"
JAVA_OPTS=" -Xmx2048m -XX:PermSize=64m -XX:MaxPermSize=512m -XX:+PrintGCDateStamps -XX:+PrintGCDetails -Xloggc:logs/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=1 -XX:GCLogFileSize=1024k -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=logs/mtdperf.hprof -server -Dfile.encoding=UTF-8"
START_CLASS="/home/jasoncc/code/zkui/src/main/java/com/deem/zkui.Main"

echo ${LIB}

for libfile in ${LIB}/*.jar ; do
if [ -f $libfile ] ; then
    CLASSPATH=$libfile:${CLASSPATH}
fi
done

for libfile in ${BASE_DIR}/*.jar ; do
if [ -f $libfile ] ; then
    CLASSPATH=$libfile:${CLASSPATH}
fi
done

CLASSPATH=${BASE_DIR}:${CLASSPATH}
nohup "java" ${JAVA_OPTS} -server -cp ${CLASSPATH} ${START_CLASS} > nohup.out  &
