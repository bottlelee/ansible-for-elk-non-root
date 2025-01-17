FROM semaphoreui/semaphore AS stage1

ARG PYTHON_VERSION=3.9.9
ARG SEMAPHORE_USER_ID=1000

USER root

RUN apk add --no-cache --upgrade fish htop byobu sshpass nano shadow tzdata wget \
  openssh-client curl gcc make zlib-dev libffi-dev openssl-dev musl-dev \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

## Download and extract Python source
RUN cd /opt \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xzf Python-${PYTHON_VERSION}.tgz

## Build Python
RUN cd /opt/Python-${PYTHON_VERSION} \
    && ./configure --prefix=/usr --enable-optimizations --with-ensurepip=install \
    && make install

RUN chsh -s /usr/bin/fish semaphore \
  && usermod -u ${SEMAPHORE_USER_ID} semaphore

## Initialize the semaphore user
FROM stage1 AS stage2

ENV PATH=/home/semaphore/.local/bin:$PATH

USER semaphore

COPY ssh_config /home/semaphore/.ssh/config

RUN pip3 install --user --no-cache-dir --upgrade pip \
  && pip3 install --user --no-cache-dir netaddr pyyaml jmespath ansible \
  pywinrm passlib requests docker

RUN fish -c 'function pansible; ansible-playbook $argv; end; funcsave pansible' \
  && mkdir -p ~/.config/fish/completions/ \
  && fish -c 'semaphore completion fish > ~/.config/fish/completions/semaphore.fish' \
  && mkdir -p /home/semaphore/data \
    /home/semaphore/config \
    /home/semaphore/tmp

## Cleanup
FROM stage2 AS stage3

USER root

RUN rm -rf /opt/Python-${PYTHON_VERSION} /opt/Python-${PYTHON_VERSION}.tgz \
  && apk del \
    wget \
    gcc \
    make \
    zlib-dev \
    libffi-dev \
    openssl-dev \
    musl-dev \
  && rm /var/lib/apk -rf \
  && rm /var/cache/apk -rf

RUN userdel -f root