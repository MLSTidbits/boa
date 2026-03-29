.PHONY: all clean install _build/man _build/doc uninstall

APPLICATION = $(shell pwd | xargs basename)
VERSION = $(shell cat doc/version)

BUILD_DIR = _build
SOURCE_DIR = src
DOC_DIR = doc
MAN_DIR = man

all: _build/man _build/doc

clean:
	@rm -rf $(BUILD_DIR)

install:
	@install -Dm755 $(SOURCE_DIR)/$(APPLICATION) /usr/bin/$(APPLICATION)

# Install the /etc configuration file if it doesn't exist
	@install -Dm644 $(SOURCE_DIR)/example.env /usr/share/$(APPLICATION)/

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

_build/man:
	@mkdir -p $@
	@if ! command -v pandoc >/dev/null 2>&1; then \
		echo 'pandoc could not be found. Please install pandoc to build the manual page.'; \
		exit 1; \
	fi

	@for manpage in $(MAN_DIR)/*.md; do \
		output=$@/$$(basename "$${manpage%.md}"); \
		echo "\e[1;32mMD\e[0m  $$manpage"; \
		pandoc -s -t man -o "$$output" "$$manpage"; \
	done

_build/doc:
	@mkdir -p $@
	@for doc in README.md CONTRIBUTING.md CODE_OF_CONDUCT.md .version doc/copyright; do \
		if [ -f "$$doc" ]; then \
			echo "\e[1;32mDC\e[0m  $$doc"; \
			cp -f "$$doc" $(BUILD_DIR)/$(DOC_DIR)/; \
		fi; \
	done

	@for src in $(SOURCE_DIR)/*; do \
		if [ -f "$$src" ]; then \
			echo "\e[1;32mSR\e[0m  $$src"; \
			cp -f "$$src" $(BUILD_DIR)/; \
		fi; \
	done
