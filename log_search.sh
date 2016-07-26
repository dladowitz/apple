#!/bin/bash

# Challenge A: find all .log files within /var/logs folder (including within nested subfolders etc)
find /var/log -name "*log" -type f -exec ls -l {} \;

# Challenge B: output contents of every log file, using one shell liner
for f in $( find /var/log -name "*.log" -type f -exec ls -l {} \; ); do tail -n +1 -- $f; done

# Challenge C: output lines containing timestamps of form 'YYYY-MM-DD HH:MM:SS'
for f in $( find /var/log -name "*.log" -type f -exec ls -l {} \; );
do
  tail -n +1 -- $f | xargs -L 1 bash  -c 'printf "[%s] %s\n" "$(date +%Y-%m-%d\ %H:%M:%S )" "$*" ' bash
done
