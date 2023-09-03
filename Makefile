PROGNM = aurutils-extras
PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
SHRDIR ?= $(PREFIX)/share

.PHONY: install
install:
	@install -Dm755 bin/*     -t $(BINDIR)
	@install -Dm644 LICENSE   -t $(SHRDIR)/licenses/$(PROGNM)
	@install -Dm644 README.md -t $(SHRDIR)/doc/$(PROGNM)
