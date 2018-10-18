FROM python:3.6

WORKDIR /test/python

# Copy over test files.
COPY resources /test/resources/
COPY python/rush /test/python/
COPY python/testing_utils.py /test/python

COPY dist/datadog_to_terraform-1.0.0-py3-none-any.whl /test/dist/

RUN pip install /test/dist/datadog_to_terraform-1.0.0-py3-none-any.whl
RUN pip install pytest

ENTRYPOINT ["python", "-m", "pytest"]