#!/bin/bash
# Fix imports from pytorch/xla/test
export PYTHONPATH=$(dirname ${BASH_SOURCE[0]:-$0})/..

export PJRT_DEVICE=TPU

export XRT_SHARD_WORLD_SIZE=8
export TPU_CHIPS_PER_PROCESS_BOUNDS=1,1,1
export TPU_PROCESS_BOUNDS=2,2,1
export TPU_PROCESS_ADDRESSES=localhost:8476,localhost:8477,localhost:8478,localhost:8479

TPU_VISIBLE_DEVICES=0 TPU_PROCESS_PORT=8476 CLOUD_TPU_TASK_ID=0 $* &
TPU_VISIBLE_DEVICES=1 TPU_PROCESS_PORT=8477 CLOUD_TPU_TASK_ID=1 $* &
TPU_VISIBLE_DEVICES=2 TPU_PROCESS_PORT=8478 CLOUD_TPU_TASK_ID=2 $* &
TPU_VISIBLE_DEVICES=3 TPU_PROCESS_PORT=8479 CLOUD_TPU_TASK_ID=3 $*
