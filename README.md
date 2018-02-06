### docker-vault-ssh-helper Docker Container

This image comes with [vault-ssh-helper](https://github.com/hashicorp/vault-ssh-helper) installed as well as sshd. Both are
configured to allow connectivity to a [HashiCorp Vault](https://www.vaultproject.io/) server in `dev` mode. It
is used to test [OTP](https://www.vaultproject.io/docs/secrets/ssh/one-time-ssh-passwords.html).

For information on how to use this container please review the following blog:
https://medium.com/@errygg/building-a-local-hashicorp-vault-cluster-5575fe322a17.

#### Installation
  $ docker pull errygg/docker-vault-ssh-helper:latest

#### NOTE
This container is used in conjunction with that HashiCorp Vault container and
[Docker networking](https://docs.docker.com/engine/reference/commandline/network_create/). It is assumed you have already instantiated the network as
well as the Vault container. config.hcl assumes you will NOT be changing the
default Docker network settings and therefore uses 172.18.0.2 as the Vault
server IP.
