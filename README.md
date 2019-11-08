# Stephan's dotfiles

## First thing

### Windows 10 autoinstall Programs

After a clean Win10 install, you can run `./install.ps1` with elevated Powershell rights.

This installs common things on your pc.

### Common

Build for WSL ... e.g. [WSL Installation](https://twasa.ml/post/wsl/)

Open Powershell as Admin

`Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`

`curl.exe -L -o ubuntu-1804.appx https://aka.ms/wsl-ubuntu-1804`

## What is used

* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [powerlevel9k](https://github.com/Powerlevel9k/powerlevel9k)
* [Mackup](https://github.com/lra/mackup)

Script installs ZSH, Composer, Node, NPM, YARN, PHP7.3, Python2 & PIP

## Installation

You can install them by cloning the repository as `.dotfiles` in your home directory and running the bootstrap script.

```batch
https://gitlab.com/sjess/dotfiles.git .dotfiles
cd .dotfiles
./start
```

## IMPORTANT

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

### CHMOD

Sometimes you have to set the rights on `./dotfiles/bootstrap`. To do so just type:

```batch
cd ~/.dotfiles
chmod 0755 bootstrap
```

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

## Hyper

### Settings

```json
// font family with optional fallbacks
fontFamily: 'FiraCode Nerd Font Retina, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

...

shell: "C:\\Windows\\System32\\cmd.exe",
// for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
// by default `['--login']` will be used
shellArgs: ["--login", "-i", "/c wsl"],
```
