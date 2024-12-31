# # Build base image
# FROM semaphoreui/semaphore:latest
# LABEL Creator="haibin.lee@foxmail.com"
# ARG TIMEZONE="Asia/Shanghai"
# ARG SEMAPHORE_UID=1000

# USER root
# RUN apk add --no-cache --upgrade fish htop byobu sshpass nano shadow tzdata \
#   && rm /var/lib/apk -rf \
#   && rm /var/cache/apk -rf \
#   && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
# RUN usermod -u ${SEMAPHORE_UID} semaphore \
#   && chsh -s /usr/bin/fish semaphore \
#   && find / -user 1001 -exec chown -h ${SEMAPHORE_UID} {} \;

# USER semaphore

# RUN pip3 install --user --no-cache-dir --upgrade pip \
#   && pip3 install --user --no-cache-dir netaddr pyyaml jmespath ansible

# RUN fish -c 'function pansible; ansible-playbook $argv; end; funcsave pansible' \
#   && mkdir -p ~/.config/fish/completions/ \
#   && fish -c 'semaphore completion fish > ~/.config/fish/completions/semaphore.fish'

FROM python:3.8-alpine

USER root
RUN apk add --no-cache --upgrade fish htop byobu sshpass nano shadow tzdata wget \
  gcc make musl-dev libffi-dev openssl-dev python3-dev openssh-client \
  && rm /var/lib/apk -rf \
  && rm /var/cache/apk -rf \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && pip3 install --no-cache-dir --upgrade pip \
  && pip3 install --no-cache-dir netaddr pyyaml jmespath ansible

RUN useradd -ms /usr/bin/fish semaphore \
  && wget https://github.com/semaphoreui/semaphore/releases/download/v2.11.2/semaphore_2.11.2_linux_amd64.tar.gz \
  && tar zxvf semaphore_2.11.2_linux_amd64.tar.gz -C /usr/local/bin/ \
  && rm -rf semaphore_2.11.2_linux_amd64.tar.gz

USER semaphore
RUN fish -c 'function pansible; ansible-playbook $argv; end; funcsave pansible' \
  && mkdir -p ~/.config/fish/completions/ \
  && fish -c 'semaphore completion fish > ~/.config/fish/completions/semaphore.fish'

ENTRYPOINT ["/usr/local/bin/semaphore","server"]