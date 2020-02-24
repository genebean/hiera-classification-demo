# Class: profile::postgresql
#
# This is intentionally simple... a real version of this would likely do much
# more to customize PostgreSQL.
#
class profile::postgresql {
  include postgresql::server
}
