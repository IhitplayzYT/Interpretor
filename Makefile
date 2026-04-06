BIN_NAME := Interpretor 
PROFILE ?= release
TARGET_DIR := target/$(PROFILE)
BIN := $(TARGET_DIR)/$(BIN_NAME)

PREFIX ?= /usr/local
BINDIR := $(PREFIX)/bin
DEST := $(BINDIR)/$(BIN_NAME)

CARGO := cargo
.DEFAULT_GOAL := help


build:
	@echo "[*] Building ($(PROFILE))..."
	$(CARGO) build $(if $(filter $(PROFILE),release),--release,)

run:
	@echo "[*] Running..."
	$(CARGO) run

install: build
	@echo "[*] Installing to $(DEST)"
	install -Dm755 $(BIN) $(DEST)

reinstall: uninstall install

uninstall:
	@echo "[*] Removing $(DEST)"
	rm -f $(DEST)

clean:
	@echo "[*] Cleaning..."
	$(CARGO) clean

strip: build
	@echo "[*] Stripping binary..."
	strip $(BIN)

info:
	@echo "BIN_NAME = $(BIN_NAME)"
	@echo "PROFILE  = $(PROFILE)"
	@echo "BIN      = $(BIN)"
	@echo "DEST     = $(DEST)"

help:
	@echo ""
	@echo "Targets:"
	@echo "  make build        - build binary (PROFILE=debug/release)"
	@echo "  make run          - run project"
	@echo "  make install      - install to $(DEST)"
	@echo "  make uninstall    - remove installed binary"
	@echo "  make reinstall    - uninstall + install"
	@echo "  make clean        - clean build artifacts"
	@echo "  make strip        - strip binary (reduce size)"
	@echo "  make info         - show resolved variables"
	@echo ""
	@echo "Overrides:"
	@echo "  PROFILE=debug     - debug build"
	@echo "  PREFIX=/usr       - change install location"
	@echo ""

.PHONY: build run install uninstall reinstall clean strip help info