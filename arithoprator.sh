#!/bin/bash

var1=10
var2=30

add=$(expr $var1 + $var2)
echo "add value: $add"

sub=$(expr $var1 - $var2)
echo "sub value: $sub"

mul=$(expr $var1 \* $var2)
echo "mul value: $mul"

div=$(expr $var1 / $var2)
echo "div value: $div"

mod=$(expr $var1 % $var2)
echo "mod value: $mod"

