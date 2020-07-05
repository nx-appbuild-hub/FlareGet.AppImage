SOURCE="https://dl-flareget.sfo2.digitaloceanspaces.com/downloads/files/flareget/debs/amd64/flareget_5.0-1_amd64.deb"
DESTINATION="build.deb"
OUTPUT="FlareGet.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget --output-document=$(DESTINATION) --continue $(SOURCE)

	dpkg -x $(DESTINATION) build
	rm -rf AppDir/opt

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/qt5-qtbase-gui-5.9.7-2.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/qt5-qtbase-5.9.7-2.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libpng-1.5.13-7.el7_2.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/openssl-libs-1.0.2k-19.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libicu-50.2-3.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/pcre2-utf16-10.23-2.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libxcb-1.13-1.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	mkdir --parents AppDir/application
	mkdir --parents AppDir/application/platforms
	mkdir --parents AppDir/lib
	cp -r build/usr/bin/* AppDir/application
	cp -r ./usr/lib64/* AppDir/lib
	cp -r ./usr/lib64/qt5/plugins/platforms/* AppDir/application/platforms

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

	rm -f *.rpm *.deb *.zip
	rm -rf AppDir/application
	rm -rf AppDir/lib
	rm -rf build
	rm -rf usr
	rm -rf etc
