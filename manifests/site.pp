node default {
  $pp_role = $trusted['extensions']['pp_role']
  $role = "role::${pp_role}"
  include $role
}
