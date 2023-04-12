FROM python:3.10.10-buster

RUN apt-get update && apt-get install -y \
    cmake \
    libmecab2 \
    libmecab-dev \
    mecab \
    mecab-ipadic \
    mecab-ipadic-utf8 \
    mecab-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && cd mecab-ipadic-neologd \
    && mkdir -p `mecab-config --dicdir`"/mecab-ipadic-neologd" \
    && ./bin/install-mecab-ipadic-neologd -n -y -a \
    && cd .. \
    && rm -rf ./mecab-ipadic-neologd

RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python - && \
    ln -s /etc/poetry/bin/poetry /usr/local/bin/poetry && \
    poetry config virtualenvs.create false

WORKDIR /usr/src
