output "details" {
  value = {
    database_host = {
      for name, db in module.database :
      name => format(
        "Host=%s;Port=5432;Database=postgres;Username=%s;Password=%s;SSL Mode=Require;Trust Server Certificate=true",
        db.server_details.host,
        db.server_details.username,
        db.server_details.password
      )
    }
    public_ips = {
      for name, ip in module.public_ips :
      name => ip.public_ip.address
    }
  }
  sensitive = true
}
