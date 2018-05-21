FROM fedora:26

MAINTAINER Andrea Cristofori <crsndr@ebi.ac.uk>

#ENV http_proxy host:port
#ENV https_proxy host:port

RUN set -x \
    && dnf -y install \
    ganglia-gmond \
    ganglia-gmetad \
    ganglia-web \
#    mod_fcgid \
    && mkdir -p /var/lib/ganglia/rrds \
    && chown -R ganglia:ganglia /var/lib/ganglia/rrds
#    && chown -R apache:apache /run/php-fpm

# Use the unprivileged account.

# Expose default HTTP connector port and gmetad.
EXPOSE 80
EXPOSE 8659

COPY "ganglia.conf" "/etc/httpd/conf.d/ganglia.conf"
COPY "gmetad.conf" "/etc/gmetad.conf"
COPY "gmond.conf" "/etc/gmond.conf"
COPY "startup.sh" "/startup.sh"
COPY "start_apache.sh" "/start_apache.sh"

ENTRYPOINT ["/startup.sh"]
CMD ["/start_apache.sh"]
