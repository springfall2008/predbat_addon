import os
import requests
import sys
import urllib.request
print("Bootstrap Predbat")

# Download the latest Predbat release from Github
if not os.path.exists("/config/apps.yaml"):
    print("Download Predbat")
    url = "https://api.github.com/repos/springfall2008/batpred/releases"
    try:
        r = requests.get(url)
    except Exception:
        print("Error: Unable to load data from Github url: {}".format(url))
        sys.exit(1)

    try:
        pdata = r.json()
    except requests.exceptions.JSONDecodeError:
        print("Error: Unable to decode data from Github url: {}".format(url))
        sys.exit(1)

    tag_name = None
    for release in pdata:
        if not release.get("prerelease", True):
            tag_name = release.get("tag_name", "Unknown")
            break
    
    if tag_name:
        download_url = "https://github.com/springfall2008/batpred/archive/refs/tags/{}.zip".format(tag_name)
        save_path = "/config/predbat_{}.zip".format(tag_name)
        print("Downloading Predbat {}".format(download_url))

        try:
            urllib.request.urlretrieve(download_url, save_path)
            print("Predbat downloaded successfully")
        except Exception as e:
            print("Error: Unable to download Predbat - {}".format(str(e)))
            sys.exit(1)

        print("Unzipping Predbat")
        os.system("unzip {} -d /config".format(save_path))
        print("Predbat unzipped successfully")
    else:
        print("Error: Unable to find a valid Predbat release")
        sys.exit(1)

print("Startup")
os.system("cd /config; python3 hass.py")

print("Shutdown")
