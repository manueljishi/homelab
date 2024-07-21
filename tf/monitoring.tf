# resource "kubernetes_persistent_volume" "prometheus-pv" {
#   metadata {
#     name = "prometheus-pv"
#   }
#   spec {
#     capacity = {
#       storage = "3Gi"
#     }
#     access_modes = ["ReadWriteMany"]
#     persistent_volume_reclaim_policy = "Retain"
#     storage_class_name = "prometheus"
# 	persistent_volume_source {
#     host_path {
#       path = "/config/prometheus"
#     }
# 	}
# 	# node_affinity {
# 	#   required  {
# 	# 	node_selector_term {
# 	# 	  match_expressions {
# 	# 		key = "kubernetes.io/hostname"
# 	# 		operator = "IN"
# 	# 		values = [ "<NODE_PROMETHEUS_RUNS>" ]
# 	# 	  }
# 	# 	}
# 	#   }
# 	# }
#   }
# }

# resource "kubernetes_persistent_volume_claim" "prometheus-pvc" {
#   metadata {
# 	name = "prometheus-pvc"
#   }
#   spec {
#     access_modes = ["ReadWriteMany"]
# 	storage_class_name = "prometheus"
#     resources {
#       requests = {
#         storage = "3Gi"
#       }
#     }
#     volume_name = "${kubernetes_persistent_volume.prometheus-pv.metadata.0.name}"
#   }
# }

# resource "kubernetes_persistent_volume" "grafana-pv" {
#   metadata {
#     name = "grafana-pv"
#   }
#   spec {
#     capacity = {
#       storage = "3Gi"
#     }
#     access_modes = ["ReadWriteMany"]
#     persistent_volume_reclaim_policy = "Retain"
#     storage_class_name = "grafana"
# 	persistent_volume_source {
#     host_path {
#       path = "/config/grafana"
#     }
# 	}
# 	# node_affinity {
# 	#   required  {
# 	# 	node_selector_term {
# 	# 	  match_expressions {
# 	# 		key = "kubernetes.io/hostname"
# 	# 		operator = "IN"
# 	# 		values = [ "<NODE_GRAFANA_RUNS>" ]
# 	# 	  }
# 	# 	}
# 	#   }
# 	# }
#   }
# }

# resource "kubernetes_persistent_volume_claim" "grafana-pvc" {
#   metadata {
# 	name = "grafana-pvc"
#   }
#   spec {
#     access_modes = ["ReadWriteMany"]
# 	storage_class_name = "grafana"
#     resources {
#       requests = {
#         storage = "3Gi"
#       }
#     }
#     volume_name = "${kubernetes_persistent_volume.grafana-pv.metadata.0.name}"
#   }
# }

# resource "helm_release" "prometheus" {
#   name = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart = "prometheus"
#   set {
# 	name = "server.persistentVolume.enable"
# 	value = "true"
#   }
#   set {
# 	name = "server.persistentVolume.storageClass"
# 	value = "prometheus"
#   }
#   set {
# 	name = "server.persistentVolume.existingClaim"
# 	value = "prometheus-pvc"
#   }
#   set {
# 	name = "server.securityContext.runAsUser"
# 	value = "0"
#   }
#   set {
# 	name = "server.securityContext.runAsNonRoot"
# 	value = "false"
#   }
#   set {
# 	name = "server.securityContext.runAsGroup"
# 	value = "0"
#   }
#   set {
# 	name = "server.securityContext.fsGroup"
# 	value = "0"
#   }

#   depends_on = [ kubernetes_persistent_volume_claim.prometheus-pvc ]
# }

# resource "helm_release" "grafana" {
#   name = "grafana"
#   repository = "https://grafana.github.io/helm-charts"
#   chart = "grafana"
#   set {
# 	name = "server.persistentVolume.enable"
# 	value = "true"
#   }
#   set {
# 	name = "server.persistentVolume.storageClass"
# 	value = "grafana"
#   }
#   set {
# 	name = "server.persistentVolume.existingClaim"
# 	value = "grafana-pvc"
#   }
#   depends_on = [ kubernetes_persistent_volume_claim.grafana-pvc ]
# }