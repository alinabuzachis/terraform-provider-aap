.PHONY: build test lint

default: build

build:
	@echo "==> Building package..."
	go build ./...

lint:
	@echo "==> Checking source code against linters..."
	golangci-lint run -v ./...

test:
	@echo "==> Running unit tests..."
	go test -v ./...

testacc:
	@echo "==> Running acceptance tests..."
	TF_ACC=1 AAP_HOST="https://localhost:8043" AAP_INSECURE_SKIP_VERIFY=true go test -v ./...

gofmt:
	@echo "==> Format code using gofmt..."
	gofmt -s -w internal/provider

generatedocs:
	@echo "==> Formatting examples and generating docs..."
	terraform fmt -recursive ./examples/
	go run github.com/hashicorp/terraform-plugin-docs/cmd/tfplugindocs generate --provider-name terraform-provider-aap --rendered-provider-name "Terraform Provider for Ansible Automation Platform (AAP)" --rendered-website-dir ./docs
