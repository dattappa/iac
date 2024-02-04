resource "kubernetes_namespace" "my_namespace" {
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]

  metadata {
    name = var.namespace-name
  }
}
