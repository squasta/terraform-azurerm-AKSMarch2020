
data "helm_repository" "Terra-Bitnami" {
  name = "Bitnami"
  url  = "https://charts.bitnami.com/bitnami"
}

# https://github.com/bitnami/charts/tree/master/bitnami/grafana
resource "helm_release" "Terra-grafana" {
  name       = "my-grafana"
  repository = data.helm_repository.Terra-Bitnami.metadata[0].name
  chart      = "bitnami/grafana"

  set {
    name  = "admin.user"
    value = var.grafana_admin_username
  }

  set {
    name  = "admin.password"
    value = data.azurerm_key_vault_secret.grafana_admin_password.value
  }

  set {
    name  = "replicaCount"
    value = 3
  }

}

