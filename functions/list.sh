
list_drives() {
    for NAME in $(ls ${DRIVES_DIR}); do
        echo -n ${NAME}
        echo -n " -> "
        echo -n $(readlink -f ${DRIVES_DIR}/${NAME}/mountpoint)
        echo -n " :: "

        MOUNTED="not mounted"
        if mount | grep "/dev/mapper/${NAME}" > /dev/null; then
            MOUNTED="mounted"
        fi
        echo "${MOUNTED}"
    done
}

