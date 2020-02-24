# This role would be made of all the profiles that need to be included to
# make a database server work
class role::database_server {
  include profile::postgresql

  notify { 'role::database_server is being applied to this node': }
}
