FROM fedora:26

MAINTAINER Andrea Cristofori <crsndr@ebi.ac.uk>

RUN set -x \
    && dnf -y install \
    ganglia-gmond

COPY "gmond.conf" "/etc/gmond.conf"
COPY "start_gmond.sh" "/start_gmond.sh"

CMD ["/start_gmond.sh"]
