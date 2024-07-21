resource "helm_release" "argocd" {
  name  = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "7.3.9"
  timeout          = "1500"
  create_namespace = true
  values = [ 
	"${file(abspath("${path.module}/../clusterApps/argocd/values.yaml"))}"
   ]
}

resource "helm_release" "traefik" {
  name  = "traefik"

  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  namespace        = "traefik"
  version          = "28.2.0"
  timeout          = "1500"
  create_namespace = true
  values = [ 
	"${file(abspath("${path.module}/../clusterApps/traefik/values.yaml"))}"
   ]
}
resource "helm_release" "nvidiagpu" {
  name = "nvidia"
  repository  = "https://helm.ngc.nvidia.com/nvidia"
  chart      = "gpu-operator"
  namespace  = "gpu-operator"

  create_namespace = true

  set {
    name  = "toolkit.env[0].name"
    value = "CONTAINERD_CONFIG"
  }

  set {
    name  = "toolkit.env[0].value"
    value = "/var/lib/rancher/k3s/agent/etc/containerd/config.toml"
  }

  set {
    name  = "toolkit.env[1].name"
    value = "CONTAINERD_SOCKET"
  }

  set {
    name  = "toolkit.env[1].value"
    value = "/run/k3s/containerd/containerd.sock"
  }

  set {
    name  = "toolkit.env[2].name"
    value = "CONTAINERD_RUNTIME_CLASS"
  }

  set {
    name  = "toolkit.env[2].value"
    value = "nvidia"
  }

  set {
    name  = "toolkit.env[3].name"
    value = "CONTAINERD_SET_AS_DEFAULT"
  }

  set {
    name  = "toolkit.env[3].value"
    value = "true"
    type = "string"
  }

  wait = true
}