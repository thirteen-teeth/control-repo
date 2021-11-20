#comment!
define opensearch::plugin (
  Stdlib::HTTPUrl $url,
) {
  $exe = "${opensearch::install_dir}/bin/opensearch-plugin"
  exec { "${title} plugin":
    command => "${exe} install -b ${url}",
    unless  => "${exe} list | grep ${title}",
  }
}
