#comment
class opensearch::plugins {

  $plugins_hash = $opensearch::plugins_hash
  $plugins_hash.each |$plugin| {
    create_resources(opensearch::plugin, $plugins_hash)
  }

}
