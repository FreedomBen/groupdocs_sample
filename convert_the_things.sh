#!/usr/bin/env bash

SUCCESSES=successes.log
FAILURES=failures.log

FAILURE_LOGS_DIR=failure_logs

mkdir -p $FAILURE_LOGS_DIR

rm $SUCCESSES $FAILURES

for i in inputs/*; do
  log_file="$(echo $i | sed -e 's/\s/_/g')"
  echo "Passing in $i"
  java -Xms3072m -Xmx4096m -jar target/GroupDocs-1.0-SNAPSHOT.jar "$i" > $log_file 2>&1
  if [ "$?" = "0" ]; then
    echo "$i" >> $SUCCESSES
    rm $log_file
  else
    echo "$i" >> $FAILURES
    mv $log_file ${FAILURE_LOGS_DIR}/
  fi
done
