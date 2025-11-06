
mount_drive() {

    local NAME="$1"
    if [[ -z ${NAME} ]]; then
        echo "no name given"
        exit 1
    fi
    local DRIVE_ROOT=${DRIVES_DIR}/${NAME}

    local IMAGE=${DRIVE_ROOT}/${NAME}.img
    if [[ ! -f ${IMAGE} ]]; then
        echo "image file not found: ${IMAGE}"
        exit 1
    fi

    if [[ ! -L ${DRIVE_ROOT}/mountpoint ]]; then
        echo "no valid mountpoint found!"
        echo "${DRIVE_ROOT}/mountpoint is not a symlink"
        exit 1
    fi
    local MNTPOINT=$(readlink -f ${DRIVE_ROOT}/mountpoint)

    if [[ ! -f ${IMAGE} ]]; then
        echo "image not found: ${NAME}"
        exit 1
    fi

    sudo cryptsetup luksOpen ${IMAGE} ${NAME}
    sudo mount /dev/mapper/${NAME} ${MNTPOINT}
}
