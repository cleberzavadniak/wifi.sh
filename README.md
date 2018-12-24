# wifi.sh

A very very minimalistic script to connect your Linux box to a WPA2 access
point.

**You must run this app as root!**

## Dependencies:

* `iw`
* `dhcpcd`
* probably, `firmware-linux`

### Install dependencies on debian-based distros

```bash
$ sudo apt-get install iw dhcpcd
$ sudo apt-get install firmware-linux  # If your wireless card needs it.
```

## Instalation

```bash
$ cd ~/code/third-party  # Or wherever you use to clone third parties repositories.
$ git clone git@github.com:cleberzavadniak/wifi.sh.git
$ cd ~/bin; ln -s ~/code/third-party/wifi.sh/wifi.sh .
```

Make sure your "$HOME/bin" is present in your PATH.

Or create a link directly into `/usr/local/sbin`. You decide.

## Usage

```bash
$ ./wifi.sh -h  # Help!
$ ./wifi.sh wlan0 list | less  # List Access Points. Search for "SSID:"
$ ./wifi.sh wlan0 connect <ap-ssid>  # Connect into an WPA/WPA2 AP
```


## Troubleshooting

### "It is not working!"

1- This app only works with WPA/WPA2 access points.

2- You must have root privileges.

3- Your system can't have NetworkManager service running (`service
network-manager stop` or whatever command your distro uses).

4- Read the source code (`cat wifi.sh`), understand what it does, research
a little about wireless connections and solve your problem yourself.

5- If nothing else works, install NetworkManager or wicd. Both kind of
sucks, but they use to work well enough for most cases.
