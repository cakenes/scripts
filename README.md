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

## Wm
### dependencies
```shell
virsh, virt-viewer, qemu
user added to group 'libvirt' 
```

### wm.sh
```shell
Launch vm (if not already running) and connect viewer
Shutdown vm when you exit viewer
```
