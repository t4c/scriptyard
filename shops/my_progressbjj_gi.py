#!/usr/bin/env python3
"""
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.

Progress BJJ is my favorite brand but their stock is a nightmare. 
Since their notifications suck I built this. OSS.
"""

import json
import urllib.request
import urllib.error

# --- CONFIGURATION ---
# Choose your color: "white", "black", or "blue"
COLOR = "white" 

# The handles for the bundle components
JACKET_HANDLE = f"m6-lite-jacket-{COLOR}"
PANTS_HANDLE = f"bjj-pants-{COLOR}"

# Target sizes for your search
TARGET_JACKET_SIZES = ["A2L", "A3L"]
TARGET_PANT_SIZES = ["A3L"]

# TARGET FABRICS: Check one or both ("Cotton", "Ripstop")
TARGET_PANT_FABRICS = ["Cotton", "Ripstop"]
# ---------------------

def get_product_json(handle):
    url = f"https://progressjj.co.uk/products/{handle}.js"
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    }
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=10) as response:
            return json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        if e.code == 404:
            return None
        print(f"Error connecting to {handle}: HTTP {e.code}")
        return None
    except Exception as e:
        print(f"Error connecting to {handle}: {e}")
        return None

def check_stock():
    jacket_data = get_product_json(JACKET_HANDLE)
    pants_data = get_product_json(PANTS_HANDLE)

    if not jacket_data:
        print(f"[ERROR] Could not find Jacket product. Check handle: {JACKET_HANDLE}")
    if not pants_data:
        print(f"[ERROR] Could not find Pants product. Check handle: {PANTS_HANDLE}")
    
    if not jacket_data or not pants_data:
        return

    print(f"--- Progress BJJ Inventory Report ({COLOR.upper()}) ---")
    print(f"Checking for Jacket sizes: {', '.join(TARGET_JACKET_SIZES)}")
    print(f"Checking for Pants: {', '.join(TARGET_PANT_SIZES)} in {', '.join(TARGET_PANT_FABRICS)}\n")

    # JACKET CHECK
    print(f"[{jacket_data['title'].upper()}]")
    j_available = False
    for v in jacket_data.get("variants", []):
        size = v.get("option1")
        if size in TARGET_JACKET_SIZES:
            status = "AVAILABLE" if v.get("available") else "OUT OF STOCK"
            print(f"- Size {size}: {status}")
            j_available = True
    if not j_available: print("No matching sizes found.")

    # PANTS CHECK
    print(f"\n[{pants_data['title'].upper()}]")
    p_available = False
    for v in pants_data.get("variants", []):
        title = v.get("title") 
        if any(s in title for s in TARGET_PANT_SIZES) and any(f in title for f in TARGET_PANT_FABRICS):
            status = "AVAILABLE" if v.get("available") else "OUT OF STOCK"
            print(f"- {title}: {status}")
            p_available = True
    if not p_available: print(f"No matching pants found in your sizes/fabrics.")

if __name__ == "__main__":
    check_stock()
