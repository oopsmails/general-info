#!/bin/bash

INSTALL_FOLDER=/c/Programs

JAVA_HOME=$INSTALL_FOLDER/openjdk-11

PATH="${JAVA_HOME}/bin:${PATH}" export PATH
# PATH="${PATH}:${JAVA_HOME}/bin" export PATH

echo $PATH

