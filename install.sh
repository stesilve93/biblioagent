#!/bin/bash

# ==============================================================================
# Script to set up a Python environment for the Biblioagent project.
# This script handles environment creation, dependency installation (including
# handling CUDA vs. CPU), and provides instructions for Ollama.
# ==============================================================================

set -e # Exit immediately if a command exits with a non-zero status.

# --- 1. Environment Setup ---
read -p "Enter the name for your Conda environment (e.g., biblioagent): " ENV_NAME

echo "Creating a new conda environment called '$ENV_NAME' with Python 3.10..."
conda create -n "$ENV_NAME" python=3.10 -y

# Check if environment was created successfully
if [ $? -ne 0 ]; then
    echo "Error: Failed to create conda environment. Exiting."
    exit 1
fi

echo "Activating the '$ENV_NAME' environment..."
# The standard way to activate a conda environment in a script
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$ENV_NAME"

# --- 2. Dependency Installation ---
echo "Checking for NVIDIA CUDA-enabled GPU..."
if command -v nvidia-smi &> /dev/null; then
    echo "CUDA GPU detected. Installing PyTorch with CUDA support."
    # The --index-url is specified for CUDA, which is often not needed but safe.
    pip install torch torchvision torchaudio
    pip install faiss-gpu

else
    echo "CUDA GPU not detected. Installing PyTorch with CPU support."
    # Use the --index-url we used in our debug session for CPU packages.
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
    pip install faiss-cpu
fi

echo "Installing other required packages..."
# The --ignore-installed flag is crucial to prevent conflicts with system packages
# like scipy and matplotlib, which was the root cause of many of your errors.
pip install --ignore-installed langchain-community langchain-ollama unstructured unstructured-inference scipy numpy matplotlib

echo "Installation of Python packages is complete."

# --- 3. Ollama CLI Setup ---
echo " "
echo "======================================================================"
echo "      Ollama CLI Installation (Requires a separate step)              "
echo "======================================================================"
echo "Your Python environment is ready. However, you still need the Ollama "
echo "server. The next step is to install the 'ollama' command-line tool."
echo " "
echo "Please visit https://ollama.com/download/linux and follow the one-line"
echo "install script for Linux. It's usually a 'curl' command."
echo " "
echo "Once installed, you can download the model and start the server."
echo " "
echo "Step A: Download the 'llama3' model (one-time download):"
echo "        ollama pull llama3"
echo " "
echo "Step B: Start the Ollama server in a separate terminal window:"
echo "        ollama serve"
echo " "
echo "======================================================================"
echo "Setup is complete. You can now run your agent.py script."
echo " "