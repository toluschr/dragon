PREFIX = $(HOME)/.local
MANPREFIX = $(PREFIX)/share/man
NAME = dragon

GTK_CFLAGS = `pkg-config --cflags gtk+-3.0`
GTK_LDLIBS = `pkg-config --libs gtk+-3.0`

CFLAGS += $(GTK_CFLAGS)
CFLAGS += -Wall -Wextra -Werror -pedantic --std=c99

LDFLAGS += $(GTK_LDLIBS)

.PHONY: all
all: $(NAME)

$(NAME): dragon.c Makefile
	$(CC) $(CFLAGS) $(LDFLAGS) $(DEFINES) dragon.c -o $(NAME)

.PHONY: install
install: $(NAME)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f $(NAME) $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/$(NAME)
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed -e "s/dragon/$(NAME)/g" dragon.1 > $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/$(NAME) $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1

.PHONY: clean
clean:
	rm -f $(NAME)
