FROM python:3.13.7-slim
RUN apt-get update && apt-get upgrade -y --no-install-recommends && apt-get clean

COPY requirements.txt .

RUN pip install --quiet -r requirements.txt

# run application process with non-root user
RUN groupadd -r patroni_exporter \
	&& useradd -r -m -g patroni_exporter patroni_exporter

USER patroni_exporter

WORKDIR "/home/patroni_exporter"

COPY patroni_exporter.py .

ENTRYPOINT [ "python", "patroni_exporter.py" ]
