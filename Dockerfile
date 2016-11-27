FROM hkjn/alpine

ENV TF_VERSION=0.7.13 \
    USER=tfuser

COPY hashicorp.asc .

RUN apk add --no-cache ca-certificates curl gnupg && \
    gpg --import hashicorp.asc && \
    curl -fsSLO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    curl -fsSLO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS && \
    curl -fsSLO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS.sig && \
    echo "$(grep terraform_${TF_VERSION}_linux_amd64.zip terraform_${TF_VERSION}_SHA256SUMS)" > SHA256SUMS && \
    gpg --verify terraform_${TF_VERSION}_SHA256SUMS.sig terraform_${TF_VERSION}_SHA256SUMS && \
    sha256sum -c SHA256SUMS && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip && \
    mv terraform /usr/bin/ && \
    rm terraform_${TF_VERSION}_linux_amd64.zip terraform_${TF_VERSION}_SHA256SUMS terraform_${TF_VERSION}_SHA256SUMS.sig SHA256SUMS && \
    adduser -D $USER

USER $USER
WORKDIR /home/$USER

ENTRYPOINT ["terraform"]