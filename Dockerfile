FROM ruby:alpine

ENV MCO_VERSION 2.8.4

RUN gem install net-ssh --no-ri --no-rdoc \
  && gem install mcollective-client --version $MCO_VERSION --no-ri --no-rdoc

RUN apk add --update git \
 && rm -rf /var/cache/apk/*

WORKDIR /usr/local/bundle/gems/mcollective-client-$MCO_VERSION

COPY ./patches/ /patches

# Install MCollective's r10k plugin
RUN git clone https://github.com/acidprime/r10k.git \
  && cp r10k/files/application/r10k.rb lib/mcollective/application/ \
  && cp r10k/files/agent/r10k.ddl lib/mcollective/agent/ \
  && cp r10k/templates/agent/r10k.rb.erb lib/mcollective/agent/r10k.rb \
  && patch -p1 < /patches/01-r10k-agent.patch \
  && rm -rf r10k

# Install MCollective's puppetca plugin
RUN git clone https://github.com/puppetlabs/mcollective-puppetca-agent.git \
  && cp mcollective-puppetca-agent/agent/puppetca.ddl lib/mcollective/agent/ \
  && cp mcollective-puppetca-agent/agent/puppetca.rb lib/mcollective/agent/ \
  && rm -rf mcollective-puppetca-agent

# Patch to use ssh-agent (https://github.com/puppetlabs/marionette-collective/pull/372)
RUN patch -p1 < /patches/00-ssh-agent.patch

ENTRYPOINT [ "mco" ]
CMD [ "--help" ]
