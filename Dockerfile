FROM alpine:3.8

RUN apk add gcc build-base linux-headers ca-certificates \
            libressl-dev libffi-dev libxml2-dev libxslt-dev \
            python3-dev && \
    rm -rf /var/cache/apk/*

WORKDIR /proxybroker

ADD . .

RUN pip3 install -r requirements.txt

RUN python3 setup.py install

RUN rm -rf /proxybroker

EXPOSE 8888

CMD ["proxybroker", "serve", "--host=0.0.0.0", "--port=8888", "--lvl=High", "--types", "HTTP", "HTTPS", "--max_requests_per_proxy=25"]
