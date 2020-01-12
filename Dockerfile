FROM alpine

ENV KUBE_LATEST_VERSION="v1.17.0" \
    KEYPAIR_LOGIN=false

RUN apk add --no-cache ca-certificates bash git bash-completion ncurses \
jq curl bash gcc g++ make libffi-dev openssl-dev openssh-client \
python python-dev py-pip build-base openssh \
&& pip install --upgrade pip \
&& pip install requests pytest pykube \
&& git clone https://github.com/ahmetb/kubectx.git ~/.kubectx \
&& ln -sf ~/.kubectx/completion/kubens.bash /usr/share/bash-completion/completions/kubens \
&& ln -sf ~/.kubectx/completion/kubectx.bash /usr/share/bash-completion/completions/kubectx \
&& wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
&& wget -q https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
&& wget -q https://dl.minio.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc
COPY ./files/* /root/
RUN chmod +x /usr/local/bin/mc /usr/local/bin/helm /usr/local/bin/kubectl /root/entrypoint.sh /root/.bashrc

EXPOSE      22
VOLUME      ["/etc/ssh"]
ENTRYPOINT  ["/root/entrypoint.sh"]
