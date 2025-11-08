# Encrypted Virtual Drive Manager

This project helps with creating and using an encrypted filesystem in a single
file. It works like a virtual pendrive, if attached, it behaves like a storage
drive. After the work is done it can be unmounted, and reencrypted into a
file. Useful for working with sensitive data like buisness code, if you don't
want to encrypt your entire workspace.

## Usage

An encrypted drive can be generated with the following command:

``` shell
virtual-drive create /mnt/mydrive 2G workdrive
```

This will generate a `workdrive.img` file which is `2GB` large. The image is
encrypted with a password and ready to be mounted. Currently only`ext4` 
filesystem is supported. The image is referenced by its name given (without the
extension).

Available drives can be listed with the `list` command:

``` shell
virtual-drive list
```

A drive can be deleted by the `delete` command:

``` shell
virtual-drive delete workdrive
```

The drive can be mounted and unmounted to it's specified mountpoint with the
following commands:

``` shell
virtual-drive mount workdrive
# do some work in the drive
virtual-drive unmount workdrive
```
 
