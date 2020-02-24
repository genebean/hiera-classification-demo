# Hiera Classification Demo

This repo is a sample control repo, loosely based on [puppetlabs/control-repo](https://github.com/puppetlabs/control-repo), that shows how you can use an `include` in `manifests/site.pp` to automatically apply roles to nodes based on their hiera data.

In this example setup the hiera data is coming from node-specific files. An alternative method would be to extend `hiera.yaml` to include fact-based paths that contain the role to be applied. At work we use [ploperations/classification](https://forge.puppet.com/ploperations/classification) to do exactly that.

## Files in this demo

Here is an abbreviated list of the files in this demo and how they fit into the mix:

```bash
├── Puppetfile
├── data
│   ├── common.yaml
│   └── nodes
│       ├── app-webserver-prod-1.example.com.yaml
│       └── db-server-prod-1.example.com.yaml
├── hiera.yaml
├── manifests
│   └── site.pp
└── site-modules
    ├── profile
    │   └── manifests
    │       ├── base.pp
    │       ├── nginx.pp
    │       └── postgresql.pp
    └── role
        └── manifests
            ├── database_server.pp
            └── webserver.pp
```

1. Each time an agent checks in with a master, `manifests/site.pp` is applied. That manifest causes two things to happen:

   - `site-modules/profile/manifests/base.pp` is applied
   - additional classes are included (applied) by way of a hiera lookup for a key named `classes`

2. If the node checking in is named `app-webserver-prod-1.example.com` the configuration in `hiera.yaml` will cause the classes array in `data/nodes/app-webserver-prod-1.example.com.yaml` to be returned to by the hiera lookup. 
3. The `classes` array in `data/nodes/app-webserver-prod-1.example.com.yaml` contains `role::webserver` so `site-modules/role/manifests/webserver.pp` will be applied to the node.
4. `site-modules/role/manifests/webserver.pp` contains `include profile::nginx` so `site-modules/profile/manifests/nginx.pp` will also be applied.
5. `site-modules/profile/manifests/nginx.pp` contains `include nginx` so the nginx module listed in the `Puppetfile` will be applied to the node.
