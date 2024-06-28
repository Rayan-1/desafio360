resource "local_file" "kind_config" {
  content  = file("${path.module}/kind-config.yaml")
  filename = "${path.module}/kind-config-generated.yaml"
}

resource "null_resource" "kind_cluster" {
  provisioner "local-exec" {
    command = "kind create cluster --config ${local_file.kind_config.filename}"
  }
}
