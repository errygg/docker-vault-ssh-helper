FROM rastasheep/ubuntu-sshd
MAINTAINER Erik R. Rygg <errygg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
  unzip && mkdir -p /etc/vault-ssh-helper.d && \
  mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

RUN wget https://releases.hashicorp.com/vault-ssh-helper/0.1.4/vault-ssh-helper_0.1.4_linux_amd64.zip \
  -O tmp.zip && unzip tmp.zip && rm tmp.zip

COPY files/config.hcl /etc/vault-ssh-helper.d/

COPY files/sshd /etc/pam.d/

RUN sed -i "s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g" /etc/ssh/sshd_config

RUN sed -i "s/^#UsePAM yes/UsePAM yes/g" /etc/ssh/sshd_config

RUN sed -i "s/\#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config

RUN useradd -ms /bin/bash ubuntu

RUN usermod -aG sudo ubuntu

CMD ["/usr/sbin/sshd", "-D"]
