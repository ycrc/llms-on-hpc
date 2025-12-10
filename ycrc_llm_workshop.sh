#!/bin/sh

set -ue

if [[ "$CLUSTER" == "grace" || "$CLUSTER" == "mccleary" ]]; then
	shared=/gpfs/gibbs/project/hpcllm/shared/.ollama
elif [[ "$CLUSTER" == "bouchet" ]]; then
	shared=/nfs/roberts/project/hpcllm/shared/.ollama
else
	echo "Could not find CLUSTER $CLUSTER"
fi

echo -e "Setting OLLAMA_MODELS=$shared in ~/.bashrc\n"
echo "export OLLAMA_MODELS=$shared" >> ~/.bashrc

echo -e 'Copying workshop materials to ~/ycrc_llm_workshop\n'

git clone https://github.com/ycrc/llms-on-hpc.git ~/ycrc_llm_workshop

echo -e '\nSetup complete. Please log in and out or source .bashrc before loading ollama'

