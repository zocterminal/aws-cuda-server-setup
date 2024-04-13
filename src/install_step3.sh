#!/bin/bash
# vim: ff=unix


#
# install required python
#
pip install tqdm tiktoken numpy torch transformers

# the instructions from Andrej use 'pythong xyz.py'
if ! which python ; then
	sudo ln -s /usr/bin/python3 /usr/bin/python
fi

#
# get the llm.c github project
#
git clone https://github.com/karpathy/llm.c
mv llm.c llm
cd llm



echo 'Now view the README at https://github.com/karpathy/llm.c'
echo 'Check if CUDA install is complete then log out and log in again'
echo ''

