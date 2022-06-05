FROM python:3.10-slim-bullseye

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PATH /home/app/.local/bin:$PATH

RUN DEBIAN_FRONTEND=noninteractive &&  \
    apt-get update &&  \
    apt-get install -y --no-install-recommends \
    wait-for-it && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m app
USER app

WORKDIR /src

COPY pyproject.toml poetry.lock ./
RUN pip install --user --upgrade pip poetry && \
    poetry config virtualenvs.create false &&  \
    poetry install

COPY ./src /src