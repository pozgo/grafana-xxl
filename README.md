# Grafana XXL [![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/?repo=https://github.com/monitoringartist/grafana-xxl)

**Hot tip: [branch 3.0](https://github.com/monitoringartist/grafana-xxl/tree/3.0)
contains dev preview of Grafana 3.0 with some supported plugins, panels and apps.** 

Official Grafana with unofficial plugins: Zabbix, DalmatinerDB, Bosun,
Cloudera Manager, OpenNMS, Druid, Atsd, Chnocchi, PRTG, Ambari, ...

Official inbuilt plugins: Graphite, InfluxDB, OpenTSDB, CloudWatch,
Elasticsearch, Grafana, Prometheus, SQL, KairosDB.

![Grafana XXL datasources](https://raw.githubusercontent.com/monitoringartist/grafana-xxl/master/doc/grafana-xxl-datasources.png)

Please donate to author, so he can continue to publish another awesome projects
for free:

[![Paypal donate button](http://jangaraj.com/img/github-donate-button02.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=8LB6J222WRUZ4)

# Running your Grafana XXL Docker image

Start your image binding the external port 3000:

    docker run -d --name=grafana-xxl -p 3000:3000 monitoringartist/grafana-xxl

Try it out, default admin user is admin/admin.

## Grafana XXL with persistent storage (recommended)

    # create /var/lib/grafana as persistent volume storage
    docker run -d -v /var/lib/grafana --name grafana-xxl-storage busybox:latest

    # start grafana-xxl
    docker run \
      -d \
      -p 3000:3000 \
      --name grafana-xxl \
      --volumes-from grafana-xxl-storage \
      monitoringartist/grafana-xxl

## Running specific version of Grafana XXL

    # specify right tag, e.g. 2.6.0 - see Docker Hub for available tags
    docker run \
      -d \
      -p 3000:3000 \
      --name grafana-xxl \
      monitoringartist/grafana-xxl:2.6.0
      
## Configuring your Grafana container

All options defined in conf/grafana.ini can be overriden using environment
variables, for example:

    docker run \
      -d \
      -p 3000:3000 \
      --name=grafana-xxl \
      -e "GF_SERVER_ROOT_URL=http://grafana.server.name" \
      -e "GF_SECURITY_ADMIN_PASSWORD=secret" \
      monitoringartist/grafana-xxl
      
# Included plugins

See plugin projects also for documentation:

- [Zabbix](https://github.com/alexanderzobnin/grafana-zabbix)
- [Dataloop](https://github.com/dataloop/grafana-plugin)
- [DalmatinerDB](https://github.com/dalmatinerdb/dalmatiner-grafana-plugin)
- [Atsd, Bosun, Cloudera Manager, Druid, Gnocchi](https://github.com/grafana/grafana-plugins)
- [PRTG](https://github.com/neuralfraud/grafana-prtg)
- [Ambari](https://github.com/u39kun/ambari-grafana)
- [OpenNMS](https://github.com/OpenNMS/grafana)

Please report any plugin issues directly to the author.

## Supported monitoring services
 
- [Hawkular](http://www.hawkular.org/docs/components/metrics/grafana_integration.html)
- [Raintank](http://raintank.io/docs/litmus/raintank-datasource/)

Integrations
============

* [Puppet for dockerized grafana-xxl](https://github.com/monitoringartist/grafana-xxl/blob/master/puppet.md)
* [Ansible for dockerized grafana-xxl](https://github.com/monitoringartist/grafana-xxl/blob/master/ansible.md)
* [docker-compose for dockerized grafana-xxl](https://github.com/monitoringartist/grafana-xxl/blob/master/docker-compose.yml)


# Author

[Devops Monitoring zExpert](http://www.jangaraj.com 'DevOps / Docker / Kubernetes / Zabbix / Zenoss / Monitoring'), who loves monitoring
systems, which start with letter Z. Those are Zabbix and Zenoss.

Professional monitoring services:

[![Monitoring Artist](http://monitoringartist.com/img/github-monitoring-artist-logo.jpg)](http://www.monitoringartist.com 'DevOps / Docker / Kubernetes / Zabbix / Zenoss / Monitoring')
