FROM alpine

ENV KUBE_LATEST_VERSION="v1.13.1"
ENV HELM_VERSION="v2.12.1"

RUN apk add --no-cache ca-certificates bash git bash-completion ncurses \
jq curl bash gcc g++ make libffi-dev openssl-dev openssh-client \
&& wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
&& chmod +x /usr/local/bin/kubectl \
&& wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
&& chmod +x /usr/local/bin/helm \
&& apk add --update --no-cache python python-dev py-pip build-base \
&& pip install --upgrade pip \
&& pip install requests pytest pykube \
&& git clone https://github.com/ahmetb/kubectx.git ~/.kubectx \
&& ln -sf ~/.kubectx/completion/kubens.bash /usr/share/bash-completion/completions/kubens \
&& ln -sf ~/.kubectx/completion/kubectx.bash /usr/share/bash-completion/completions/kubectx \
&& curl -o /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc \
&& chmod +x /usr/local/bin/mc
COPY ./files/* /root/

CMD bash
