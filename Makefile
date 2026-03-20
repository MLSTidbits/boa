.PHONY: all clean install _pandoc _out

APPLICATION = $(shell pwd | xargs basename)
VERSION = $(shell cat doc/version)

BUILD_DIR = _build
SOURCE_DIR = src
DOC_DIR = doc
MAN_DIR = man

MAN_PAGE = $(APPLICATION).conf.5.md
MAN_OUTPUT = $(APPLICATION).conf.5

all: _pandoc _out

clean:
	rm -rf $(BUILD_DIR)

install:
	@install -Dm755 $(SOURCE_DIR)/$(APPLICATION) /usr/bin/$(APPLICATION)

	@install -Dm644 $(BUILD_DIR)/$(MAN_DIR)/$(MAN_OUTPUT) /usr/share/man/man5/$(MAN_OUTPUT)
	@gzip -9 /usr/share/man/man5/$(MAN_OUTPUT)

	@install -Dm644 $(DOC_DIR)/version $(DOC_DIR)/copyright README.md CONTRIBUTING.md CODE_OF_CONDUCT.md \
		/usr/share/doc/$(APPLICATION)/

	@install -Dm644 $(SOURCE_DIR)/example.env /usr/share/$(APPLICATION)/example.env

uninstall:
	@rm -rf /usr/bin/$(APPLICATION) \
		/usr/share/man/man5/$(MAN_OUTPUT).gz \
		/usr/share/doc/$(APPLICATION) \
		/usr/share/$(APPLICATION)

_pandoc:
	@mkdir -p $(BUILD_DIR)/$(MAN_DIR)

	@if ! command -v pandoc >/dev/null ; then \
		echo 'pandoc could not be found. Please install pandoc to build the manual page.'; \
		exit 1; \
	fi

	@pandoc -s -t man -o $(BUILD_DIR)/$(MAN_DIR)/$(MAN_OUTPUT) $(MAN_DIR)/$(MAN_PAGE)

_out:
	@mkdir -p $(BUILD_DIR)/doc

	@cp -f $(SOURCE_DIR)/$(APPLICATION) $(BUILD_DIR)/

	@cp -f $(DOC_DIR)/version $(DOC_DIR)/copyright README.md CONTRIBUTING.md CODE_OF_CONDUCT.md \
		$(BUILD_DIR)/$(DOC_DIR)/

	@cp -f $(SOURCE_DIR)/example.env $(BUILD_DIR)/
