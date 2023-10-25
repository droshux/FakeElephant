#!/bin/bash

# These are the options available to use with fep
OPTIONS=('buildall build run buildrun cleanbuild') # Can be expanded later

# Fake ElePhant: A terrible build script for tiny java projects
echo "~~~Fake ElePhant~~~"

# Make sure that the user input a valid option
PLAN=`echo $1 | awk '{print tolower($0)}'`

if [ $# -eq 0 ]; then
  echo "Sourcing completions..."
  complete -W '$OPTIONS' fep
elif [[ ! " ${OPTIONS[*]} " =~ " ${PLAN} " ]]; then
  echo "$PLAN is not a valid option!"
  echo "Options: $OPTIONS"
  exit
fi

run () {
  echo "Running..."
  cd ./build/
  java main
  cd ..
}

build () {
  echo "Building changed files..." 
  cd ./src/  
  for SRCFILE in ./*
  do
    BUILDFILE=`echo $SRCFILE | sed -e 's/java/class/g' | sed -e 's/./..\/build/'` 
    if (( $(date -r $BUILDFILE +%s) < $(date -r $SRCFILE +%s) )); then
      echo " - Building $SRCFILE";
      javac $SRCFILE -d ../build/ 
    fi
  done
  cd ..
  echo "...files built!"
}

buildall () {
  echo "Building all files..."
  javac ./src/* -d ./build/
}

# Run the built project
if [ "$PLAN" = "run" ]; then run; fi

# Build only files that have been changed since the last build
# buildall must be run at least once before this to avoid errors
if [ "$PLAN" = "build" ]; then build; fi 

# Build all files
if [ "$PLAN" = "buildall" ]; then buildall; fi 

# Build and then run
if [ "$PLAN" = "buildrun" ]; then 
  build
  run
fi

if [ "$PLAN" = "cleanbuild" ]; then
  cd ./build/
  rm *.class
  cd ..
  buildall
fi
