#!/bin/bash

#using variable for values
name=(orange banana apple)
name[1]="cherry"


echo "first index: ${name[0]}"

echo "second index: ${name[1]}"

echo "third index: ${name[2]}"

echo "all variable: ${name[*]}"

