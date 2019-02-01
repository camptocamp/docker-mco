FROM ruby:alpine

ENV STOMP_VERSION 1.3.5
ENV MCO_VERSION 2.9.1

RUN gem install stomp --version $STOMP_VERSION \
  && gem install net-ssh \
  && gem install mcollective-client --version $MCO_VERSION

RUN apk add --update git \
 && rm -rf /var/cache/apk/*

WORKDIR /usr/local/bundle/gems/mcollective-client-$MCO_VERSION

COPY ./patches/ /patches

RUN mkdir lib/mcollective/util/

# Install Puppetlabs's plugins
RUN for plugin in filemgr package puppet puppetca service; do \
    git clone https://github.com/puppetlabs/mcollective-$plugin-agent.git ; \
    test -d mcollective-$plugin-agent/agent/ && cp -a mcollective-$plugin-agent/agent/ lib/mcollective/ ; \
    test -d mcollective-$plugin-agent/application/ && cp -a mcollective-$plugin-agent/application/ lib/mcollective/ ; \
    test -d mcollective-$plugin-agent/data/ && cp -a mcollective-$plugin-agent/data/ lib/mcollective/ ; \
    test -d mcollective-$plugin-agent/util/ && cp -a mcollective-$plugin-agent/util/ lib/mcollective/ ; \
    test -d mcollective-$plugin-agent/validator/ && cp -a mcollective-$plugin-agent/validator/ lib/mcollective/ ; \
    rm -rf mcollective-$plugin-agent ; \
  done

# Install r10k plugin
RUN git clone https://github.com/acidprime/r10k.git \
  && cp r10k/files/application/r10k.rb lib/mcollective/application/ \
  && cp r10k/files/agent/r10k.ddl lib/mcollective/agent/ \
  && cp r10k/templates/agent/r10k.rb.erb lib/mcollective/agent/r10k.rb \
  && patch -p1 < /patches/01-r10k-agent.patch \
  && rm -rf r10k

# Install puppetnode plugin
RUN git clone https://github.com/camptocamp/docker-mcollectived-node.git \
  && cp docker-mcollectived-node/plugins/mcollective/agent/* lib/mcollective/agent/ \
  && rm -rf docker-mcollectived-node

# Patch to use ssh-agent (https://github.com/puppetlabs/marionette-collective/pull/372)
RUN patch -p1 < /patches/00-ssh-agent.patch

# Allows to set Stomp host using an environment variable
RUN patch -p1 < /patches/02-stomp_host.patch

COPY ./client.cfg /root/.mcollective

ENTRYPOINT [ "mco" ]
CMD [ "--help" ]
