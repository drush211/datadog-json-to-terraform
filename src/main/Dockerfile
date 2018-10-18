FROM python:3.6

WORKDIR /python

COPY python/setup.py /python
COPY python /python/
COPY scripts /scripts/
CMD ["python", "setup.py", "bdist_wheel"]