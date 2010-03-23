#!/bin/sh

for i in `ls po/*.po`;do
	echo "Compiling `echo $i|sed "s|po/||"`"
	msgfmt $i -o `echo $i |sed "s/.po//"`.mo
done

intltool-merge po/ -d -u salix-codecs-installer.desktop.in salix-codecs-installer.desktop
intltool-merge po/ -d -u salix-codecs-installer-kde.desktop.in salix-codecs-installer-kde.desktop
