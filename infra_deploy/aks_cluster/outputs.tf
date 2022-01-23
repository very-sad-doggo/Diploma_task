output "aks_client_key" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.client_key}"
}

output "aks_client_certificate" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate}"
}

output "aks_cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate}"
}

output "aks_cluster_username" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.username}"
}

output "aks_cluster_password" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.password}"
}

output "aks_kube_config" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config_raw}"
}

output "aks_host" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.host}"
}

output "aks_subnet_id" {
  value = "${azurerm_kubernetes_cluster.k8s.default_node_pool.0.vnet_subnet_id}"
}

output "aks_network_plugin" {
  value = "${azurerm_kubernetes_cluster.k8s.network_profile.0.network_plugin}"
}

output "aks_service_cidr" {
  value = "${azurerm_kubernetes_cluster.k8s.network_profile.0.service_cidr}"
}

output "aks_dns_service_ip" {
  value = "${azurerm_kubernetes_cluster.k8s.network_profile.0.dns_service_ip}"
}

output "aks_docker_bridge_cidr" {
  value = "${azurerm_kubernetes_cluster.k8s.network_profile.0.docker_bridge_cidr}"
}

output "aks_pod_cidr" {
  value = "${azurerm_kubernetes_cluster.k8s.network_profile.0.pod_cidr}"
}