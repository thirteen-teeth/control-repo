node default {
  $pp_role = $trusted['extensions']['pp_role']
  $role = "role::${pp_role}"

  case $pp_role {
    default: {
      if (defined(Type[Class[$role]])) {
        include $role
      }
      else {
        fail("No matching class ${role} found")
      }
    }
    undef, '': {
      fail("${trusted['certname']} does not have a pp_role trusted fact!")
    }
  }
}
