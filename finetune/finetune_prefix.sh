formatted_time=$(date +"%Y%m%d%H%M%S")
echo $formatted_time


deepspeed --include localhost:0 finetune_prefix.py \
    --model_name_or_path /root/autodl-tmp/MiniCPM-2B-sft-fp32 \
    --output_dir /root/autodl-tmp/output/$formatted_time/ \
    --train_data_path /root/MiniCPM/result/train.json \
    --eval_data_path /root/MiniCPM/result/dev.json \
    --learning_rate 1e-4 --per_device_train_batch_size 1 \
    --per_device_eval_batch_size 1 --fp16 --use_lora \
    --gradient_accumulation_steps 1 --warmup_steps 100 \
    --max_steps 3000 --weight_decay 0.01 \
    --evaluation_strategy steps --eval_steps 3000\
    --save_strategy steps --save_steps 3000 --seed 42 \
    --log_level info --logging_strategy steps --logging_steps 10 \
    --deepspeed configs/ds_config_zero2_offload.json