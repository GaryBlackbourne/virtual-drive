#!/usr/bin/bash

# override these with the drive you want to use
NAME=drive
IMAGE=${HOME}/${NAME}.img
MNTPOINT=${HOME}/mnt

case $1 in
    "attach")
        sudo cryptsetup luksOpen ${IMAGE} ${NAME}
        mkdir -p ${MNTPOINT}
        sudo mount /dev/mapper/${NAME} ${MNTPOINT}
        ;;
    "detach")
        sudo umount ~/${MNTPOINT}
        sudo cryptsetup luksClose ${NAME}
        ;;
    *)
        echo "Bad command! Use [attach/detach]!"
        exit 1
        ;;
esac 

