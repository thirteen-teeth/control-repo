node default {
  $pp_role = $trusted['extensions']['pp_role']
  $role = "role::${pp_role}"

  if $role {
    include $role
  } else {
    fail('No pp_role is set.')
  }
}
