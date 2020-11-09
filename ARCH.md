
Follow this guide https://averagelinuxuser.com/a-step-by-step-arch-linux-installation-guide/

**English keyboad**
```
ø -> ;
Ø -> :
+ -> -
? -> _
- -> /
' -> \
* -> |
æ -> '

```

**1. Wireless Internet**:
You should use iwctl to connect to internet
```
Station help blabla
```

Check with `ping google.com`

**1. Wireless Internet**:

```
localectl list-keymaps # lists of maps
loadkeys no-latin1
localectl set-keymap --no-convert no-latin1
```
**Verify if EFI Bootmode (optional)**
source: https://wiki.archlinux.org/index.php/Installation_guide#Wireless_2
```
ls /sys/firmware/efi/efivars
```

**Time Sync**:

```
timedatectl set-ntp true
```

**2. Partition**:
Root Partition should be 30G not 10G.
Maybe consider to have 1Gb> Boot partition
Probably nice to have 20-50GB not allocated just in case (Swap allocation is easier)

```
mkfs.ext4 /dev/<root>
mkfs.ext4 /dev/<home>
mkfs.fat -F32 /dev/<efi>
```



**3. keymaps (installation?) **:
```
localectl list-keymaps
loadkeys no-latin1
```

**4. For Swap**
source https://wiki.archlinux.org/index.php/Swap
If you get Swap has holes error:
```
fallocate -l 20G /swapfile
dd if=/dev/zero of=/swapfile bs=1M count=512 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' >> /etc/fstab

```

**5. Localhost**
```
/etc/hostname
myhostname
```
```
/etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	myhostname.localdomain	myhostname

```
**6. Keymap (during installation)**
```
/etc/vconsole.conf
KEYMAP=no-latin1
```

I think this is used
```
localectl set-keymap --no-convert keymap
```


**7. Wireless network**
Source: https://www.youtube.com/watch?v=eHdP4sT7-8U&ab_channel=ChrisAtMachine
```
pacman -S wireless_tools networkmanager network-manager-applet
systemctl start NetworkManager
systemctl enable NetworkManager
nmtui
```

*Issues*
Wifi just stopped working.
```
# List wifis
nmtui dev wifi list

# Restart NetworkManager
systemctl restart NetworkManager.service
```




**Keymap: LARBS config**
Norwegian keys

```
~/.local/bin/remaps
setxkbmap -layout no -option nodeadkeys
```



**After Intallation**
- Generate ssh keys
https://github.com/White-Oak/arch-setup-for-dummies/blob/master/setting-up-ssh-agent.md

- Add github credenitals to zsrc
```
# Need both
git config --global user.name "isakhammer"
git config --global user.email "isakhammer@gmail.com"
```
- Bluetooth connection
Follow this tutorial https://www.jeremymorgan.com/tutorials/linux/how-to-bluetooth-arch-linux/
You might want to add a additional step `sudo systemctl restart bluetooth.service'

- Audio
```
sudo  pacman -S pulseaudi pavucontrol
```
Then launch pavucontrol
Source : https://www.youtube.com/watch?v=9piWjL9x4SI



**Problems**
- Security Boot fail

  Go into bios and turn of security boot.

- Time sync issue

Check your time sync. Does it seem off?
```
timedatectl
```
Update time here
```
sudo ntpdate time.apple.com
```

- Alternative

Source: https://www.tecmint.com/set-time-timezone-and-synchronize-time-using-timedatectl-command/

```
timedatectl status
```
sync off?
```
timedatectl set-ntp true
```

- Wifi is off?
Source: https://unix.stackexchange.com/questions/65255/networkmanager-issues-in-arch-linux
```
systemctl stop NetworkManager
systemctl start NetworkManager
```

- Larbs and gitthub
It can be quite hazzle to handle git stuff using LARBS, but this can be handled by using git remote
```
# Check remote connection
git remote -v

# Set upstream set url?
git remote add upstream https://github.com/lukesmithxyz/voidrice.git

# Set origin as your fork
git remote set-url origin git@github.com:isakhammer/voidrice.git

```
Now you can use upstream and origin everytime you push or pull.

- Generate SSH keys
 Follow this  https://www.siteground.com/kb/generate_ssh_key_in_linux/

and then this

https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent


- To give docker permission
```
sudo usermod -aG docker $USER
#logout
sudo systemctl restart docker

```

- Install spotify
```
yay -S spotify
```
But will probably give you a error.
```
:: Importing keys with gpg...
gpg: keyserver receive failed: General error
problem importing keys
```

Run this command with the given keys
```
gpg --keyserver pool.sks-keyservers.net --recv-keys 8FD3D9A8D3800305A9FFF259D1742AD60D811D58
yay -S spotify
```

source :  https://bbs.archlinux.org/viewtopic.php?id=257441
