FROM python:3.14.1-slim

COPY requirements.txt .

RUN pip install --quiet -r requirements.txt

# run application process with non-root user
RUN groupadd -r patroni_exporter \
	&& useradd -r -m -g patroni_exporter patroni_exporter

USER patroni_exporter

WORKDIR "/home/patroni_exporter"

COPY patroni_exporter.py .

ENTRYPOINT [ "python", "patroni_exporter.py" ]
