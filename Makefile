EMACS ?= emacs
MATLIVRE_PROGRAM ?= matlivre

.PHONY: test compile

test:
	MATLIVRE_PROGRAM="$(MATLIVRE_PROGRAM)" $(EMACS) -Q --batch -L lisp -l tests/matlivre-emacs.el -f ert-run-tests-batch-and-exit

compile:
	$(EMACS) -Q --batch -L lisp --eval '(setq byte-compile-error-on-warn t)' -f batch-byte-compile lisp/matlivre.el
