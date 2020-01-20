#!/bin/bash

PATCH_DIR=${LINUX_ON_VEX_BUILD_ROOT_DIR}/linux-on-litex-vexriscv/buildroot/board/litex_vexriscv/patches/linux
LINUX_DIR=${LINUX_ON_VEX_BUILD_ROOT_DIR}/linux

for file in ${PATCH_DIR}/*;
do
	echo "Applying ... $file";
	cd ${LINUX_DIR} && git apply $file
done
