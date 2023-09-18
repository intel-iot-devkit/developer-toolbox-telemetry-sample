#!/bin/bash
#=======================================================================
# Copyright (C) 2023 Intel Corporation
# SPDX-License-Identifier: MIT
#=======================================================================
# Script: benchmark.sh
# Description: A script for executing a benchmark application or a Python
#              script based on the value of the ARGUMENT_VALUE variable.
#
# Usage: ./benchmark.sh [ARGUMENT_VALUE]
#   - ARGUMENT_VALUE: Set this variable to 'sine' to execute a Python
#                     script or leave it empty to run the benchmark app.
#=======================================================================

arg=${ARGUMENT_VALUE:-benchmark}
echo "Executing Benchmark App"

# Run indefinitely
while true; do
    if [ "$arg" = "sine" ]; then
        echo "Calling Python script"
        python3 telemetry_client.py
    else
        echo "Executing Benchmark App"
        benchmark_app -api sync -m model/resnet.xml -hint throughput -t 20 -d CPU -shape [1,223,224,3]
    fi

    echo "Sleeping for 10 seconds"
    sleep 10
done
exit $?

