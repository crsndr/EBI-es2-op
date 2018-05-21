FROM fedora:latest

MAINTAINER Andrea Cristofori <crsndr@ebi.ac.uk>

#ENV http_proxy host:port
#ENV https_proxy host:port

RUN set -x \
    && mkdir -p /var/lib/ganglia/rrds \
    && chown -R ganglia:ganglia /var/lib/ganglia/rrds \
    && dnf install \
    ganglia-gmond \
    ganglia-gmetad \
    ganglia-web

# Use the unprivileged account.

# Expose default HTTP connector port and gmetad.
EXPOSE 80
EXPOSE 8659

COPY "ganglia.conf" "/etc/httpd/conf.d/ganglia.conf"
COPY "gmetad.conf" "/etc/gmetad.conf"
COPY "gmond.conf" "/etc/gmond.conf"

RUN /sbin/gmetad
RUN /sbin/gmond

ENTRYPOINT [/sbin/httpd -k start]
