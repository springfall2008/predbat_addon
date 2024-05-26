#  Predbat Home Assistant Add-on
Predbat Home Assistant Add-on

This add-on can be used with Home Assistant to run Predbat without AppDaemon

* Go to settings, add-ons, add-on store, custom repositories
* add 'https://github.com/springfall2008/predbat_addon' as a new reposityr

![image](https://github.com/springfall2008/predbat_addon/assets/48591903/7eb18076-888b-4ea5-844b-cfa93157b759)

* Click out of the repository list and refresh the page
* Scroll down and find Predbat, click on it and click 'Install'
* Once installed you can click start, it will now download the latest Predbat and start it running
* Predbat will error out as you have a Template configuration
* Navigate to '/addon_configs/6adb4f0d_predbat' directory in Home Assistant file editor or via a Samba/SSH mount
* Edit/replace the apps.yaml with the correct completed one as per Predbat documentation
* Click restart on the add-on if need be (it might start automatically anyhow)

Please note the predbat.log will be in this addon_configs directory also.

Do not run this at the same time as the appdaemon-predbat or Predbat within AppDaemon
