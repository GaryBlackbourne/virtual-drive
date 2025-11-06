
unmount_drive() {

    local NAME="$1"
    if [[ -z ${NAME} ]]; then
        echo "no name given"
        exit 1
    fi
    local DRIVE_ROOT=${DRIVES_DIR}/${NAME}

    local IMAGE=${DRIVE_ROOT}/${NAME}.img
    if [[ ! -f ${IMAGE} ]]; then
        echo "no image exists with the name: ${NAME}"
        exit 1
    fi
    local MNTPOINT=$(readlink -f ${DRIVE_ROOT}/mountpoint)

    if ! mount | grep -q ${MNTPOINT}; then
        echo "nothing is mounted at ${MNTPOINT} but it is the mountpoint for the image."
        exit 1
    fi

    if ! mount | grep -q /dev/mapper/${NAME}; then
        echo "${NAME} is not mounted"
        exit 1
    fi

    sudo umount ${MNTPOINT}
    sudo cryptsetup luksClose ${NAME}
}
