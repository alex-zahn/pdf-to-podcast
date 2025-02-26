print('\n============ Basic Langchain Integration Test ================\n')

from langchain_nvidia_ai_endpoints import (
    register_model, 
    Model, 
    ChatNVIDIA
)
import os
import json

with open('models.json') as f:
    config = json.loads(f.read())['reasoning']

api_key = os.getenv("NVIDIA_API_KEY")
base_url=config['api_base']
model_name=config['name']

print('\n')
print(api_key)
print('base_url=',base_url)
print('model_name=',model_name)

print('\n**\n')

base_url=f'{base_url}'

register_model(Model(
    id=model_name, 
    model_type="chat", 
    client="ChatNVIDIA", 
    endpoint=base_url
))


llm = ChatNVIDIA(
    model=model_name,
    #base_url=base_url,
    api_key=api_key,
    max_tokens=32,
)
for chunk in llm.stream("How far can a seagull fly in one day?"):
    print(chunk.content, end="|")

print('\n\n============ End Langchain Integration Test ================\n\n')
