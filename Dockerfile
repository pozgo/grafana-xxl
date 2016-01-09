FROM grafana/grafana:2.6.0
MAINTAINER Jan Garaj info@monitoringartist.com

# inbuilt datasources:
# cloudwatch elasticsearch grafana graphite influxdb mixed opentsdb prometheus 
# sql kairosdb 

RUN \
  apt-get update && \
  apt-get -y install git && \
  cd /tmp && \
  ### zabbix ### && \
  git clone https://github.com/alexanderzobnin/grafana-zabbix && \
  cd /tmp/grafana-zabbix/ && \
  git checkout master && \
  mv /tmp/grafana-zabbix/zabbix/ /usr/share/grafana/public/app/plugins/datasource/ && \
  cd /tmp && \
  rm -rf /tmp/grafana-zabbix/ && \
  ### atlas atsd bosun clouderamanager druid gnocchi ### && \
  git clone https://github.com/grafana/grafana-plugins && \
  rm -rf /tmp/grafana-plugins/datasources/zabbix && \
  mv /tmp/grafana-plugins/datasources/* /usr/share/grafana/public/app/plugins/datasource/ && \
  rm -rf /tmp/grafana-plugins && \
  ### PRTG ### && \
  git clone https://github.com/neuralfraud/grafana-prtg && \
  mv /tmp/grafana-prtg/PRTG/ /usr/share/grafana/public/app/plugins/datasource/ && \
  rm -rf /tmp/grafana-prtg && \
  ### ambari ### && \
  git clone https://github.com/u39kun/ambari-grafana && \
  mv /tmp/ambari-grafana/ambari/ /usr/share/grafana/public/app/plugins/datasource/ && \
  rm -rf /tmp/ambari-grafana && \
  ### dalmatinerdb ### && \
  git clone https://github.com/dalmatinerdb/dalmatiner-grafana-plugin && \
  mv /tmp/dalmatiner-grafana-plugin/dalmatinerdb/ /usr/share/grafana/public/app/plugins/datasource/ && \
  rm -rf /tmp/dalmatiner-grafana-plugin && \
  ### kairosdb ### && \
  #git clone https://github.com/br0th3r/grafana2-kairosdb-datasource-plugin && \
  #mv /tmp/grafana2-kairosdb-datasource-plugin/kairosdb/ /usr/share/grafana/public/app/plugins/datasource/ && \
  #rm -rf /tmp/grafana2-kairosdb-datasource-plugin && \
  # branding && \
  sed -i 's#<title>Grafana</title>#<title>Grafana XXL</title>#g' /usr/share/grafana/public/views/index.html && \
  sed -i 's#<title>Grafana</title>#<title>Grafana XXL</title>#g' /usr/share/grafana/public/views/500.html && \
  sed -i 's#logo_transparent_200x75.png">#logo_transparent_200x75.png"><br />Grafana XXL<br /><small><a href="http://www.monitoringartist.com" target="_blank">Customized by Monitoring Artist</a></small>#g' /usr/share/grafana/public/app/partials/login.html && \  
  apt-get autoremove -y git && \
  apt-get clean
