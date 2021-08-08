#comment
class opensearch::install {

  archive { "${opensearch::download_target_dir}/${opensearch::artifact_name}":
    ensure       => $opensearch::ensure,
    extract      => true,
    extract_path => $opensearch::extract_dir,
    source       => $opensearch::artifact_full_url,
    creates      => $opensearch::install_dir,
  }

}
