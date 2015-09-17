#!/bin/bash

for dir in `ls -d */`;
do echo $dir;
   echo "";
   grep -h 'library(' $dir/*.Rmd | sort | uniq;
   echo "";
done
