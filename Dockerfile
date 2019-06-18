#FROM fluent/fluentd:v1.5-1
FROM fluent/fluentd-kubernetes-daemonset

MAINTAINER Marcin Kasi�ski <marcin.kasinski@gmail.com> 

# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install fluent-plugin-elasticsearch \
 && sudo gem install fluent-plugin-kafka \
 && sudo gem install fluent-plugin-concat \
 && sudo gem install fluent-plugin-grok-parser \
 && sudo gem install fluent-plugin-kubernetes_metadata_filter \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem \
 && apk add --update curl && rm -rf /var/cache/apk/*

#COPY fluent.conf /fluentd/etc/
#COPY entrypoint.sh /bin/

USER fluent