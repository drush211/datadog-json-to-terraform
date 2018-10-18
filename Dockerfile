FROM python:3.6

WORKDIR /python

COPY dist/datadog_to_terraform-1.0.0-py3-none-any.whl /python
RUN pip3 install datadog_to_terraform-1.0.0-py3-none-any.whl

ENTRYPOINT ["convert_datadog_json_to_terraform"]