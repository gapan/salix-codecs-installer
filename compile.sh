#!/bin/sh

cd po

for i in `ls *.po|sed "s/\.po//"`; do
	echo "Compiling $i..."
	msgfmt $i.po -o $i.mo
done

cd ..

intltool-merge po/ -d -u salix-codecs-installer.desktop.in salix-codecs-installer.desktop
intltool-merge po/ -d -u salix-codecs-installer-kde.desktop.in salix-codecs-installer-kde.desktop

