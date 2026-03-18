"""
FLIPPER SUB TO URH CONVERTER
This tool converts Flipper Zero .sub (RAW) files into IQ complex float data.
Usage: python3 sub_to_iq.py <input.sub> <output.complex>
Import the output in URH as: Complex Float 32, Sample Rate 1MHz.
"""

import sys
import struct
import os

def convert_sub_to_iq(input_path, output_path):
    if not os.path.exists(input_path):
        print(f"Error: Input file '{input_path}' not found.")
        sys.exit(1)

    try:
        with open(input_path, 'r') as f:
            lines = f.readlines()
        
        raw_data = []
        found_data = False
        for line in lines:
            if line.startswith('RAW_Data:'):
                found_data = True
                raw_data.extend(map(int, line.replace('RAW_Data:', '').split()))
        
        if not found_data:
            print("Error: No 'RAW_Data' found in the .sub file. Is it a RAW capture?")
            sys.exit(1)

        sample_rate = 1000000  # 1 MHz
        with open(output_path, 'wb') as f:
            for val in raw_data:
                duration = abs(val)
                # Amplitude 1.0 for positive (High), 0.0 for negative (Low)
                amplitude = 1.0 if val > 0 else 0.0
                # 1 microsecond = 1 sample at 1MHz
                samples_count = int(duration)
                for _ in range(samples_count):
                    # Write I and Q as 32-bit floats (I=amplitude, Q=0)
                    f.write(struct.pack('ff', amplitude, 0.0))
        
        print(f"Success! Converted to {output_path}")

    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 sub_to_iq.py <input.sub> <output.complex>")
        sys.exit(1)
    
    convert_sub_to_iq(sys.argv[1], sys.argv[2])
