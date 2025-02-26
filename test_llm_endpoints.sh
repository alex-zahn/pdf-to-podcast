#!/usr/bin/env bash

if [ ! -f .venv/bin/activate ]; then
	make uv
	source .venv/bin/activate
	python -m ensurepip --upgrade
else
	source .venv/bin/activate
fi

python -c "import opentelemetry.instrumentation.redis" 
install=$?

if [ $install -ne 0 ]; then
	python -m pip install --upgrade -r requirements.txt
	python -m pip install --upgrade -r services/AgentService/requirements.txt
fi

source .env
export NVIDIA_API_KEY=$NVIDIA_API_KEY

./nvcf_curl.sh

python test_langchain.py
echo ''
python services/AgentService/test_llmmanager.py

