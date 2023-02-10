#!/bin/bash

export JAVA_HOME=$(alternatives --list |grep java_sdk_openjdk | awk '{print $3}');
export M2_HOME=/opt/maven;
export MAVEN_HOME=/opt/maven;
export PATH=${M2_HOME}/bin:${PATH}
