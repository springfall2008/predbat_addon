#  Predbat Home Assistant Add-on

This add-on can be used with Home Assistant to run Predbat without AppDaemon, or even outside Home Assistant

![image](https://github.com/springfall2008/predbat_addon/assets/48591903/50580da1-5110-4711-b740-1c14cc103835)

For Predbat documention see: https://springfall2008.github.io/batpred/

If you want to buy me a beer then please use Paypal - [tdlj@tdlj.net](mailto:tdlj@tdlj.net)
![image](https://github.com/springfall2008/batpred/assets/48591903/b3a533ef-0862-4e0b-b272-30e254f58467)

## Installation as an add-on in Home Assistant

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fspringfall2008%2Fpredbat_addon)

* Go to settings, add-ons, add-on store, custom repositories
* Add 'https://github.com/springfall2008/predbat_addon' as a new repository

![image](https://github.com/springfall2008/predbat_addon/assets/48591903/7eb18076-888b-4ea5-844b-cfa93157b759)

* Click out of the repository list and refresh the page
* Scroll down and find Predbat, click on it and click 'Install'
* Once installed you can click start, it will now download the latest Predbat and start it running
* Predbat will error out as you have a Template configuration
* Navigate to `/addon_configs/6adb4f0d_predbat` directory in Home Assistant file editor or via a Samba/SSH mount
* Edit/replace the apps.yaml with the correct completed one as per Predbat documentation
* Click restart on the add-on if need be (it might start automatically anyhow)

Please note the predbat.log will be in this addon_configs directory also.

Do not run this at the same time as the appdaemon-predbat or Predbat within AppDaemon (stop them first and remember to only have one on auto-start)

## Installation outside Home Assistant

Predbat can be run on a seperate machine also, you will need a MacOS with Python3, a Linux box (e.g. Debian) or Windows with the Linux subsystem (not yet tested but should work).

* Download the files from rootfs directory (https://github.com/springfall2008/predbat_addon/tree/main/predbat/rootfs) into their own directory on your machine
* Make sure your python environment has the dependancies required installed (https://github.com/springfall2008/predbat_addon/blob/main/predbat/requirements.txt)
* Launch run.csh (you might want to make this startup from boot if you want to keep Predbat running). This will download Predbat for the first time and then fail
* Edit apps.yaml (or copy your previous version from an old installs inside HA) as per the Predbat documentation
* Add `ha_url` / `ha_key` settings into apps.yaml
  * The `ha_url` must be your Home Assistant machine e.g. `http://homeassistant.local:8123`
  * The `ha_key` must be the persistant key you can generate in Home Assistant in your user/security section
* Kill and re-start run.csh and it should run as normal. If you get errors about missing Python packages then install them. 

## Running from within Docker

* Download the contents of 'https://github.com/springfall2008/predbat_addon/tree/main/predbat' onto your machine
* You should see Dockerfile.standalone and rootfs directories
* Download *.py from Predbat repo (https://github.com/springfall2008/batpred/blob/main/apps/predbat/predbat.py) and place the code into rootfs
* Download apps.yaml from Predbat repo (https://github.com/springfall2008/batpred/blob/main/apps/predbat/config/apps.yaml), place it into rootfs and edit it as per the Predbat documentation
* Add `ha_url` / `ha_key` settings into apps.yaml.
  * The `ha_url` must be your Home Assistant machine e.g. http://homeassistant.local:8123
  * The `ha_key` must be the persistant key you can generate in Home Assistant in your user/security section

* Build and run your docker as follows:

```
docker build . -t predbat -f ./Dockerfile.standalone
docker run docker.io/library/predbat
```

Look into the docker under /config/predbat.log for the logfiles

## Pre-build Docker Container

Credit to Nic for building this

These are all prebuilt images that will support both amd64 & arm processors (so Raspberry PI, most NAS & PCs). They can be installed as either a fully enclosed container or a container with mounted external volumes and will populate the /config directory on creation and start-up. To do this I have a run.standalone.sh start-up file which does the file copy on first boot - I do not use the run.csh or run.sh start-up files from the add-on although they are pretty much the same as I wanted to standardise on one start-up file that supported all architectures.

As mentioned the only issue I have is that with the template apps.yaml the logs throw lots of errors until a modified config file is added to the volume.

### Running

Each image will run as a standalone Docker container using the following command:

```
Docker run -d –-name predbat -v /etc/localtime:/etc/localtime nipar44/predbat_addon:tag – See below for tag descriptions
```

The container logs will error until the apps.yaml template is completed, this can either be modified directly in the container or overwritten by copying an updated version to the container /config directory using ‘docker cp’.

### Tags

* Latest & versions – an unmodified build from Docker.standalone in the predbat_addon git
* alpine-latest & slim-latest – modified builds for systems needing a container with a smaller footprint,
* test – probably broken

### Basic Docker Compose

```
services:
    predbat:
      container_name: predbat
      image: nipar44/predbat_addon:latest
      restart: unless-stopped
      volumes:
        - /etc/localtime:/etc/localtime:ro
```

Note: Every time the container is upgraded & recreated the modified apps.yaml will need to copied to the container /config directory

### Alternative Compose (files outside container)

This compose will mount a volume in the container under the /config directory which is accessible from outside the docker container allowing all files to survive during a container rebuild

```
services:
    predbat:
      container_name: predbat
      image: nipar44/predbat_addon:latest
      restart: unless-stopped
      volumes:
        - ./config:/config:rw 
        - /etc/localtime:/etc/localtime:ro
```

## Upgrading from AppDaemon to Predbat add-on

Step-by-step instructions to upgrade from running Predbat within AppDaemon or the AppDaemon-predbat add-on to using this Predbat add-on are included in the [Predbat installation instructions](https://springfall2008.github.io/batpred/install/#upgrading-from-appdaemon-to-predbat-add-on)

## Copyright

```text
Copyright (c) Trefor Southwell 2024 - All rights reserved
This software maybe used at no cost for personal use only.
No warranty is given, either expressed or implied.
```
