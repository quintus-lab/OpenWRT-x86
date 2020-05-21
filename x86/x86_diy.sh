#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
#修改版本号
sed -i 's/OpenWrt/Bin AutoBuild $(date "+%Y.%m.%d") @ OpenWrt/g' package/lean/default-settings/files/zzz-default-settings
#sed -i 's/R20.4.8/& Mod by Quintus/g' package/lean/default-settings/files/zzz-default-settings
echo -e '\nQuintus Mod\n'  >> package/base-files/files/etc/banner
#更新软件包
#rm -rf package/lean/luci-app-dockerman
rm -rf package/lean/luci-theme-opentomcat
#rm -rf package/lean/luci-app-frps
rm -rf package/lean/luci-app-frpc
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/lean/luci-theme-opentomcat
git clone https://github.com/kuoruan/luci-app-frpc.git package/lean/luci-app-frpc
#git clone https://github.com/lwz322/luci-app-frps.git package/lean/luci-app-frps
#git clone https://github.com/lisaac/luci-app-dockerman.git package/lean/luci-app-dockerman
#增加应用过滤
#cd package
#git clone https://github.com/destan19/OpenAppFilter.git
#cd ..
#set default theme
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase="/luci-static/opentomcat"' package/lean/default-settings/files/zzz-default-settings
#set netdata privilege
#sed -i '/exit/i\chown -R root:root /usr/share/netdata/web' package/lean/default-settings/files/zzz-default-settings
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
#sed -i '/8.8.8.8/d' package/base-files/files/root/setup.sh
