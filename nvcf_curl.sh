#!/usr/bin/env bash
echo ''
echo '========= NVCF CURL Test ========='
echo ''

source .env
export NGC_API_KEY=$NVIDIA_API_KEY
export FUNCTION_ID=5214df69-a442-49f0-a025-98d39e3bb80a

echo $NGC_API_KEY
echo "https://api.nvcf.nvidia.com/v2/nvcf/pexec/functions/${FUNCTION_ID}"
echo ''

curl -X POST "https://api.nvcf.nvidia.com/v2/nvcf/pexec/functions/${FUNCTION_ID}" \
 -H "Authorization: Bearer ${NGC_API_KEY}" \
 -H "Accept: application/json" \
 -H "Content-Type: application/json" \
 -d '{
         "model": "meta/llama-3.1-8b-instruct",
         "messages": [
             {
                 "role":"user",
                 "content":"Is this inference endpoint working? One dot for yes, two for no."
             }
         ],
         "max_tokens": 32
     }'

