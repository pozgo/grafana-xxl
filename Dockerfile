FROM debian:stretch
MAINTAINER Jan Garaj info@monitoringartist.com

ARG GRAFANA_ARCHITECTURE=amd64
ARG GRAFANA_VERSION=7.1.3
ARG GRAFANA_DEB_URL=https://dl.grafana.com/oss/release/grafana_${GRAFANA_VERSION}_${GRAFANA_ARCHITECTURE}.deb
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
  GF_PATHS_CONFIG=/etc/grafana/grafana.ini \
  GF_PATHS_HOME=/usr/share/grafana \
  UPGRADEALL=true

COPY ./run.sh /run.sh

RUN \
  apt-get update && \
  apt-get -y --force-yes --no-install-recommends install libfontconfig curl ca-certificates git jq \
  libx11-6 libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrender1 libxtst6 libglib2.0-0 libnss3 libcups2  libdbus-1-3 libxss1 libxrandr2 libgtk-3-0 libgtk-3-0 libasound2 && \
  curl -L ${GRAFANA_DEB_URL} > /tmp/grafana.deb && \
  dpkg -i /tmp/grafana.deb && \
  rm -f /tmp/grafana.deb && \
  curl -L ${GOSU_BIN_URL} > /usr/sbin/gosu && \
  chmod +x /usr/sbin/gosu && \
  for plugin in $(curl -s https://grafana.net/api/plugins?orderBy=name | jq '.items[] | select(.internal == false) | .slug' | tr -d '"'); do grafana-cli --pluginsDir "${GF_PLUGIN_DIR}" plugins install $plugin; done && \
  chmod +x /run.sh && \
  mkdir -p /usr/share/grafana/.aws/ && \
  touch /usr/share/grafana/.aws/credentials && \
  apt-get remove -y --allow-downgrades --allow-remove-essential --allow-change-held-packages curl git jq && \
  apt-get autoremove -y --allow-downgrades --allow-remove-essential --allow-change-held-packages && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

### branding
RUN \
  sed -i 's/<title>\[\[\.AppTitle\]\]<\/title>/<title>Grafana XXL<\/title>/g' /usr/share/grafana/public/views/index-template.html && \
  sed -i 's/<title>Grafana - Error<\/title>/<title>Grafana XXL - Error<\/title>/g' /usr/share/grafana/public/views/error-template.html

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
