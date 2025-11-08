#!/usr/bin/bash

set -e
create_drive() {

    local MNTPOINT="${1}"
    if [[ -z ${MNTPOINT} ]]; then
        echo "no mount point given"
        exit 1
    fi
    if [[ ! -d ${MNTPOINT} ]]; then
        echo "mount point '${MNTPOINT}' is not a directory"
        exit 1
    fi

    local SIZE="$2"
    if [[ -z ${SIZE} ]]; then
        echo "no size given"
        exit 1
    fi

    local NAME="$3"
    if [[ -z ${NAME} ]]; then
        echo "no name given"
        exit 1
    fi
    local DRIVE_ROOT=${DRIVES_DIR}/${NAME}

    local IMAGE=${DRIVE_ROOT}/${NAME}.img
    if [[ -f ${IMAGE} ]]; then
        echo "an image already exists by the name: ${NAME}"
        exit 1
    fi

    if ! echo ${SIZE} | grep -qE "^[1-9][0-9]*[KMG]?$"; then
        echo "${SIZE} is not a valid size format"
        exit 1
    fi

    echo "Creating new virtual drive with the following parameters:"
    echo "Name:        ${NAME}"
    echo "Size:        ${SIZE}"
    echo "Mount point: $(realpath ${MNTPOINT})"

    # create drive root directory
    mkdir -p ${DRIVE_ROOT}

    # create a file with given size
    echo -n "allocating file for image..."
    fallocate -l ${SIZE} ${IMAGE}
    echo "done"

    # encrypt file
    echo "initializing LUKS partition..."
    cryptsetup luksFormat --batch-mode ${IMAGE}
    echo "done"

    # open and mount as device
    sudo cryptsetup luksOpen ${IMAGE} ${NAME}

    echo "generating filesystem..."
    # create a filesystem on the decrypted device
    sudo mkfs.ext4 /dev/mapper/${NAME}
    echo "done"

    # reencrypt and close the device
    echo "closing LUKS partition..."
    sudo cryptsetup luksClose ${NAME}
    echo "done"

    # create link to mountpoint
    echo -n "generating mount point link..."
    ln -s $(realpath ${MNTPOINT}) ${DRIVES_DIR}/${NAME}/mountpoint
    echo "done"

    exit 0
}
