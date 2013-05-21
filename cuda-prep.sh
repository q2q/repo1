#!/bin/bash
sudo apt-get -y install freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev gcc make libcurl4-openssl-dev autoconf git screen libncurses5-dev libdb4.8-dev 
cd ~/
wget http://developer.download.nvidia.com/compute/cuda/5_0/rel-update-1/installers/cuda_5.0.35_linux_64_ubuntu11.10-1.run

sudo bash cuda_5.0.35_linux_64_ubuntu11.10-1.run -silent -driver -toolkit

export PATH=/usr/local/cuda-5.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib64:/usr/local/cuda-5.0/lib
echo "PATH=/usr/local/cuda-5.0/bin:$PATH" >> .bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib64:/usr/local/cuda-5.0/lib" >> .bashrc

cd repo1
mv driver.sh startcuda.sh ~/
cd cudaminer-2*/cudaminer-src*
chmod +x configure autotools.sh configure.sh
./configure 
make
cp cudaminer ~/cudaminer 


