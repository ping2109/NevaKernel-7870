#!/bin/bash

export CONFIG_LOCALVERSION=" - NevaKernel 3.0"
export ARCH=arm64
# export CROSS_COMPILE=/home/ping2109/Downloads/old compiler/bin/aarch64_be-none-linux-gnu-
export CROSS_COMPILE=/home/ping2109/Downloads/compiler/bin/aarch64-none-linux-gnu-
export ANDROID_MAJOR_VERSION=q
export ANDROID_PLATFORM_VERSION=10

make exynos7870-j7xelte_defconfig
make

cp arch/arm64/out/Image neva/Image

