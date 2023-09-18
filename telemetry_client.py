opyright (C) 2023 Intel Corporation
# SPDX-License-Identifier: MIT

import time
from telemetrysender import TelemetrySender
import numpy as np


def generate_sine_wave():
    # Generate a time array from 0 to 10 with a step of 0.01
    time = np.arange(0, 10, 0.01)
    # Generate a sine wave with a frequency of 2 Hz
    frequency = 2
    amplitude = 1
    sine_wave = amplitude * np.sin(2 * np.pi * frequency * time)
    return np.round(sine_wave, decimals=2)


data = [
    {
        "avg_fps": 276.9953697430091,
        "start_time": 0,
    }
]

# Create an instance of the TelemetrySender class with the metric name and TOML configuration file path
telemetrysender = TelemetrySender(metric_name="FPS")

# Open a connection for telemetry sending
telemetrysender.open_connection()

# Generate a sine wave

while True:
    sinWave = generate_sine_wave()

    try:
        # Iterate over the values in the sine wave
        for count, value in enumerate(sinWave):
            data[0]["avg_fps"] = value
            data[0]["start_time"] = time.time()
            telemetrysender.send_telemetry(telemetry_data=data)
            time.sleep(1)

    except Exception as e:
        # Print any exceptions that occur during the loop
        print(f"Exception is: {e}, {type(e)}")
    time.sleep(5)

# Close the telemetry connection
telemetrysender.close_connection()

