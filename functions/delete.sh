
delete_drive() {
    local NAME="${1}"
    if [[ -z "${NAME}" ]]; then
        echo "no name given"
        exit 1
    fi
    DRIVE_ROOT=${DRIVES_DIR}/${NAME}
    IMAGE=${DRIVE_ROOT}/${NAME}.img
    MNTPOINT=${DRIVE_ROOT}/mountpoint

    if [[ ! -d ${DRIVE_ROOT} ]]; then
        echo "image not found: ${NAME}"
        exit 1
    fi

    rm -f  ${IMAGE}
    rm -f  ${MNTPOINT}
    rm -rf ${DRIVE_ROOT}
}
