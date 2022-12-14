#specify the image to start with
FROM hashicorp/terraform:1.0.1 as tf
MAINTAINER "Contino APAC <delivery.au@contino.io>"

#install various components
RUN apk add --update --no-cache \
        make \
        bash \
        python3 \
        py3-pip \
        jq && \
    pip3 install --upgrade pip && \
    pip3 install \
        google \
        google-api-python-client \
        google-auth \
        awscli


# set default home directory for root.
ENV HOME /home/terraform
