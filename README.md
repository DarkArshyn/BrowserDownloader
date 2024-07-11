# Browser Downloader
## General Information
This little software based on PowerShell allows you to download and install some web browsers

Since the software is written in PowerShell, you need to modify the default script execution policy. To do this, run a PowerShell terminal as an administrator, then enter the command `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm:$false`. This policy will allow only the local user to execute scripts on the machine. Once done, you can launch the script without any issues.

> [!TIP]
> You're free to use or modify the script as you want (GPL Licence). Feedback are also appreciated, it can help me to improve the script and fix bugs.

### Supported browsers

At this time, only privacy-friendly browsers appear

For Blink based browsers :

- [Brave](https://brave.com)
- [Ungoogled-Chromium](https://github.com/macchrome/winchrome)

For Gecko based browsers :

- [Firefox](https://www.mozilla.org/firefox/new)
- [Firefox ESR](https://www.mozilla.org/firefox/enterprise)
- [Librewolf](https://librewolf.net)
- [Waterfox](https://www.waterfox.net)
