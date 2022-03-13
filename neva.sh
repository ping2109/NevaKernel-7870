#!/bin/bash

NEVA_NAME="NevaCore 3.0"
NEVA_VARIANT="exynos7870"
DEFCONF=exynos7870-j7xelte_defconfig
KERN_VER=" - NevaCore 3.0 [j7xelte]"

export LOCALVERSION=$KERN_VER
export ARCH=arm64
# export CROSS_COMPILE=/home/ping2109/Downloads/old compiler/bin/aarch64_be-none-linux-gnu-
# export CROSS_COMPILE=/home/ping2109/Downloads/compiler/bin/aarch64-none-linux-gnu-
export ANDROID_MAJOR_VERSION=q
export ANDROID_PLATFORM_VERSION=10

make $DEFCONF
make

cp arch/arm64/boot/Image neva/Image

comp=("A.I.K" "AnyKernel" "Exit")
select comp in "${comp[@]}"
do
	case $comp in
        "A.I.K")
        	echo "Enter img's name asap bruh:"
        	read img_name
		cp -rf neva/universal/* neva/A.I.K
		mv arch/arm64/boot/Image neva/A.I.K/split_img/boot.img-zImage
		mv boot.img-dtb neva/A.I.K/split_img/boot.img-dtb
		neva/A.I.K/repackimg.sh
		# echo -n "SEANDROIDENFORCE" » neva/A.I.K/image-new.img
		mv neva/A.I.K/image-new.img neva/finished/$img_name.img
		# mv neva/A.I.K/image-new.img $CR_OUT/$img_name.img
		du -k "neva/finished/$img_name.img" | cut -f1 >sizkT
		sizkT=$(head -n 1 sizkT)
		rm -rf sizkT
		neva/A.I.K/cleanup.sh
		rm -rf neva/A.I.K/Image
		rm -rf neva/Image
		break
	;;
	"AnyKernel")
		mv arch/arm64/boot/Image neva/AnyKernel/Image
		sed -i "s/kernel.string=.*/kernel.string=$NEVA_NAME/g" neva/AnyKernel/anykernel.sh
		echo "Enter zip's name asap bruh:"
		read zip_name
		cd neva/AnyKernel
		zip -r $zip_name.zip *
		cd ../../
		mv neva/AnyKernel/$zip_name.zip neva/finished/$zip_name.zip
		rm -rf neva/AnyKernel/Image
		rm -rf neva/Image
		break
	;;
        "Exit")
            break
            ;;
        *) echo Invalid option.;;
    esac
done
