import os
import requests
import sys
import urllib.request
import shutil
import time
print("Bootstrap Predbat")

root = "/config"

# Download the latest Predbat release from Github
if not os.path.exists(root + "/apps.yaml"):
    url = "https://api.github.com/repos/springfall2008/batpred/releases"
    print("Download Predbat release list from {}".format(url))
    try:
        r = requests.get(url)
    except Exception:
        print("Error: Unable to load data from Github url: {}".format(url))
        print("Sleep 5 minutes before restarting")
        time.sleep(5*60)
        sys.exit(1)

    try:
        pdata = r.json()
    except requests.exceptions.JSONDecodeError:
        print("Error: Unable to decode data from Github url: {}".format(url))
        print("Sleep 5 minutes before restarting")
        time.sleep(5*60)
        sys.exit(1)

    tag_name = None

    if pdata and isinstance(pdata, list):
        for release in pdata:
            if not release.get("prerelease", True):
                tag_name = release.get("tag_name", "Unknown")
                break
    
    if tag_name:
        download_url = "https://github.com/springfall2008/batpred/archive/refs/tags/{}.zip".format(tag_name)
        save_path = root + "/predbat_{}.zip".format(tag_name)
        print("Downloading Predbat {}".format(download_url))

        try:
            urllib.request.urlretrieve(download_url, save_path)
            print("Predbat downloaded successfully")
        except Exception as e:
            print("Error: Unable to download Predbat - {}".format(str(e)))
            sys.exit(1)

        print("Unzipping Predbat")
        unzip_path = root + "/unzip"
        if os.path.exists(unzip_path):
            shutil.rmtree(unzip_path)
        os.makedirs(unzip_path)
        shutil.unpack_archive(save_path, unzip_path)
        unzip_path = unzip_path + "/batpred-" + tag_name.replace("v", "")
        os.system("cp {}/apps/predbat/* {}".format(unzip_path, root))
        os.system("cp {}/apps/predbat/config/* {}".format(unzip_path, root))
    else:
        print("Error: Unable to find a valid Predbat release")
        print("Sleep 5 minutes before restarting")
        time.sleep(5*60)
        sys.exit(1)


print("Startup")
os.system("cd " + root + "; python3 hass.py")

print("Shutdown, sleeping 5 minutes before restarting")
time.sleep(5*60)
