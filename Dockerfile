FROM python:3.7

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Mecab version
ENV MECAB_VERSION mecab-0.996-ko-0.9.2
ENV MECAB_DICT_VERSION mecab-ko-dic-2.1.1-20180720
ENV MECAB_PYTHON_VERSION mecab-python-0.996

COPY requirements.txt /

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        openjdk-8-jdk-headless \
        python-dev \
        python3-dev \
    && pip install --no-cache-dir --disable-pip-version-check -r requirements.txt \
    && rm requirements.txt

# Install Mecab
RUN set -ex \
    && curl -LO https://bitbucket.org/eunjeon/mecab-ko/downloads/${MECAB_VERSION}.tar.gz \
    && tar zxvf ${MECAB_VERSION}.tar.gz \
    && cd ${MECAB_VERSION} \
    && ./configure \
    && make \
    && make check \
    && make install \
    && ldconfig

# Install Mecab Dictionay
RUN set -ex \
    && curl -LO https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/${MECAB_DICT_VERSION}.tar.gz \
    && tar zxvf ${MECAB_DICT_VERSION}.tar.gz \
    && cd ${MECAB_DICT_VERSION} \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && ldconfig

# Install mecab-python
RUN set -ex \
    && git clone https://bitbucket.org/eunjeon/${MECAB_PYTHON_VERSION}.git \
    && cd ${MECAB_PYTHON_VERSION} \
    && python setup.py build \
    && python setup.py install

CMD [ "python" ]
