#!/usr/bin/bash

NAME=drive

IMAGE=${HOME}/${NAME}.img
DEVICE=drive
MNTPOINT=${HOME}/mnt

case $1 in
    "attach")
        sudo cryptsetup luksOpen ${IMAGE} ${DEVICE}
        mkdir -p ${MNTPOINT}
        sudo mount /dev/mapper/${DEVICE} ${MNTPOINT}
        ;;
    "detach")
        sudo umount ~/${MNTPOINT}
        sudo cryptsetup luksClose ${DEVICE}
        ;;
    *)
        echo "Bad command! Use [attach/detach]!"
        exit 1
        ;;
esac 

