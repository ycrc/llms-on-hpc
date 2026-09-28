#!/bin/bash

set -ue

if [[ "$CLUSTER" == "grace" || "$CLUSTER" == "mccleary" ]]; then
	shared=/gpfs/gibbs/project/hpcllm/shared/.ollama
elif [[ "$CLUSTER" == "bouchet" ]]; then
	shared=/nfs/roberts/project/hpcllm/shared/.ollama
else
	echo "Could not find CLUSTER $CLUSTER"
	exit 1
fi

# This script points OLLAMA_MODELS at the shared course model directory,
# which is only accessible from course accounts (hpcllm_<netid>).
if [[ "$USER" == hpcllm_* ]]; then
	:
else
	echo "This script is only for course accounts (netid must be hpcllm_<netid>)."
	echo "Do not run it as '$USER'. See README.md for setup on your regular account."
	exit 1
fi

# Remove any existing OLLAMA_MODELS line(s) so re-running this script
# doesn't stack duplicate exports in ~/.bashrc.
sed -i '/^[[:space:]]*export[[:space:]]\+OLLAMA_MODELS=/d' ~/.bashrc

echo -e "Setting OLLAMA_MODELS=$shared in ~/.bashrc\n"
echo "export OLLAMA_MODELS=$shared" >> ~/.bashrc

echo -e 'Copying workshop materials to ~/ycrc_llm_workshop\n'

if [ -d ~/ycrc_llm_workshop/.git ]; then
	(cd ~/ycrc_llm_workshop && git pull)
else
	git clone https://github.com/ycrc/llms-on-hpc.git ~/ycrc_llm_workshop
fi

echo -e '\nScript complete. To set OLLAMA_MODELS,  run "source ~/.bashrc", or log in and out.'
