# Scripts collection
* [Path of Exile](#path-of-exile)
* [Wm](#vm)

## Path of Exile
### dependencies
```shell
xdotool, iptables
```
### poe-logout.sh
```shell
needed to run iptables as user:
sudo cp /usr/bin/iptables
sudo chown root iptables
sudo chmod u+s iptables
 ```
### poe-flask.sh
```shell
gets pid from filename.sh, edit script when renaming
```

## Wm
### dependencies
```shell
virsh, virt-viewer
user added to group 'libvirt' 
```

### wm.sh
```shell
Launch vm(if not already running) and viewer, shutdown vm when you exit viewer
```
