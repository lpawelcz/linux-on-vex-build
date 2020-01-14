#!/bin/bash

help () {
	echo "TODO: Write help for this function"
}

OVERWRITE="false"

while getopts ":h:r" opt; do
	case ${opt} in
		h )
			exit 0
			;;
		r )
			OVERWRITE="true"
			;;
		\? )
			echo "Invalid Option: -$OPTARG" 1>&2
			exit 1
			;;
	esac
done
shift $((OPTIND -1))

# arguments

NEW_PATCH_NAME_STR="$1"
NEW_PATCH_DIFF_BASE="$2"

echo $NEW_PATCH_NAME_STR
echo $NEW_PATCH_DIFF_BASE

# find new patch name

PATCH_DIR=${LINUX_ON_VEX_BUILD_ROOT_DIR}/linux-on-litex-vexriscv/buildroot/board/litex_vexriscv/patches/linux
LAST_PATCH_NAME=$(ls ${PATCH_DIR}/ | sort -n | tail -n 1)
LAST_PATCH_NUMBER="${LAST_PATCH_NAME:0:4}"

if [ $OVERWRITE == "false" ]; then
	c=$(expr $LAST_PATCH_NUMBER + 1)
else
	c=$(expr $LAST_PATCH_NUMBER + 0)
fi
echo $c

NEW_PATCH_NUMBER=$(printf '%04d' "$c")
NEW_PATCH_NAME="$NEW_PATCH_NUMBER-$NEW_PATCH_NAME_STR.patch"

# create patch

LINUX_DIR=${LINUX_ON_VEX_BUILD_ROOT_DIR}/linux
(cd $LINUX_DIR && git diff ${NEW_PATCH_DIFF_BASE} > ${PATCH_DIR}/${NEW_PATCH_NAME})
