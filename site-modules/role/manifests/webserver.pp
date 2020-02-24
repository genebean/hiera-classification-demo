# This role would be made of all the profiles that need to be included to
# make a web server work
class role::webserver {
  include profile::nginx

  notify { 'role::webserver is being applied to this node': }
}
