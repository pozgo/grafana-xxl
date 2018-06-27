FROM debian:jessie
MAINTAINER Jan Garaj info@monitoringartist.com

ARG GRAFANA_ARCHITECTURE=amd64
ARG GRAFANA_VERSION=5.1.4
ARG GRAFANA_DEB_URL=https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${GRAFANA_VERSION}_${GRAFANA_ARCHITECTURE}.deb
ARG GOSU_BIN_URL=https://github.com/tianon/gosu/releases/download/1.10/gosu-${GRAFANA_ARCHITECTURE}

### GRAFANA_VERSION=latest = nightly build
ENV \
  GRAFANA_ARCHITECTURE=${GRAFANA_ARCHITECTURE} \
  GRAFANA_VERSION=${GRAFANA_VERSION} \
  GRAFANA_DEB_URL=${GRAFANA_DEB_URL} \
  GOSU_BIN_URL=${GOSU_BIN_URL} \
  GF_PLUGIN_DIR=/grafana-plugins \
  GF_PATHS_LOGS=/var/log/grafana \
  GF_PATHS_DATA=/var/lib/grafana \
  UPGRADEALL=true

COPY ./run.sh /run.sh

RUN \
  apt-get update && \
  apt-get -y --force-yes --no-install-recommends install libfontconfig curl ca-certificates git jq && \
  curl -L ${GRAFANA_DEB_URL} > /tmp/grafana.deb && \
  dpkg -i /tmp/grafana.deb && \
  rm -f /tmp/grafana.deb && \
  curl -L ${GOSU_BIN_URL} > /usr/sbin/gosu && \
  chmod +x /usr/sbin/gosu && \
  for plugin in $(curl -s https://grafana.net/api/plugins?orderBy=name | jq '.items[] | select(.internal=='false') | .slug' | tr -d '"'); do grafana-cli --pluginsDir "${GF_PLUGIN_DIR}" plugins install $plugin; done && \
  ### branding && \
  sed -i 's#<title>Grafana</title>#<title>Grafana XXL</title>#g' /usr/share/grafana/public/views/index.template.html && \
  sed -i 's#<title>Grafana</title>#<title>Grafana XXL</title>#g' /usr/share/grafana/public/views/index.html && \
  sed -i 's#<title>Grafana - Error</title>#<title>Grafana XXL - Error</title>#g' /usr/share/grafana/public/views/error.html && \
  sed -i 's#icon-gf-grafana_wordmark"></i>#icon-gf-grafana_wordmark"> XXL</i>#g' /usr/share/grafana/public/app/partials/login.html && \
  chmod +x /run.sh && \
  mkdir -p /usr/share/grafana/.aws/ && \
  touch /usr/share/grafana/.aws/credentials && \
  apt-get remove -y --force-yes curl git jq && \
  apt-get autoremove -y --force-yes && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
