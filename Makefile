SOURCE="https://dl-flareget.sfo2.digitaloceanspaces.com/downloads/files/flareget/debs/amd64/flareget_5.0-1_amd64.deb"
DESTINATION="build.deb"
OUTPUT="FlareGet.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget --output-document=$(DESTINATION) --continue $(SOURCE)
	
	dpkg -x $(DESTINATION) build
	rm -rf AppDir/opt
	
	mkdir --parents AppDir/opt/application
	cp -r build/usr/bin/* AppDir/opt/application

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf AppDir/opt
	rm -rf build
