SHELL = /usr/bin/env bash

default: lint format

lint:
	for i in $$(find . -type f -name \*.lua); do \
		stylua --check $$i; \
	done

format:
	prettier -w .
	for i in $$(find . -type f -name \*.lua); do \
		stylua $$i; \
	done

.PHONY: lint format
