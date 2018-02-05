FROM rastasheep/ubuntu-sshd
MAINTAINER Erik R. Rygg <errygg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
  unzip && mkdir -p /etc/vault-ssh-helper.d && \
  mkdir -p /usr/local/bin

WORKDIR /usr/local/bin

RUN wget https://releases.hashicorp.com/vault-ssh-helper/0.1.4/vault-ssh-helper_0.1.4_linux_amd64.zip \
  -O tmp.zip && unzip tmp.zip && rm tmp.zip

COPY config.hcl /etc/vault-ssh-helper.d/

RUN sed -i "s/\@include common-auth//g" /etc/pam.d/sshd

RUN echo "auth requisite pam_exec.so quiet expose_authtok\n \
          log=/tmp/vaultssh.log /usr/local/bin/vault-ssh-helper -config=/etc/vault-ssh-helper.d/config.hcl\n \
          auth optional pam_unix.so not_set_pass use_first_pass nodelay" >> /etc/pam.d/sshd

RUN sed -i "s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g" /etc/ssh/sshd_config

RUN sed -i "s/\#UsePAM no/UsePAM yes/g" /etc/ssh/sshd_config

RUN sed -i "s/\#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D"]
