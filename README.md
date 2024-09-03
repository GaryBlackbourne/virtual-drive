# Encrypted Virtual Drive Generator

This small project helps with creating and using an encrypted filesystem in a 
single file. It works like a virtual pendrive, if attached, it behaves like a
storage drive. After the work is done it can be unmounted, and reencrypted into
a file. Useful for working with sensitive or buisness code, if you don't want to
encrypt your entire workspace.

## How to use?

### Generate an image
Lets generate a drive. The script accepts two arguments, a name, and a size. 
For example:

``` shell
./create-drive.sh mydrive 20G
```
This will generate a `mydrive.img` file which is 20GB large. During generation 
the encryption is also done, and an `ext4` filesystem is also generated. 

### Mount or unmount the image
 
Set the mount point (`MNTPOINT`), name (`NAME`) and the image (`IMAGE`) in the `drive.sh` variables, then use:

``` shell
./drive.sh attach
# or
./drive.sh detach
```
 
This will mount or unmount the drive to a given mount point.
