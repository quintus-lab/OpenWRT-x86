#!/bin/bash
clear

#Update feed
sed -i '4s/src-git/#src-git/g' ./feeds.conf.default
sed -i '5s/src-git/#src-git/g' ./feeds.conf.default
./scripts/feeds update -a && ./scripts/feeds install -a

#patch jsonc
patch -p1 < ../patches/0000-use_json_object_new_int64.patch
#Add upx-ucl support
patch -p1 < ../patches/0001-tools-add-upx-ucl-support.patch
# replace with ctcgfw source
rm -rf target/linux/x86
svn co https://github.com/project-openwrt/openwrt/branches/master/target/linux/x86/ target/linux/x86/

#dnsmasq aaaa filter
patch -p1 < ../patches/1001-dnsmasq_add_filter_aaaa_option.patch
cp -f ../patches/910-mini-ttl.patch package/network/services/dnsmasq/patches/
cp -f ../patches/911-dnsmasq-filter-aaaa.patch package/network/services/dnsmasq/patches/

#Fullcone & Shortcut-FE patch
patch -p1 < ../patches/1002-add-fullconenat-and-shortcut-fe-support.patch
#fullconenat module
svn co https://github.com/project-openwrt/openwrt/branches/master/package/lean/openwrt-fullconenat package/lean/openwrt-fullconenat
#SFE-sfe module
svn co https://github.com/project-openwrt/openwrt/branches/master/package/lean/shortcut-fe package/lean/shortcut-fe
svn co https://github.com/project-openwrt/openwrt/branches/master/package/lean/fast-classifier package/lean/fast-classifier

#rtl usb wifi driver
svn co https://github.com/project-openwrt/openwrt/branches/master/package/ctcgfw/rtl8821cu package/ctcgfw/rtl8821cu
svn co https://github.com/project-openwrt/openwrt/branches/master/package/ctcgfw/rtl8812au-ac package/ctcgfw/rtl8812au-ac

#update curl
rm -rf ./package/network/utils/curl
svn co https://github.com/openwrt/openwrt/branches/openwrt-19.07/package/network/utils/curl package/network/utils/curl
#Change Cryptodev-linux
rm -rf ./package/kernel/cryptodev-linux
svn co https://github.com/project-openwrt/openwrt/trunk/package/kernel/cryptodev-linux package/kernel/cryptodev-linux

#Max connection limite
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

exit 0
