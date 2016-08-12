..
 This work is licensed under a Creative Commons Attribution 3.0 Unported
 License.

 http://creativecommons.org/licenses/by/3.0/legalcode

===========================================
Check Node Resource before Creating Cluster
===========================================

https://blueprints.launchpad.net/sahara/+spec/resource-check-before-cluster-creation

This blueprint aims to implement node resource checking before cluster
creating.

Problem description
===================

Currently we do not check the resources of each node whether they can satisfy
the requirements of the roles assigned on it. This can cause issues. For
example, the roles on a node may need 8GB memory/20GB disk, while we only have
4GB memory, or 10GB disk size on this node or volume. This may cause the
cluster creation to fail but users do not know why if they do not (or cannot)
login to the cluster and check the plugin-specific debug info.


Proposed change
===============

We can add a resource-checking phase before cluster infrastructuring phase, to
minimize the possibility of this failure. To achieve this, we need to register
the OS sytem and roles' resource requirements, and check whether the flavor and
volumes allocated can meet them. If not, involved exceptions can be thrown and
users can know the reason, or cluster creating can go on. At the first step,
we can just set it as a barrier, which means we do not promise all clusters
passing this phase will never have resource issues in the future. Instead, it
just helps users to avoid the likely problems in most cases.

Further more, we can add this checking at the node-group-template creating and
cluster-template creating time. At those stages, we can collect enough
information whether the node group will meet the requirements of the roles
included in it. Why do we still need to validate this on cluster creating?
Because flavor can be overridden at anytime, so the gating before cluster
provisioning is still necessary.

We also need to let users know the resources they need to retain for the
services in the node groups when editing. As the users do not have the node
group ID yet, this API can only be added in plugin APIs. The client will call
this API to get a list of resources required by roles for the specific plugin.
And the front end (Horizon) will calculate the sum amount of roles in the node
group in editing, and show it to the users, so that users can correctly setup
the template by hints.

We plan to implement this feature as below:

* In cluster creating phase (service.api._cluster_create), add a step
  check_cluster_resources, which will call resources.check_cluster_resources
  method, to do the resource checking. In cluster scaling phase, we also do the
  similar check.
* Add a file service/resources.py, and put check_cluster_resources method in
  it. It will get the flavor info by flavor id set in cluster node groups, and
  check whether the flavor and other resources meet the cluster requirements.
* For cluster-template and node-group-template creating phase, also add a step
  check_ct_resources and check_ngt_resources to do the similar functionality.
  They will call resources.check_ct_resources and resources.check_ngt_resources
  respectly.
* Add an API called get_plugin_roles_resources to api/v10.py, this API will
  give a list of resources required by service roles for the plugin. Changes
  need to be done in Horizon to utilize this API.
  The API endpoint will be::

    GET http://sahara/v1.0/{tenant_id}/plugins/{plugin_name}/{version}/role-resources

  Example:
    Request::

      GET http://sahara/v1.0/775181/plugins/cdh/5.4.0/role-resources

    Response::

      HTTP/1.1 200 OK
      Content-Type: application/json

      {
        "role-resources": [
            {
                "role": "OS",
                "disk": 0,
                "memory": 300
            },
            {
                "role": "HDFS_NAMENODE",
                "disk": 0,
                "memory": 600
            },
            {
                "role": "HDFS_DATANODE",
                "disk": 10,
                "memory": 600
            },
            {
                "role": "HDFS_SECONDARYNAMENODE",
                "disk": 0,
                "memory": 300
            }
        ]
      }

* In plugins.provisioning.ProvisioningPluginBase, add an abstract method
  check_ng_resources to compare the resources with the node group requirements.
* In each plugin, implement this method individually (as well as each version).
  If not implemented, we just skip this step and return success. The method
  check_ng_resources will do:
  + Accept augments of a resources dictionary and node_group.
  + Return True if resources can meet node_group requirements, else return
  False.
* We take cdh plugin as example. We initialize a list of required resources for
  each role and system OS, which will include the memory size and disk size.
  We compare the resources and the sum of required resources of all roles and
  OS from the node setup. The default required resource for each role is 0,
  if not set.

Example of check_ng_resources for CDH 5.4.0 plugin::

  class PluginUtilsV540(pu.AbstractPluginUtils):
      # The number here may not be accurate, and we do not list all processes.
      # Each tuple stands for mem in MB and disk in GB.
      ROLE_RESOURCES = {
          'OS': (300, 0),
          'HDFS_NAMENODE': (600, 0),
          'HDFS_DATANODE': (600, 10),
          'HDFS_SECONDARYNAMENODE': (300, 0)
      }

      def check_ng_resources(self, resources, node_group):
          res = [0, 0]

          # Add OS resources first.
          if 'OS' in self.ROLE_RESOURCES.keys():
              res[0] += self.ROLE_RESOURCES['OS'][0]
              res[1] += self.ROLE_RESOURCES['OS'][1]

          for proc in node_group.node_processes:
              if proc in self.ROLE_RESOURCES.keys():
                  res[0] += self.ROLE_RESOURCES[proc][0]
                  res[1] += self.ROLE_RESOURCES[proc][1]
          if resources['volumes'] > 0:
              disksize = resources['volumes'] * resources['volume_size']
          else:
              disksize = localdisk_size
          if resources['ram'] < res[0] or disksize < res[1]:
              return False
          return True


.. note::
  The implementation of check_ng_resources given above is not the final
  solution. More optimal or reasonable ways can be applied in the future.


Alternatives
------------

None.

Data model impact
-----------------

None.

REST API impact
---------------

Add one API to get the role resource requirements of a specific plugin.

Other end user impact
---------------------

None.

Deployer impact
---------------

None.

Developer impact
----------------

None.

Sahara-image-elements impact
----------------------------

None.

Sahara-dashboard / Horizon impact
---------------------------------

Horizon needs to be able to call the API to get the role resources list, and
calculate the sum for current node group template in editting, and show the
result to users.

Implementation
==============

Assignee(s)
-----------

Primary assignee:
  Ken Chen

Work Items
----------

We will change the according files in api, service and plugins directories. And
we will add test cases for the methods added.
We will also change the Horizon codes to add the API calling and calculating
part.


Dependencies
============

None.


Testing
=======

* Unit tests will be added to test the added methods.

Documentation Impact
====================

The documentation needs to be updated with information about this feature.


References
==========

N/A
