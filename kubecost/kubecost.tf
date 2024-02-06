provider "kubernetes" {
  config_path = "~/.kube/config" 
  config_context_cluster  = "aks-k8s"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context_cluster = "aks-k8s"
  }
}

resource "kubernetes_namespace" "kubecost" {
  metadata {
    name = "kubecost"
  }
}

resource "helm_release" "kubecost" {
  repository = "https://kubecost.github.io/cost-analyzer/"
  chart      = "cost-analyzer"
  name       = "kubecost"
  namespace  = "kubecost"

  set {
    name  = "prometheus.enabled"
    value = "true"
  }

  set {
    name  = "prometheus.alertmanager.persistentVolume.enabled"
    value = "false"
  }

  set {
    name  = "prometheus.server.persistentVolume.enabled"
    value = "false"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }
}

resource "kubernetes_service" "kubecost" {
  metadata {
    name      = "kubecost-service"
    namespace = "kubecost"
  }

  spec {
    selector = {
      app = helm_release.kubecost.name
    }

    port {
      protocol = "TCP"
      port     = 80
      target_port = 9090
    }

    type = "LoadBalancer"  # Exposes the service externally
  }
}
