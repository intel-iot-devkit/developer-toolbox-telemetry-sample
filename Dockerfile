# Copyright (C) 2023 Intel Corporation
# SPDX-License-Identifier: Apache-2.0


FROM docker.io/openvino/ubuntu20_dev:2022.3.0

WORKDIR /app
RUN mkdir model

# Copy model files
COPY benchmark/resnet.mapping model/       
COPY benchmark/resnet.xml model/
COPY benchmark/resnet.bin model/
COPY benchmark/telemetry_client.py .
COPY benchmark/benchmark.py /usr/local/lib/python3.8/dist-packages/openvino/tools/benchmark/benchmark.py


# Copy the .whl file and benchmark.py (renamed telemetry_client.py) to their respective locations
COPY telemetry/fps-instrumentation/telemetrysender-1.1.0-py3-none-any.whl /tmp/telemetrysender-1.1.0-py3-none-any.whl

# Install the .whl file using pip
RUN pip install /tmp/telemetrysender-1.1.0-py3-none-any.whl

# Copy the go.sh and telemetry.config files
COPY benchmark/go.sh .
COPY telemetry/fps-instrumentation/telemetry.config /etc/

# Set the default environment variable for the go.sh script
ENV ARGUMENT_VALUE benchmark

# Start the application or perform other actions
ENTRYPOINT ["/app/go.sh", "$ARGUMENT_VALUE"]






# Copy the .whl file from telemetry/fps-instrumentation to the container
# Copy the telemetry_client.py file to the container
# Install the .whl file using pip
RUN pip install /tmp/telemetrysender-1.1.0-py3-none-any.whl



