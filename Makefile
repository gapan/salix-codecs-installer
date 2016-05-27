PREFIX ?= /usr
DESTDIR ?= /
BINDIR ?= $(DESTDIR)$(PREFIX)/sbin
LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
ICONSDIR ?= $(DESTDIR)$(PREFIX)/share/icons/hicolor
DESKTOPDIR ?= $(DESTDIR)$(PREFIX)/share/applications
GLADEDIR ?= $(DESTDIR)$(PREFIX)/share/salix-codecs-installer

.PHONY: all
all: mo desktop

.PHONY: mo
mo:
	for i in `ls po/*.po`; do \
		msgfmt $$i -o `echo $$i | sed "s/\.po//"`.mo; \
	done

.PHONY: desktop
desktop:
	intltool-merge po/ -d -u salix-codecs-installer.desktop.in salix-codecs-installer.desktop
	intltool-merge po/ -d -u salix-codecs-installer-kde.desktop.in salix-codecs-installer-kde.desktop

.PHONY: updatepo
updatepo:
	for i in `ls po/*.po`; do \
		msgmerge -UNs $$i po/salix-codecs-installer.pot; \
	done

.PHONY: pot
pot:
	xgettext --from-code=utf-8 \
		-L Glade \
		-o po/salix-codecs-installer.pot \
		src/salix-codecs-installer.ui
	xgettext --from-code=utf-8 \
		-j \
		-L Python \
		-o po/salix-codecs-installer.pot \
		src/salix-codecs-installer-gtk
	xgettext --from-code=utf-8 \
		-j \
		-L shell \
		-o po/salix-codecs-installer.pot \
		src/salix-codecs-installer
	intltool-extract --type="gettext/ini" salix-codecs-installer.desktop.in
	intltool-extract --type="gettext/ini" salix-codecs-installer-kde.desktop.in
	xgettext --from-code=utf-8 -j -L C -kN_ -o po/salix-codecs-installer.pot salix-codecs-installer.desktop.in.h
	xgettext --from-code=utf-8 -j -L C -kN_ -o po/salix-codecs-installer.pot salix-codecs-installer-kde.desktop.in.h
	rm -f salix-codecs-installer.desktop.in.h salix-codecs-installer-kde.desktop.in.h

.PHONY: clean
clean:
	rm -f po/*.mo
	rm -f po/*.po~
	rm -f salix-codecs-installer.desktop salix-codecs-installer-kde.desktop

.PHONY: install-icons
install-icons:
	install -d -m 755 $(ICONSDIR)/scalable/apps/
	install -m 644 icons/salix-codecs-installer.svg $(ICONSDIR)/scalable/apps/
	for i in 32 24 22 16; do \
		install -d -m 755 $(ICONSDIR)/$${i}x$${i}/apps/; \
		install -m 644 icons/salix-codecs-installer-$$i.png \
			$(ICONSDIR)/$${i}x$${i}/apps/salix-codecs-installer.png; \
	done

.PHONY: install-mo
install-mo:
	for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do \
		install -d -m 755 $(LOCALEDIR)/$$i/LC_MESSAGES; \
		install -m 644 po/$$i.mo $(LOCALEDIR)/$$i/LC_MESSAGES/salix-codecs-installer.mo; \
	done

.PHONY: install-desktop
install-desktop:
	install -d m 755 $(DESKTOPDIR)
	install -m 644 salix-codecs-installer.desktop $(DESKTOPDIR)/
	install -m 644 salix-codecs-installer-kde.desktop $(DESKTOPDIR)/

.PHONY: install
install: install-icons install-mo install-desktop
	install -d -m 755 $(BINDIR)
	install -d -m 755 $(GLADEDIR)
	install -m 755 src/salix-codecs-installer $(BINDIR)/
	install -m 755 src/salix-codecs-installer-gtk $(BINDIR)/
	install -m 644 src/salix-codecs-installer.ui $(GLADEDIR)/
	
.PHONY: tx-pull
tx-pull:
	tx pull -a
	@for i in `ls po/*.po`; do \
		msgfmt --statistics $$i 2>&1 | grep "^0 translated" > /dev/null \
			&& rm $$i || true; \
	done
	@rm -f messages.mo

.PHONY: tx-pull-f
tx-pull-f:
	tx pull -a -f
	@for i in `ls po/*.po`; do \
		msgfmt --statistics $$i 2>&1 | grep "^0 translated" > /dev/null \
			&& rm $$i || true; \
	done
	@rm -f messages.mo

.PHONY: stat
stat:
	@for i in `ls po/*.po`; do \
		echo "Statistics for $$i:"; \
		msgfmt --statistics $$i 2>&1; \
		echo; \
	done
	@rm -f messages.mo

