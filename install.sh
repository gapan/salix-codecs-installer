#!/bin/sh

install -d -m 755 $DESTDIR/usr/sbin
install -d -m 755 $DESTDIR/usr/libexec
install -d -m 755 $DESTDIR/usr/share/applications
install -d -m 755 $DESTDIR/usr/share/icons/hicolor/48x48/apps
install -d -m 755 $DESTDIR/usr/share/icons/hicolor/scalable/apps
install -d -m 755 $DESTDIR/usr/share/salix-codecs-installer

install -m 755 salix-codecs-installer-wrapper $DESTDIR/usr/sbin/salix-codecs-installer
install -m 755 salix-codecs-installer $DESTDIR/usr/libexec/
install -m 644 salix-codecs-installer.desktop \
$DESTDIR/usr/share/applications/
install -m 644 salix-codecs-installer-kde.desktop \
$DESTDIR/usr/share/applications/
install -m 644 icons/salix-codecs-installer-48.png \
$DESTDIR/usr/share/icons/hicolor/48x48/apps/salix-codecs-installer.png
install -m 644 icons/salix-codecs-installer.svg \
$DESTDIR/usr/share/icons/hicolor/scalable/apps/
install -m 644 pkglist $DESTDIR/usr/share/salix-codecs-installer/

for i in `ls locale/*.mo|sed "s|locale/\(.*\).mo|\1|"`; do
	install -d -m 755 $DESTDIR/usr/share/locale/${i}/LC_MESSAGES
	install -m 644 locale/${i}.mo \
	$DESTDIR/usr/share/locale/${i}/LC_MESSAGES/salix-codecs-installer.mo
done

