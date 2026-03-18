# flipper zero SLIX-L/Toniebox dump converter
# converts your old nfc3 slix-l dumps to nfcv4
# nfc v4 used since unleashed 0.66
# don't know for ofw or others

import os
import sys

def update_file_content(lines):
  """
  Args: flipper zero nfc3 toniebox dump
  Returns: flipper zero nfc4 toniebox dump
  """

  for i, line in enumerate(lines):
    if line.startswith("Version:"):
      lines[i] = line.replace("Version: 3", "Version: 4")

  for i, line in enumerate(lines):
    if line.startswith("Device type:"):
      lines[i] = line.replace("Device type: ISO15693", "Device type: SLIX-L")

  # Toniebox password needed 
  lines.append("Password Privacy: 00 00 00 00\n")
  lines.append("Password Destroy: FF FF FF FF\n")
  lines.append("Password EAS: 00 00 00 00\n")
  lines.append("Lock EAS: false\n")
  return lines

def main():
  if len(sys.argv) != 2:
    print("Error_ not enough arguments.")
    print("Usage: python3 fnfcv3_to_nfcv4.py <filename>")
    return
  filepath = sys.argv[1]
  filename, _ = os.path.splitext(filepath)
  with open(filepath, "r") as f:
    lines = f.readlines()
  lines = update_file_content(lines)
  new_filepath = f"{filename}.v4.nfc"
  with open(new_filepath, "w") as f:
    f.writelines(lines)
  print(f"File '{new_filepath}' converted.")
if __name__ == "__main__":
  main()
