# Orchestrator evaluates manifests/site.pp without any facts present before doing a run.
if $clientcert {
  # make sure EVERY node gets your baseline settings
  include profile::base

  # Look in Hiera for roles to be included. This method will permit multiple roles
  # to be assigned to a single node.
  include(lookup('classes', Array[String], 'unique', []))

  # This is an alternate method that would only permit a single role to be assigned
  # include(lookup('role', String, 'first', undef))
}
