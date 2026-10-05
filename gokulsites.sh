#!/bin/bash

# Script to start or stop the ecommerce and mockaroo sites.
# syntax: ./gokulsites.sh [START|STOP]
# ##########################################################

path1=~/softs/mockaroo_clone_site/mockaroo-clone/
path2=~/softs/ecommerce_proj

checkapp()
{
webps=`ps -ef | grep $1 |  awk  'NR==2{print $2}'`

if [ "$webps" != "" ]
then
 echo "Already Running $1 with PID: " $webps
 return  1
else 
 return 0;
fi
}

syntax()
{
echo "Usage:"
echo "   ./gokulsites.sh [START|STOP] "
echo ""
return 1
}

if [ "$1" == "" ]
then
syntax
fi


if [[ $1 == "STOP" || $1 == "stop" ]]; then
   echo 'Stopping both services:MOCKAROO and ecommerce site'
    MOCKAROO_PID=$(pgrep node)
    ECOMMERCE_PID=$(pgrep java)
    kill -9 $MOCKAROO_PID $ECOMMERCE_PID
fi

if [[ $1 == "START" || $1 == "start" ]]; then
    checkapp  node
    status=$?
 if [ "$status" == "0" ]; then
    echo "web server:ecom started "
    cd $path1
    npm start > /dev/null 2>&1 &
    MOCKAROO_PID=$(pgrep node)
    echo "web server:mockaroo started (PID: $MOCKAROO_PID)"
 fi
   checkapp java
   status=$?
  if [ "$status" == "0"  ]; then
    echo "web server:mockaroo started "
    cd $path2
    java -jar ecommerce-0.0.1-SNAPSHOT.jar  > /dev/null 2>&1 &
    ECOMMERCE_PID=$(pgrep java)
    echo "web server:ecom started (PID: $ECOMMERCE_PID)"
  fi

fi







