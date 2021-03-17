
# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all: clean
	mkdir -p $(PWD)/build/Boilerplate.AppDir
	apprepo --destination=$(PWD)/build appdir boilerplate libpng16-16 libqt5printsupport5 libqt5widgets5 libqt5qml5 libqt5network5 \
												libqt5gui5 libqt5core5a libqt5quick5 libqt5xml5 libqt5sql5 libqt5dbus5 libqt5multimedia5 libqt5x11extras5


	wget --output-document=$(PWD)/build/build.deb https://dl.flareget.com/downloads/files/flareget/debs/amd64/flareget_5.0-1_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	# wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/openssl-libs-1.0.2k-19.el7.x86_64.rpm
	# rpm2cpio build.rpm | cpio -idmv

	# wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libicu-50.2-3.el7.x86_64.rpm
	# rpm2cpio build.rpm | cpio -idmv

	# wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/pcre2-utf16-10.23-2.el7.x86_64.rpm
	# rpm2cpio build.rpm | cpio -idmv

	# wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libxcb-1.13-1.el7.x86_64.rpm
	# rpm2cpio build.rpm | cpio -idmv

	cp -r $(PWD)/build/usr/bin/* 		$(PWD)/build/Boilerplate.AppDir/bin
	cp -r $(PWD)/build/usr/lib/* 		$(PWD)/build/Boilerplate.AppDir/lib64
	cp -r $(PWD)/build/usr/share/* 		$(PWD)/build/Boilerplate.AppDir/share

	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'exec $${APPDIR}/bin/flareget $${@}' >> $(PWD)/build/Boilerplate.AppDir/AppRun

	rm -f $(PWD)/build/Boilerplate.AppDir/*.desktop 	| true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.png 		| true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.svg 		| true	

	cp --force $(PWD)/AppDir/*.svg 		$(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.desktop 	$(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.png 		$(PWD)/build/Boilerplate.AppDir 			| true	

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/FlareGet.AppImage
	chmod +x $(PWD)/FlareGet.AppImage

clean:
	rm -rf $(PWD)/build
