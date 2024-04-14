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
if [ ! -d ~/llm ] ; then
	git clone https://github.com/karpathy/llm.c
	mv llm.c llm
fi

if ! which nvcc ; then
	echo -e "\e[31;1m"
	echo 'Could not find nvcc.'
	echo 'Is your NVIDIA installation complete already?'
	echo 'Make sure /usr/local/cuda-12.0/bin exists and is in the PATH, e.g. type'
	echo '  PATH="/usr/local/cuda-12.0/bin:$PATH"' 
	echo -e "\e[0m"
	return
fi


cd llm

cat <<EOF

View the README at https://github.com/karpathy/llm.c

Commands from the README/tutorial to run: 
- python prepro_tinyshakespeare.py
- python train_gpt2.py

- make train_gpt2
- OMP_NUM_THREADS=8 ./train_gpt2

- make test_gpt2
- ./test_gpt2

- make test_gpt2cu
- ./test_gpt2cu

- make train_gpt2cu
- ./train_gpt2cu

- python train_gpt2.py --inference_only 1 --write_tensors 0 --sequence_length 1024 --batch_size 4

- python train_gpt2.py --inference_only 1 --write_tensors 0 --sequence_length 1024 --batch_size 4 --compile 1 --tensorcores 1

EOF
