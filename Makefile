.PHONY: all clean install _pandoc _out

APPLICATION = $(shell pwd | xargs basename)
VERSION = $(shell cat doc/version)

BUILD_DIR = _build
SOURCE_DIR = src
DOC_DIR = doc
MAN_DIR = man

all: _pandoc _out

clean:
	@rm -rf $(BUILD_DIR)

install:
	@install -Dm755 $(SOURCE_DIR)/$(APPLICATION) /usr/bin/$(APPLICATION)

# Install the /etc configuration file if it doesn't exist
	@install -Dm644 $(SOURCE_DIR)/$(APPLICATION).conf \
		/usr/share/$(APPLICATION)/example.conf

	@install -Dm755 $(SOURCE_DIR)/$(APPLICATION) /usr/bin/$(APPLICATION)

	@for manpage in $(BUILD_DIR)/$(MAN_DIR)/*; do \
		section=$$(echo "$$manpage" | sed 's/.*\.\([0-9]\+\)$$/\1/'); \
		dest=/usr/share/man/man$$section/$$(basename $$manpage); \
		gzip -9 "$$dest"; \
	done

	@install -Dm644 $(BUILD_DIR)/$(DOC_DIR)/* /usr/share/doc/$(APPLICATION)/

uninstall:
	@rm -rf /usr/bin/$(APPLICATION) \
		/usr/share/$(APPLICATION)/example.conf \
		/usr/share/man/man*/*/$(APPLICATION).*.gz \
		/usr/share/doc/$(APPLICATION)

_pandoc:
	@mkdir -p $(BUILD_DIR)/$(MAN_DIR)
	@if ! command -v pandoc > /dev/null ; then \
		echo 'pandoc could not be found. Please install pandoc to build the manual page.'; \
		exit 1; \
	fi

	@for manpage in $(MAN_DIR)/*.md; do \
		output=$(BUILD_DIR)/$(MAN_DIR)/$$(basename "$${manpage%.md}"); \
		pandoc -s -t man -o "$$output" "$$manpage"; \
	done

_out:

	@cp -rf $(SOURCE_DIR)/* $(BUILD_DIR)/

	@cp -rf $(DOC_DIR) $(BUILD_DIR)/
	@cp -f README.md CONTRIBUTING.md CODE_OF_CONDUCT.md \
		$(BUILD_DIR)/$(DOC_DIR)/
