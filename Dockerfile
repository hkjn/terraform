FROM hkjn/alpine

ENV TF_VERSION 0.7.5

ENV USER tfuser

# TODO: Grab
# https://releases.hashicorp.com/terraform/0.7.5/terraform_0.7.5_SHA256SUMS,
# https://releases.hashicorp.com/terraform/0.7.5/terraform_0.7.5_SHA256SUMS.sig,
# and check that signature was valid GPG key:
# https://www.hashicorp.com/security.html

RUN apk add --no-cache ca-certificates curl && \
    curl -fsSLO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip && \
    mv terraform /usr/bin/ && \
    rm terraform_${TF_VERSION}_linux_amd64.zip && \
    adduser -D $USER

#apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ terraform && \

USER $USER
WORKDIR /home/$USER

ENTRYPOINT ["terraform"]