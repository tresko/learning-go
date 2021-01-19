include .env
include .env.test
export

define smart_brew
    HOMEBREW_NO_AUTO_UPDATE=1 brew `brew ls --versions "$(1)" | wc -l | xargs expr | sed 's/0/install/' | sed 's/1/upgrade/'` "$(1)"
endef

init:
	$(call smart_brew,golang)
	$(call smart_brew,golangci/tap/golangci-lint)
	$(call smart_brew,pre-commit)

.PHONY: lint
lint:
	./scripts/lint.sh pkg go-kit
	./scripts/lint.sh services users

.PHONY: build
build:
	./scripts/build.sh services users

.PHONY: test
test:
	./scripts/test.sh pkg go-kit
	./scripts/test.sh services users

.PHONY: go-get
go-get:
	./scripts/go-get.sh pkg go-kit
	./scripts/go-get.sh services users

.PHONY: pre-commit-install
pre-commit-install:
	pre-commit install

.PHONY: pre-commit-run
pre-commit-run:
	pre-commit run --all-files
