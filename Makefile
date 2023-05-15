all: format

format:
	prettier -w .
	for i in $$(find . -type f -name \*.lua); do \
		stylua $$i;                                \
	done
