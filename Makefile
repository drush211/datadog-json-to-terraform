all: clean lint unit-test image

DATADOG_TO_TERRAFORM_PACKAGE_IMAGE_NAME := datadog-to-terraform-package
DATADOG_TO_TERRAFORM_TEST_IMAGE_NAME := datadog-to-terraform-test
DATADOG_TO_TERRAFORM_IMAGE_NAME := datadog-to-terraform

ifneq ($(DEBUG),)
  INTERACTIVE=--interactive
  PDB=--pdb
  VERBOSE=--verbose
else
  INTERACTIVE=--env "INTERACTIVE=None"
  PDB=
  VERBOSE=
endif

package:
	@docker build -t ${DATADOG_TO_TERRAFORM_PACKAGE_IMAGE_NAME} src/main
	@docker run \
		--rm \
		-v `pwd`/dist:/python/dist \
		${DATADOG_TO_TERRAFORM_PACKAGE_IMAGE_NAME}
	@touch package

image: package
	@docker build -t ${DATADOG_TO_TERRAFORM_IMAGE_NAME} .
	@touch image

# Linting

lint: lint-markdown lint-python

lint-markdown:
	@echo Linting markdown files...
	@docker run --rm -v `pwd`:/workspace wpengine/mdl /workspace

lint-python:
	@echo Linting Python files...
	@docker build -t docss-tofu/pylint -f docker/Dockerfile.pylint .
	@docker run --rm \
		docss-tofu/pylint \
			pylint --rcfile /workspace/.pylintrc /workspace

# Tests

test-docker: package
	@mkdir -p src/test/dist
	@cp dist/*.whl src/test/dist
	@docker build -t $(DATADOG_TO_TERRAFORM_TEST_IMAGE_NAME) src/test

unit-test: test-docker
	@docker run \
		--rm \
		$(INTERACTIVE) \
		${DATADOG_TO_TERRAFORM_TEST_IMAGE_NAME} \
			--durations=10 \
			-x \
			-s \
			-m unit \
			$(PDB) \
			/test/python

# Uses

monitor-to-tf: image
	@docker run \
		--rm \
		${DATADOG_TO_TERRAFORM_IMAGE_NAME} monitor "`cat ${JSON_FILE}`" > ${OUTPUT_FILE}

# Clean Up

clean:
	@rm -f package
	@rm -f image
	@rm -rf dist