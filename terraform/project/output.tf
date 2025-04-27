output "backend_ip" {
    value = module.backend.public_ip
}



output "loadbalancer_ip" {
    value = module.loadbalancer.public_ip
}

