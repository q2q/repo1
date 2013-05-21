#!/bin/bash 

export PATH=/usr/local/cuda-5.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib64:/usr/local/cuda-5.0/lib
./cudaminer -l 56x8,56x8 -C 1,1 --url=http://${1}:8332 --userpass=growl.${2}:x