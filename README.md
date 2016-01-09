# Grafana XXL

Official Grafana with unofficial datasource plugins: Zabbix, Atlas, Atsd, Bosun, 
Cloudera manager, Druid Chnocchi, PRTG, Ambari, Dalmatiner DB 

Please donate to author, so he can continue to publish another awesome projects 
for free:

[![Paypal donate button](http://jangaraj.com/img/github-donate-button02.png)]
(https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=8LB6J222WRUZ4)

# Running your Grafana XXL image

Start your image binding the external port 3000.

    docker run -i -p 3000:3000 monitoringartist/grafana-xxl

Try it out, default admin user is admin/secret.

#Configuring your Grafana container

All options defined in conf/grafana.ini can be overriden using environment variables, for example:

    docker run -i -p 3000:3000 \
      -e "GF_SERVER_ROOT_URL=http://grafana.server.name"  \
      -e "GF_SECURITY_ADMIN_PASSWORD=secret  \
      monitoringartist/grafana-xxl

# Included plugins

- [zabbix](https://github.com/alexanderzobnin/grafana-zabbix)
- [atlas, atsd, bosun, clouderamanager, druid, gnocchi](https://github.com/grafana/grafana-plugins)
- [PRTG](https://github.com/neuralfraud/grafana-prtg)
- [ambari](https://github.com/u39kun/ambari-grafana)
- [dalmatinerdb](https://github.com/dalmatinerdb/dalmatiner-grafana-plugin)

Please report any plugin issues directly to the author. 

# Author

[Devops Monitoring zExpert](http://www.jangaraj.com 'DevOps / Docker / Kubernetes / Zabbix / Zenoss / Monitoring'), who loves monitoring 
systems, which start with letter Z. Those are Zabbix and Zenoss.

Professional monitoring services:

[![Monitoring Artist](http://monitoringartist.com/img/github-monitoring-artist-logo.jpg)]
(http://www.monitoringartist.com 'DevOps / Docker / Kubernetes / Zabbix / Zenoss / Monitoring')
