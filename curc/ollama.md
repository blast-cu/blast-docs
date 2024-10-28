# Ollama Setup on CURC

## Links
- ### [Ollama](https://ollama.com/)
- ### [Ollama GitHub](https://github.com/ollama/ollama)
- ### [Ollama REST API](https://github.com/ollama/ollama/blob/main/docs/api.md)

## Setup

1. In your `projects` directory, create a new directory for Ollama:
    ```bash
    mkdir -p /projects/$USER/ollama
    cd /projects/$USER/ollama
    ```
2. Note the latest Ollama version on GitHub. Download the linux distribution and unzip it:
    ```bash
    export ollama_ver="v0.3.14"
    curl -L https://github.com/ollama/ollama/releases/download/${ollama_ver}/ollama-linux-amd64.tgz -o ollama
    tar -xzvf ollama
   ```
3. Make the binary executable:
    ```bash
    chmod +x ./bin/ollama
    ```
4. Start up an interactive job on CURC:
    ```bash
    sinteractive --account=<account_name> --partition=<partition_name> --qos=<qos_name> --time=01:00:00 --ntasks=16 --gres=gpu:1 --mem=20G
    ```
   Note that the `--ntasks` and `--mem` values are just placeholders and not optimized. Adjust them as needed. Make sure you allocate enough GPUs such that you have sufficient VRAM to run your model of choice. <br/><br/>
5. Add the following to your `~/.bashrc` file. Update the paths as needed.
    ```bash
    export PATH="$PATH:/projects/$USER/ollama/bin"
    export OLLAMA_TMPDIR="/rc_scratch/$USER/ollama_temp"
    export OLLAMA_MODELS="/rc_scratch/$USER/ollama/models"
    export OLLAMA_HOST="0.0.0.0:9999"
    export OLLAMA_NUM_PARALLEL=1
    export OLLAMA_MAX_LOADED_MODELs=1
    ```
6. Source your `~/.bashrc` file:
    ```bash
    source ~/.bashrc
    ```
7. Make the directories, in case they don't exist:
    ```bash
    mkdir -p $OLLAMA_TMPDIR
    mkdir -p $OLLAMA_MODELS
    ```
8. Start the Ollama server in the background:
    ```bash
    nohup ollama serve > log.txt 2>&1 &
    ```
9. Run and chat with Llama 3.1 in the terminal:
    ```bash
    ollama run llama3.1:8b-instruct-fp16
    ```
10. If you want to use the REST API instead, after running `ollama serve`, you can connect to the server from any RC resource using its IP Address. To find the IP Address, run:
    ```bash
    hostname -I
    ```
    Then, you can use the REST API to chat with Llama 3.1. For example:
    ```bash
    curl http://10.225.8.160:9999/api/generate -d '{
      "model": "llama3.1:8b-instruct-fp16", 
      "prompt": "Why is the sky blue?", 
      "stream": false
    }'
    ```
   