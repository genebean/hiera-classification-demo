# Orchestrator evaluates manifests/site.pp without any facts present before doing a run.
if $clientcert {
  # make sure EVERY node gets your baseline settings
  include profile::base

  # Look in Hiera for the role to be included. This method will only permit a
  # single role to be assigned to a node.
  $_node_role = lookup('role', String, 'first', '')
  unless empty($_node_role) {
    include($_node_role)
  }
}
