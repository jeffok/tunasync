#!/bin/sh

tunasync manager --config /data/conf/manager.conf &
tunasync worker --config /data/conf/worker.conf