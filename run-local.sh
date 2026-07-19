#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

export PYTHONUTF8=1
export MODEL_PATH="MediaTek-Research/BreezyVoice"
export SPEAKER_PROMPT_AUDIO_PATH="./data/example.wav"
export SPEAKER_PROMPT_TEXT_TRANSCRIPTION="今天我們將介紹如何在自己的伺服器上部署語音合成模型，並透過安全的私人網路提供服務。"
export HF_HOME="$HOME/.cache/breezyvoice/huggingface"
export HF_TOKEN=""

exec uv run uvicorn api:app --host 127.0.0.1 --port 34336
