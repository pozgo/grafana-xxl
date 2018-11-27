#!/bin/bash

chown -R grafana:grafana /var/lib/grafana /var/log/grafana

if [ ! -z ${GF_AWS_PROFILES+x} ]; then
    for profile in ${GF_AWS_PROFILES}; do
        access_key_varname="GF_AWS_${profile}_ACCESS_KEY_ID"
        secret_key_varname="GF_AWS_${profile}_SECRET_ACCESS_KEY"
        region_varname="GF_AWS_${profile}_REGION"

        if [ ! -z "${!access_key_varname}" -a ! -z "${!secret_key_varname}" ]; then
            echo "[${profile}]" >> ~grafana/.aws/credentials
            echo "aws_access_key_id = ${!access_key_varname}" >> ~grafana/.aws/credentials
            echo "aws_secret_access_key = ${!secret_key_varname}" >> ~grafana/.aws/credentials
            if [ ! -z "${!region_varname}" ]; then
                echo "region = ${!region_varname}" >> ~grafana/.aws/credentials
            fi
        fi
    done

    chown grafana:grafana -R ~grafana/.aws
    chmod 600 ~grafana/.aws/credentials
fi

# upgrade all installed plugins
if [ "$UPGRADEALL" = true ] ; then
    grafana-cli --pluginsDir "${GF_PLUGIN_DIR}" plugins upgrade-all || true
fi

exec gosu grafana /usr/sbin/grafana-server   \
  --homepath="${GF_PATHS_HOME}"              \
  --config="${GF_PATHS_CONFIG}"              \
  cfg:default.paths.data=${GF_PATHS_DATA}    \
  cfg:default.paths.logs=${GF_PATHS_LOGS}    \
  cfg:default.paths.plugins=${GF_PLUGIN_DIR} \
  "$@"
