#!/bin/sh

intltool-extract --type="gettext/ini" salix-codecs-installer.desktop.in
intltool-extract --type="gettext/ini" salix-codecs-installer-kde.desktop.in
xgettext --from-code=utf-8 -L shell -o po/salix-codecs-installer.pot salix-codecs-installer
xgettext --from-code=utf-8 -j -L C -kN_ -o po/salix-codecs-installer.pot salix-codecs-installer.desktop.in.h
xgettext --from-code=utf-8 -j -L C -kN_ -o po/salix-codecs-installer.pot salix-codecs-installer-kde.desktop.in.h

rm salix-codecs-installer.desktop.in.h salix-codecs-installer-kde.desktop.in.h

cd po
for i in `ls *.po`; do
	msgmerge -U $i salix-codecs-installer.pot
done
rm -f ./*~


