#!/bin/bash

curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | \
  sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
  echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | \
  sudo tee /etc/apt/sources.list.d/ngrok.list && \
  sudo apt update && sudo apt install ngrok

nohup ngrok http 80 --log=stdout > ngrok.log &

jupyter notebook --notebook-dir=/content --ip='*' \
    --port=8888 --no-browser --allow-root \
    --NotebookApp.allow_origin='https://colab.research.google.com' \
    --NotebookApp.port_retries=0
