FROM fedora:latest

MAINTAINER Andrea Cristofori <crsndr@ebi.ac.uk>

#Change host:port to the appropriate values and uncomment
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

#USER crs_adm

# Expose default HTTP connector port and gmetad.
EXPOSE 80
EXPOSE 8649

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
#VOLUME ["/var/atlassian/jira", "/opt/atlassian/jira/logs"]

COPY "ganglia.conf" "/etc/httpd/conf.d/ganglia.conf"

ENTRYPOINT [/sbin/httpd -k start && /sbin/gmetad]
