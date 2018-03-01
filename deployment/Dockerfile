FROM quay.io/azavea/terraform:0.10.8

COPY requirements.txt .

RUN apk update \
    && apk add --virtual .build-deps build-base \
    && apk add \
      libffi-dev \
      python-dev \
      openssl-dev \
    && pip install --upgrade pip \
    && pip install -r requirements.txt \
    && apk del --purge .build-deps

WORKDIR /usr/local/src

ENTRYPOINT ["bash"]