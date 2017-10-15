FROM memcached
MAINTAINER Stanislav <stas@defank.ru>
ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && apt-get install -y supervisor libregexp-common-net-cidr-perl libcache-memcached-perl && \
apt-get install -y munin-node && \
rm -r /var/lib/apt/lists/*

RUN mkdir -p /var/run/munin && \
mkdir /var/lib/apt/lists/partial && \
chown -R munin:munin /var/run/munin && \
chmod -R a+rX /var/log

#---supervisord
RUN mkdir -p /var/log/supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD ./munin-node.conf /etc/munin/munin-node.conf

#other plugins
RUN rm -rf /etc/munin/plugins/* && \
    ln -s /usr/share/munin/plugins/memcached_ /etc/munin/plugins/memcached_bytes && \
    ln -s /usr/share/munin/plugins/memcached_ /etc/munin/plugins/memcached_counters && \
    ln -s /usr/share/munin/plugins/memcached_ /etc/munin/plugins/memcached_rates

EXPOSE 11211

CMD ["/usr/bin/supervisord"]