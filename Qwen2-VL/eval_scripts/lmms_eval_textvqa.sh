#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

# export HF_ENDPOINT=https://hf-mirror.com
export HF_DATASETS_CACHE="/cache/huggingface/"
export HF_HOME="/cache/huggingface/"
export HUGGINGFACE_HUB_CACHE="/cache/huggingface/"
export TRANSFORMERS_CACHE="/cache/huggingface/"

model_id="/cache/huggingface/Qwen2-VL-7B-Instruct"
model_name="Qwen2-VL-7B-Instruct"
output_path="./logs/${model_name}/${task}/"
mkdir -p "$output_path"

pruned_layer=2
reduction_ratio=$1
pivot_image_token=4
threshold=$2
token_batch=$3


python3 -m accelerate.commands.launch \
    --num_processes=8 \
    --main_process_port 50008 \
    -m lmms_eval \
    --model qwen2_vl \
    --model_args pretrained=$model_id,max_pixels=1003520,device_map=cuda,use_flash_attention_2=False,Sparse=True,pruned_layer=$pruned_layer,reduction_ratio=$reduction_ratio,pivot_image_token=$pivot_image_token,threshold=$threshold,token_batch=$token_batch \
    --tasks textvqa \
    --batch_size 1 \
    --log_samples \
    --output_path "$output_path" \
