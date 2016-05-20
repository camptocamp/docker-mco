Docker Image for Mcollective client
===================================

Usage
-----

```shell
$ docker run --rm -it \
  -v $HOME/.mcollective:/root/.mcollective \
  -v $HOME/.ssh/id_rsa:$HOME/.ssh/id_rsa \
  -v /etc/puppetlabs/mcollective/server_public.pem:/etc/puppetlabs/mcollective/server_public.pem \
  camptocamp/mco ping
```

Using puppetca plugin
---------------------

To use puppetca plugin you have to increase discovery timeout so that you have time to enter your password:

```shell
$ docker run --rm -it \
  -v $HOME/.mcollective:/root/.mcollective \
  -v $HOME/.ssh/id_rsa:$HOME/.ssh/id_rsa \
  -v /etc/puppetlabs/mcollective/server_public.pem:/etc/puppetlabs/mcollective/server_public.pem \
  camptocamp/mco rpc --discovery-timeout 10 puppetca list
```
