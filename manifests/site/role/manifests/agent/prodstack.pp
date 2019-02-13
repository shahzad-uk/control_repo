class role::agent::prodstack {
  include profile::prodserver::proddb
  include profile::prodserver::webprod
}