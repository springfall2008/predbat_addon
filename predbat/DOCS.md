#  Predbat Home Assistant Add-on
Predbat Home Assistant Add-on

This add-on can be used with Home Assistant to run Predbat without AppDaemon

![image](https://github.com/springfall2008/predbat_addon/assets/48591903/50580da1-5110-4711-b740-1c14cc103835)

For Predbat documention see: https://springfall2008.github.io/batpred/

If you want to buy me a beer then please use Paypal - [tdlj@tdlj.net](mailto:tdlj@tdlj.net)
![image](https://github.com/springfall2008/batpred/assets/48591903/b3a533ef-0862-4e0b-b272-30e254f58467)

## Installation instructions

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

Do not run this at the same time as the appdaemon-predbat or Predbat within AppDaemon (stop them first and remember to only have one on auto-start)

## Copyright

```text
Copyright (c) Trefor Southwell 2024 - All rights reserved
This software maybe used at no cost for personal use only.
No warranty is given, either expressed or implied.
```
