
resource "postgresql_role" "my_role" {
  name     = local.db_role
  login    = true
  password = "mypass"
}


resource "postgresql_database" "my_db" {
  name                   = local.db_name
  owner                  = local.db_role
  template               = "template0"
  lc_collate             = "C"
  connection_limit       = -1
  allow_connections      = true
  alter_object_ownership = true

  depends_on = [ postgresql_role.my_role ]
}

data "postgresql_schemas" "my_schemas" {
  database = local.db_name

  depends_on = [ postgresql_database.my_db ]
}