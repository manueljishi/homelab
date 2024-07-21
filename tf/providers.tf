terraform {
  backend "remote" {}
  required_providers {
    
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.13.2"
    }
    
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
  config_path = "~/.kube/config"  
  }
}