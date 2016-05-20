Docker Image for Mcollective client
===================================

Usage
-----

```shell
$ docker run --rm -it \
  -v $HOME/.mcollective:/root/.mcollective \
  -v $HOME/.ssh/id_rsa:$HOME/.ssh/id_rsa \
  -v $HOME/.ssh/$USER.pem:$HOME/.ssh/$USER.pem \
  -v $SSH_AUTH_SOCK:/tmp/ssh_auth_sock \
  -e SSH_AUTH_SOCK=/tmp/ssh_auth_sock \
  -v /etc/puppetlabs/mcollective/server_public.pem:/etc/puppetlabs/mcollective/server_public.pem \
  camptocamp/mco ping
```
