yq -i -y ".djangodemo.deployments.${1}.tag = \"${2}\"" apps/values.yaml
