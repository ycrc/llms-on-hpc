# llms-on-hpc

This document reproduces the commands in the LLMs on HPC workshop presentation, with descriptions of how the workflow may vary if you are running the workshop using your regular account and/or on another cluster besides Bouchet.

Link to the full presentation: [LLMs on HPC](https://docs.google.com/presentation/d/1lw5FUAJuziGIb5GpviSy2t-Swo2EU-aZ/edit?usp=sharing&ouid=105690574600061947997&rtpof=true&sd=true)

# Setup

>[!NOTE]
>Setting `OLLAMA_MODELS` works best if you are using your course account on bouchet. Don't set this variable if you are running this workshop using your regular account.

```bash
echo 'export OLLAMA_MODELS=/nfs/roberts/project/hpcllm/shared/.ollama' >> .bashrc
```

>[!NOTE]
>If you cloned the `ycrc/llms-on-hpc` repo you don't need to make this directory or copy this file.
>Also, this copy command will only work on bouchet

```bash
mkdir ~/ycrc_llm_workshop
cp /apps/data/training/hpc_llm/ollama.ipynb ~/ycrc_llm_workshop
```

# Running Ollama

>[!NOTE]
>Use a different partition if you are running this workshop with your regular account.

```bash
salloc –p education --mem=10G
```

>[!NOTE]
>You don't need to set `OLLAMA_HOST` as we did in the workshop. New functionality for our ollama module automatically picks an open port.

```bash
module load ollama

ollama serve

ollama list

ollama run llama3.1:8b

```

Enter Prompt: "Why is the Sky blue"?

The model will not respond. Stop the current request, exit the model, and then exit the compute node.

```bash
Ctrl-C

/bye

exit
```

# Running Ollama - with a GPU

>[!NOTE]
>Use a different partition if you are running this workshop with your regular account and/or on a cluster other than bouchet.

```bash
salloc -p education_gpu --gpus=1

nvidia-smi

module load ollama

ollama serve

ollama list

ollama run llama3.1:8b
```

Enter Prompt: "Why is the Sky blue"?

You should have received a response. Exit the model

```bash
/bye
```

Now run a different model:

```bash
ollama run llama3.3:70b
```

Enter Prompt: "Why is the Sky blue"?

It will not respond again, because the GPU is not large enough for the 70b model.

Stop the current request, exit the model, and then exit the compute node.

```bash
Ctrl-C

/bye

exit
```

# Ollama in Jupyter/Python

>[!NOTE]
>If you are using your course account, this environment has already been created for you.

```bash
salloc -p devel --mem=20G

conda create --name ollama python jupyter jupyterlab

conda activate ollama

pip install ollama

ycrc_conda_env.sh update

exit
```

# Reproducibilty and Modelfiles

```bash

vim Modelfile

# Enter settings into the model file
```

>[!NOTE]
>If you are using the shared model directory, you need to postfix your model with a unique identifier (below we use your netid). You don't need to do this if you are not using the shared directory.

```bash
ollama create my_model_$USER -f Modelfile
```




