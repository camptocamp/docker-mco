Docker Image for Mcollective client
===================================

Usage
-----

Export environment variables:
```
export STOMP_HOST=activemq.example.com
export STOMP_PASSWORD=secret
export MCOLLECTIVE_SSL_SERVER_PUBLIC=/etc/puppetlabs/mcollective/server_public.pem
export MCOLLECTIVE_SSL_PUBLIC=$HOME/.ssh/$USER.pem
export MCOLLECTIVE_SSL_PRIVATE=$HOME/.ssh/id_rsa
```

Launch Docker image:
```shell
$ docker run --rm -it \
  -v $HOME/.ssh/id_rsa:$HOME/.ssh/id_rsa \
  -v $HOME/.ssh/$USER.pem:$HOME/.ssh/$USER.pem \
  -v /etc/puppetlabs/mcollective/server_public.pem:/server_public.pem \
  -v $SSH_AUTH_SOCK:/tmp/ssh_auth_sock \
  -e SSH_AUTH_SOCK=/tmp/ssh_auth_sock \
  -e STOMP_HOST=$STOMP_HOST \
  -e STOMP_PASSWORD=$STOMP_PASSWORD \
  -e MCOLLECTIVE_SSL_SERVER_PUBLIC=$MCOLLECTIVE_SSL_SERVER_PUBLIC \
  -e MCOLLECTIVE_SSL_PUBLIC=$MCOLLECTIVE_SSL_PUBLIC \
  -e MCOLLECTIVE_SSL_PRIVATE=$MCOLLECTIVE_SSL_PRIVATE \
  camptocamp/mco ping
```
