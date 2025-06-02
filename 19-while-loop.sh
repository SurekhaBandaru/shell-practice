#!/bin/bash

a=10

while [ $a -lt 0 ]; do
    echo $a
    a='expr $a + 1'
done
