output "details" {
  value = {
    # database_host = {
    #   for name, db in module.database :
    #   name => db.server_details.host
    # }

    public_ips = {
      for name, ip in module.public_ips :
      name => ip.public_ip.address
    }
  }
}