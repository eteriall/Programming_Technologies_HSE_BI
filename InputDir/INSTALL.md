Installing PhotoDemon
=====================

PhotoDemon is a portable application.  **It does not require installation.**  

To use PhotoDemon, simply [download the latest release](https://photodemon.org/download/), extract the contents of the .zip file to a folder of your choosing, then double-click PhotoDemon.exe.

System Requirements
===================

All modern versions of Windows (XP through the latest Windows 11 builds) are actively supported.

PhotoDemon has only one hardware requirement: a minimum display resolution of at least 1024x768 pixels.  

As with any software, a faster processor and plenty of RAM + disk space will provide a better experience, but current PhotoDemon builds run just fine on XP-era processors with 5400 RPM HDDs and < 1 GB of RAM.  (Yes, I still test this configuration!)

Besides `PhotoDemon.exe`, the program also requires access to an `App/PhotoDemon/Plugins` subfolder containing essential 3rd-party libraries.  PhotoDemon will not run if these libraries are missing or broken.

If you encounter problems starting PhotoDemon, please ensure that the `App/PhotoDemon/Plugins` subfolder is intact.  Nearly all startup problems are caused by ancient ZIP software (e.g. WinZip) failing to extract PhotoDemon's folder tree correctly.  If you don't see an `/App` subfolder, or if you see any .dll files in the base PhotoDemon folder, please re-extract PhotoDemon and its dependencies using the built-in Windows ZIP manager.