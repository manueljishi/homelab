# Useful commands

- Inside charts folder run ```./generate.sh``` to create the required manifests
- Inside tf folder run ```TF_CLI_CONFIG_FILE=$(pwd)/.terraformrc terraform init -backend-config=backend.conf``` to use terraform's remote state
- To apply tf changes ```TF_CLI_CONFIG_FILE=$(pwd)/.terraformrc terraform apply```

- helm update dependencies
- helm template . > output/res.yaml
