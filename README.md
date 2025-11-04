# llms-on-hpc

This document reproduces the commands in the LLMs on HPC workshop presentation. It has been updated assuming you are running the workshop using your regular account, instead of the course account provided to you during the workshop.

Link to the full presentation: [LLMs on HPC](https://docs.google.com/presentation/d/1lw5FUAJuziGIb5GpviSy2t-Swo2EU-aZ/edit?usp=sharing&ouid=105690574600061947997&rtpof=true&sd=true)

# Setup


Set `OLLAMA_MODELS` if you are on the Bouchet cluster and want to use the models that were pre-downloaded for the workshop. If you don't set this variable, ollama will download models to your home directory. Either option is fine.

```bash
export OLLAMA_MODELS=/nfs/roberts/project/hpcllm/shared/.ollama
```


If you cloned this repo (`ycrc/llms-on-hpc`), you don't need to perform the next two commands.
Also, the copy command below will only work on bouchet.

```bash
mkdir ~/ycrc_llm_workshop
cp /apps/data/training/hpc_llm/ollama.ipynb ~/ycrc_llm_workshop
```

# Running Ollama

```bash
salloc –p devel --mem=10G
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

```bash
salloc -p gpu_devel --gpus=1

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

Create an environment to run the jupyter note book.

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




