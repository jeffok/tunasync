#!/bin/sh
set -e

# 启动 manager
tunasync manager --config /data/conf/manager.conf &
MANAGER_PID=$!

# 等待一下确保 manager 启动
sleep 2

# 启动 worker
tunasync worker --config /data/conf/worker.conf &
WORKER_PID=$!

# 等待进程，如果任一进程退出则退出容器
wait $MANAGER_PID $WORKER_PID