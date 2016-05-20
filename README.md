Docker Image for Mcollective client
===================================

Usage
-----

```shell
$ docker run --rm -it \
  -v $HOME/.ssh/id_rsa:$HOME/.ssh/id_rsa \
  -v $HOME/.ssh/$USER.pem:$HOME/.ssh/$USER.pem \
  -v /etc/puppetlabs/mcollective/server_public.pem:/server_public.pem \
  -v $SSH_AUTH_SOCK:/tmp/ssh_auth_sock \
  -e SSH_AUTH_SOCK=/tmp/ssh_auth_sock \
  -e STOMP_HOST=activemq.example.com \
  -e STOMP_PASSWORD=secret \
  -e MCOLLECTIVE_SSL_SERVER_PUBLIC=/etc/puppetlabs/mcollective/server_public.pem \
  -e MCOLLECTIVE_SSL_PUBLIC=/home/mcanevet/.ssh/mcanevet.pem \
  -e MCOLLECTIVE_SSL_PRIVATE=/home/mcanevet/.ssh/id_rsa \
  camptocamp/mco ping
```
