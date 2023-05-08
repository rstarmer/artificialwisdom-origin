# Deploy a "local" Jupyter Hub on K3s

K3S is a lightweight Kubernetes that can do multi-node

Jupyter-Hub is a JupyterLabs notebook manager that is most easily deployed in Kubernetes

## Install approach

* Install a "local" K3s
* Deploy Jupyter-Hub via Helm chart (following the Zero-ot-JupyterHub approach)

## Get K3s

```sh
curl -sfL https://get.k3s.io | sh -
```

the default kubeconfig is in /etc/rancher/k3s/k3s.yaml
 - note by default it is protected for root access, and this is ok for a managed service

Add Kubectl and Helm command line tools:

```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mv kubectl /usr/bin/ && chmod +x /usr/bin/kubectl
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Get and launch Helm

```sh
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
```

Then get a base config:

```sh
cat > config.yaml <<EOF
# This file can update the JupyterHub Helm chart's default configuration values.
#
# For reference see the configuration reference and default values, but make
# sure to refer to the Helm chart version of interest to you!
#
# Introduction to YAML:     https://www.youtube.com/watch?v=cdLNKUoMc6c
# Chart config reference:   https://zero-to-jupyterhub.readthedocs.io/en/stable/resources/reference.html
# Chart default values:     https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/HEAD/jupyterhub/values.yaml
# Available chart versions: https://jupyterhub.github.io/helm-chart/
#
EOF
```

And after modifying any parameters needed, launch with helm

```sh
helm upgrade --cleanup-on-fail \
  --install aw-hub jupyterhub/jupyterhub \
  --namespace aw-hub \
  --create-namespace \
  --values config.yaml \
  --version 2.0.0
```

## TODO

Plenty to do:

- user management based on the AW platform
- launching hub and a separate database (OCI postgres?) per customer
