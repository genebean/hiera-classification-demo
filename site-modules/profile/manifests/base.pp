# Settings common to all nodes. Any parameters being passed to this class
# must come from Hiera. This class is included in site.pp so it *will* be
# included on every node.
#
# @summary Settings common to all nodes
#
# @param [Optional[String[1]]] puppet_agent_version
#   Allows pinning a node's puppet agent version.
#
class profile::base (
  Optional[String[1]] $puppet_agent_version = undef,
){
  class { 'puppet_agent':
    package_version => $puppet_agent_version,
  }
}
