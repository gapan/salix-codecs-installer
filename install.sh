#!/bin/sh

install -d -m 755 $DESTDIR/usr/sbin
install -d -m 755 $DESTDIR/usr/share/applications
install -d -m 755 $DESTDIR/usr/share/salix-codecs-installer
install -m 755 src/salix-codecs-installer $DESTDIR/usr/sbin/
install -m 755 src/salix-codecs-installer-gtk $DESTDIR/usr/sbin/
install -m 644 src/salix-codecs-installer.glade $DESTDIR/usr/share/salix-codecs-installer/
install -m 644 salix-codecs-installer.desktop $DESTDIR/usr/share/applications/
install -m 644 salix-codecs-installer-kde.desktop $DESTDIR/usr/share/applications/

# Install icons
install -d -m 755 $DESTDIR/usr/share/icons/hicolor/scalable/apps/
install -m 644 icons/salix-codecs-installer.svg $DESTDIR/usr/share/icons/hicolor/scalable/apps/

for i in 32 24 22 16; do
	install -d -m 755 \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/apps/ \
	2> /dev/null
	install -m 644 icons/salix-codecs-installer-$i.png \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/apps/salix-codecs-installer.png
done

for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do
	install -d -m 755 $DESTDIR/usr/share/locale/$i/LC_MESSAGES
	install -m 644 po/$i.mo $DESTDIR/usr/share/locale/$i/LC_MESSAGES/salix-codecs-installer.mo
done
