![GitHub repo size](https://img.shields.io/github/repo-size/sjess/st4rd0tf1les?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/sjess/st4rd0tf1les?style=for-the-badge)

#### st4rd0tf1les

# Windows 10

After a clean Win10 install, you can run `./install.ps1` with elevated Powershell rights.

This installs common things on your pc, but you need to give scripts the rights to do so

```
Set-ExecutionPolicy Unrestricted -Force -Scope Currentuser
Set-ExecutionPolicy Unrestricted -Force -Scope Localmachine
Set-ExecutionPolicy Unrestricted -Force -Scope Process
```

# WSL

Build for WSL ... e.g. [WSL Installation](https://twasa.ml/post/wsl/)

or WSL 2 [WSL 2 Installation](https://docs.microsoft.com/de-de/windows/wsl/wsl2-install)

Open Powershell as Admin

`Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`

`curl.exe -L -o ubuntu-1804.appx https://aka.ms/wsl-ubuntu-1804`

`Add-AppxPackage .\ubuntu-1804.appx`

#### Switching to WSL 2

> WSL 2 is only available in Windows 10 builds 18917 or higher

* To make sure you are using build 18917 or higher please join the [Windows Insider Program](https://insider.windows.com/en-us/) and select the 'Fast' ring or the 'Slow' ring.
* You can check your Windows version by opening Command Prompt and running the `ver` command.
* Enable the 'Virtual Machine Platform' optional component
* Set a distro to be backed by WSL 2 using the command line
* Verify what versions of WSL your distros are using

To set a distro please run:

`wsl --set-version <Distro> 2`

Additionally, if you want to make WSL 2 your default architecture you can do so with this command:

`wsl --set-default-version 2`

This will make any new distro that you install be initialized as a WSL 2 distro.

To verify what versions of WSL each distro is using use the following command (only available in Windows Build 18917 or higher):

`wsl --list --verbose` or `wsl -l -v`

The distro that you've chosen above should now display a '2' under the 'version' column. Now that you're finished feel free to start using your WSL 2 distro!

## What is used

* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k)
* [Mackup](https://github.com/lra/mackup)

Script installs ZSH, Composer, Node, NPM, YARN, PHP7.3, Python2 & PIP

## Installation

You can install them by cloning the repository as `.dotfiles` in your home directory and running the bootstrap script. Choose between WSL or WSL 2.

```batch
git clone https://github.com/sjess/st4rd0tf1les.git .dotfiles
cd .dotfiles
./start
```

## Misc

### SUDO

For ease of use, make sure your user is in group sudo

```batch
sudo usermod -a -G sudo userName
```

and add following line to `/etc/sudoers`

```batch
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL
```

**Now you can sudo without password.**


### MACKUP

#### Usage

EDIT config under `~/.mackup.cfg`. For own backups make a file `~/.mackup/my-files.cfg`

Example:

```editor-config
[application]
name = My personal synced files and dirs

[configuration_files]
.vscode-server/data
.vscode-server/extensions
.software
.gitconfig
.mackup
```

`mackup backup`

Backup your application settings.

`mackup restore`

Restore your application settings on a newly installed workstation.

`mackup uninstall`

Copy back any synced config file to its original place.

`mackup list`

Display the list of applications supported by Mackup.

`mackup -h`

Get some help, obviously...

## Fluent Terminal

I personally use the [Fluent Terminal](https://github.com/felixse/FluentTerminal).

Download the zip here e.g.: [FluentTerminal.Package_0.6.1.0_Test.zip](https://github.com/felixse/FluentTerminal/releases)

* Unzip, Right-click on Install.ps1, and choose "Run with Powershell".
* The installer script will walk you through the rest of the process.

## Microsoft Terminal

Also a good choice: [Windows Terminal](https://github.com/microsoft/terminal/releases)

To use WSL with WT put the following into the profile settings (watch the DISTRO and GUID)

```json
{
    "acrylicOpacity": 0.7,
    "closeOnExit": true,
    "colorScheme": "Campbell",
    "commandline": "wsl.exe -d <DISTRO>",
    "cursorColor": "#FFFFFF",
    "cursorShape": "bar",
    "fontFace": "FiraCode Nerd Font Retina",
    "fontSize": 14,
    "guid": "<YOUR GUID>",
    "historySize": 9001,
    "icon": "ms-appx:///ProfileIcons/{9acb9455-ca41-5af7-950f-6bca1bc9722f}.png",
    "name": "Ubuntu",
    "padding": "0, 10, 0, 10",
    "snapOnInput": true,
    "useAcrylic": true,
    "startingDirectory" : "//wsl$/Ubuntu-18.04/home/sjess"
}
```

## Hyper

### Settings for WSL 1

Crashes on closing Hyper ... sux

```json
// font family with optional fallbacks
fontFamily: 'FiraCode Nerd Font Retina, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

...

shell: "C:\\Windows\\System32\\cmd.exe",
// for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
// by default `['--login']` will be used
shellArgs: ["--login", "-i", "/c wsl"],
```

## Move WSL to another Drive

You can move the distribution to another drive using [lxRunOffline](https://github.com/DDoSolitary/LxRunOffline). Use an elevated Powershell for the following tasks.

Set permissions to the target folder. First, I think you must set some permissions to the folder where the distribution will be moved. But first create the destination folder.

```bash
C:\> whoami
test\**THENAME**

C:\> icacls D:\wsl /grant "**THENAME**:(OI)(CI)(F)"
```

Move the distribution. Using lxrunoffline move.

```bash
C:\wsl> lxrunoffline move -n Ubuntu-18.04 -d d:\wsl\installed\Ubuntu-18.04
```
You may check the installation folder using
```bash
C:\wsl> lxrunoffline get-dir -n Ubuntu-18.04
d:\wsl\installed\Ubuntu-18.04
```

Run the distribution. 

[StackOverflow](https://stackoverflow.com/questions/38779801/move-wsl-bash-on-windows-root-filesystem-to-another-hard-drive)
