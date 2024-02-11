#!/bin/bash

CHECKSUM_FILE=templates.checksum
CURRENT_CHECKSUM=$(find guix/ -type f -path '*/templates/*' | sha256sum)


if [ -f ${CHECKSUM_FILE} ]; then
    if [ "${CURRENT_CHECKSUM}" != "$(cat ${CHECKSUM_FILE})" ]; then
        echo "${CURRENT_CHECKSUM}" > ${CHECKSUM_FILE};
    fi
else
    echo "${CURRENT_CHECKSUM}" > ${CHECKSUM_FILE};
fi

echo "$CURRENT_CHECKSUM"
