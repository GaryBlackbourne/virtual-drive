#!/usr/bin/bash

HELP=\
    "This script must be used like this:
        ./create-drive.sh <name> <size>
        Size can be postfixed with K,M,G for larger sizes.
        "

if [[ -n $1 ]]; then
    NAME=$1
else
    echo ${HELP}
    exit 1
fi

if [[ -n $2 ]]; then
    SIZE=$2
else
    echo ${HELP}
    exit 1
fi

truncate --size=${SIZE} ${NAME}.img          || exit 1 # create a file with given size
cryptsetup luksFormat ${NAME}.img            || exit 1 # encrypt file
sudo cryptsetup luksOpen ${NAME}.img ${NAME} || exit 1 # open and mount as device
mkfs.ext4 /dev/mapper/${NAME}                || exit 1 # create a filesystem on the decrypted device
sudo cryptsetup luksClose ${NAME}            || exit 1 # reencrypt and close the device

exit 0
