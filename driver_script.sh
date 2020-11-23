
lsmod | grep ath
sudo rmmod -v ath10k_pci
sudo rmmod -v ath10k_core
sudo rmmod -v ath10k_ath
sudo rmmod -v mac80211
sudo rmmod -v cfg80211
sudo rmmod -v ath
sudo rmmod -v cfg80211

sudo modprobe -v ath10k_pci
sudo wpa_supplicant -c ~/.cat_installer/cat_installer.conf -iwlp4s0

