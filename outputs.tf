# TODO: output the names of all containers.
# Hint: docker_container.app[*].name
output "schema" {
    value = data.postgresql_schemas.my_schemas.schemas
}