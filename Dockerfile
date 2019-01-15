################################################################################
# Stage 1 - Download the RoadRunner server binary
# Download, unpack, clean up and setup RoadRunner binary
FROM alpine AS download

ENV RR_VERSION=1.3.1
ENV RR_DOWNLOAD_LINK=https://github.com/spiral/roadrunner/releases/download/v${RR_VERSION}/roadrunner-${RR_VERSION}-linux-amd64.tar.gz
ENV RR_ARCHIVE_DIR=roadrunner-${RR_VERSION}-linux-amd64

RUN wget ${RR_DOWNLOAD_LINK} -O /tmp/rr.tar.gz && \
    cd /tmp/ && tar -xvzf rr.tar.gz -C ./ && \
    mv /tmp/${RR_ARCHIVE_DIR}/rr /usr/local/bin/rr

################################################################################
# Stage 2 - Prepare the minimal S4 microservice setup
# Download, unpack, clean up and setup RoadRunner binary
FROM alpine:edge
ENV HTTP_PORT=80
COPY --from=download /usr/local/bin/rr /usr/local/bin/rr
COPY ./docker/ /
RUN apk --no-cache --update upgrade
RUN apk add \
    curl \
    composer \
    grpc \
    php7 \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-openssl \
    php7-session \
    php7-tokenizer \
    php7-xml

# Go into app folder
# Install all PHP deps
WORKDIR /var/www/app
RUN composer install -o

# Start road runner
EXPOSE ${HTTP_PORT}
ENTRYPOINT [ "/usr/local/bin/rr", "serve", "-v",  "-d" ]