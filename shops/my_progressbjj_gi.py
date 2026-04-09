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

import requests

# --- CONFIGURATION ---
# Choose your color: "white", "black", or "blue"
COLOR = "white" 

# The handles for the bundle components
JACKET_HANDLE = f"m6-lite-jacket-{COLOR}"
PANTS_HANDLE = f"bjj-pants-{COLOR}"

# Target sizes for your search
TARGET_JACKET_SIZES = ["A2L", "A3L"]
TARGET_PANT_SIZES = ["A2L", "A3L"]

# FABRIC TOGGLE: Uncomment your preference
REQUIRED_FABRIC = "Cotton"
# REQUIRED_FABRIC = "Ripstop"
# ---------------------

def get_product_json(handle):
    url = f"https://www.progressjj-europe.com/products/{handle}.js"
    headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36"}
    try:
        response = requests.get(url, headers=headers)
        if response.status_code == 404:
            return None
        response.raise_for_status()
        return response.json()
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
    print(f"Checking for Pants: {', '.join(TARGET_PANT_SIZES)} in {REQUIRED_FABRIC}\n")

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
        if any(s in title for s in TARGET_PANT_SIZES) and REQUIRED_FABRIC in title:
            status = "AVAILABLE" if v.get("available") else "OUT OF STOCK"
            print(f"- {title}: {status}")
            p_available = True
    if not p_available: print(f"No {REQUIRED_FABRIC} pants found in your sizes.")

if __name__ == "__main__":
    check_stock()
