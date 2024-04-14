#!/bin/bash
# vim: ff=unix 

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-nvidia-driver.html
# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/

#
# linux headers for nvidia building
#

echo 'Setting up NVIDIA-CUDA'


#
# check for correct debian kernel version
#
UNAME=$(uname -r)
PAT="^5.10.*-amd64$"

if [[ ! $UNAME =~ $PAT ]]; then
	echo "Incorrect Debian kernel (should be 5.10...-amd64): $UNAME";
	echo "Kernel should be: 5.10.x.xx-xxxxx-amd64";
	echo "Kernel is       : $UNAME";
	exit
fi


# source headers for debian kernel build (required for cuda build)
# (this will fail on some AWS specific debian images, make sure you
# run this on the Debian-11 AMI from Debian)
sudo apt -y install linux-headers-`uname -r` 

# get the cuda driver package
file=cuda_12.0.0_525.60.13_linux.run
if [ ! -f $file ] ; then
	wget https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/$file
fi

# install the driver 
echo 'Building and installing driver ...  (this may take a few minutes)'
echo 'Note: While cuda-install runs, you can continue with step 3 in another tab'
echo ''
sudo bash cuda_12.0.0_525.60.13_linux.run --driver --toolkit --silent # install drivers and toolkit

# check nvidia driver status
nvidia-smi


# setup toolkit ennvironment
if ! echo $PATH | grep -q cuda-12 ; then
	export PATH="/usr/local/cuda-12.0/bin:$PATH"
fi

if ! grep -q cuda-12 .profile; then
	echo 'export PATH="/usr/local/cuda-12.0/bin:$PATH"' >>.profile
fi

sudo ln -s /usr/local/cuda-12.0/targets/x86_64-linux/lib/ /usr/lib/cuda-12
sudo ldconfig

if ! which nvcc ; then
	echo -e "\e[31;1m"
	echo 'Could not find nvcc.'
	echo 'Is your NVIDIA installation complete already?'
	echo 'Make sure /usr/local/cuda-12.0/bin exists and is in the PATH, e.g. type'
	echo '  PATH="/usr/local/cuda-12.0/bin:$PATH"' 
	echo -e "\e[0m"
fi


# done
echo -e "\e[32;1m"
echo 'If after step3 all is good, dont forget to delete the driver package:'
echo '  rm cuda_12*'
echo -e "\e[0m"

