#!/bin/bash

: ${ALLOY_JAR:=alloy4.2.jar}

if ! [ -f "$ALLOY_JAR" ]; then
    echo "Alloy JAR file not found at $ALLOY_JAR"
    echo "Install it to that location, or set \$ALLOY_JAR to the correct path"
    exit 1
fi

javac -cp "$ALLOY_JAR" AlloyCheck.java
