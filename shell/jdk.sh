#!/bin/bash

JAVA_HOME="$1"

if [ "$JAVA_HOME" = "" ]; then
    echo "Please specify java home"
    exit 1
fi

USER="$USER"
PROFILE="/root/.bash_profile"
echo "Write change to $PROFILE"
cat << EOF >> "$PROFILE"
export JAVA_HOME=$JAVA_HOME
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin
EOF
