---
title: Document
layout: page
sidenav: false
---
# System Components

## Infrastructure

>Demonstration site uses AWS, plans include supporting Azure/GCP Kubernetes Services

* AWS ELB - Load balancers to the Kubernetes internal load balancer (Traefik)
* AWS EKS - Managed Kubernetes service enabling deployment of CKAN Instances and associated services (e.g. CKAN Harvest).
* AWS S3 - Used to store assets used on CKAN Instances such as Group logo images, CKAN Site images, etc. Optionally, it can also be enabled to be used as a CKAN filestore, if any portal requires the CKAN FileStore component.
* AWS Elasticache - Managed redis cluster providing the redis service required for CKAN versions 2.7 and above.
* AWS RDS - Managed PostgreSQL service providing database backend for CKAN and CKAN DataStore instances

## Kubernetes
* Rancher - Management UI for kubernetes provisioning and management
* Traefik - Internal cluster load balancer with Letsencrypt automated SSL certificates support
* CCA - CKAN Cloud API providing the necessary functionalities to create, manage and delete CKAN Instances. The following CCA features enable fully automated CKAN Instance management:
  * CKAN versions support - Manage CKAN dependencies (SOLR schema, database schema, etc.) for specific versions
  * CKAN SOLR schemas - Manage available SOLR schemas available when provisioning CKAN Instances
  * CKAN database operations - Create, update, delete CKAN and CKAN DataStore database objects
  * CKAN SOLR cores/indexes - Create, update, delete SOLR cores/indexes
  * CKAN Instance scaffolding - Generate a fully functional CKAN Instance with all required services and configuration
  * CKAN Instance management - Manage CKAN portal admins, theme options and harvester configuration
  * CCA UI - Web-based and CLI interface for interfacing with the Multi-tenant CKAN Platform
* CKAN DataPusher - Service which loads data from structured dataset resources to the datastore
* SOLRCloud - SOLRCloud is a clustered version of Apache SOLR which is used by CKAN as a search index.

## CKAN Cloud API
The CCA UI functions as the main interface for ‘CKAN Portal Instance Admins’ to the platform. It provides access to all of the features of CCA, given permissions, enabling users to create CKAN Instances and manage existing ones. Users logged-on to the CCA UI shall see a list of instances that they manage and, having the right permissions, would be able to create more instances.

## Docker Containers
 CKAN Instances shall use Docker container technology and by default contain all of the default extensions defined by Data.gov - ‘data.gov base CKAN Instance docker image’. CKAN Instance Admins shall have the ability to enable and configure additional extensions, if Data.gov wishes to allow this.

A white-label theme with support for changing logos and theme colors shall be developed which will be part of Data.gov’s base CKAN Instance docker image. The theme will allow ‘CKAN Portal Instance Admins’ to manage the logo and colors of their CKAN portal. It will also be possible to override the default white-label theme if Data.gov would allow this on the platform. Custom domain names will be supported along with flexible themes to facilitate branding for each instance.

## Authentication/Authorization
To create, manage and delete CKAN Instances within the multi-tenant CKAN platform, a ‘CKAN Portal Instance Admin’ role exists within CCA, which controls who has permissions to create, manage and delete CKAN Instances on the platform. A ‘CKAN multi-tenant platform super-admin’ can create, update and delete permissions for ‘CKAN Portal Instance Admins’. 

The ‘Platform Admin’ role will be able to manage deployed environments to ensure ongoing maintenance of platform components. This role shall be an AWS IAM role. All specific configurations of deployed environments shall be version controlled and managed as code.

## [Rancher](https://releases.rancher.com/documents/security/latest/Rancher_Benchmark_Assessment.pdf)

### Role Based Access
RKE installs with RBAC enabled by default. If you’re only using RKE, or any other standalone Kubernetes deployment, you’re responsible for configuring the accounts, roles, and bindings to secure your cluster.
If you’re using Rancher, it not only installs secure clusters, but it proxies all communication to those clusters through the Rancher server. Rancher plugs into a number of backend authentication providers, such as Active Directory, LDAP, SAML, Github, and more. When connected in this way, Rancher enables you to extend your existing corporate authentication out to all of the Kubernetes clusters under Rancher’s umbrella, no matter where they’re running.
Rancher enables roles at the global, cluster, and project level, and it makes it possible for administrators to define roles in a single place and apply them to all clusters.
This combination of RBAC-by-default and strong controls for authentication and authorization means that from the moment you deploy a cluster with Rancher or RKE, that cluster is secure.

### Namespaces
Because of the special way that Kubernetes treats the default namespace, I don’t recommend that you use it. Instead, create a namespace for each of your applications, defining them as logical groups.

Rancher defines an additional layer of abstraction called a Project. A Project is a collection of namespaces, onto which roles can be mapped. Users with access to one Project cannot see any or interact with any workload running in another Project to which they do not have access. This effectively creates single-cluster multi-tenancy.
Using Projects makes it easier for administrators to grant access to multiple namespaces within a single cluster. It minimizes duplicated configuration and reduces human error.

### Separate Sensitive Workloads
Kubernetes allows you to set taints and tolerations, which control where a Pod might be deployed.

Rancher also lets you control scheduling of workloads through Kubernetes labels. In addition to taints and tolerations, when deploying a workload you can set the labels that a host must have, should have, or can have for a Pod to land there. You can also schedule workloads to a specific node if your environment is that static.

### Secure Cloud Metadata Access
The only place this vulnerability might exist would be in a hosted Kubernetes service such as GKE. If you deploy RKE onto bare metal or cloud compute instances, either directly or via Rancher, you’ll end up with a cluster that cannot have credentials leaked via the cloud provider’s metadata API.

If you’re using GKE, I recommend that you activate this feature to prevent any credentials from leaking via the metadata service.

### Create and Define Cluster Network Policies
RKE clusters, deployed directly or by Rancher, use Canal by default, although you can also choose Calico or Flannel. Both Canal and Calico include support for NetworkPolicies. Rancher-deployed clusters, when using Canal as a network provider, also support ProjectNetworkPolicies. When activated, workloads can speak to other workloads within their Project, and the System project, which includes cluster-wide components such as ingress controllers, can communicate with all projects.

Earlier versions of Rancher enabled ProjectNetworkPolicies by default, but this created confusion for some users who weren’t aware of the extra security. To provide the best experience across the entire user base, this feature is now off by default but can be easily activated at launch time or later if you change your mind.

### Run a Cluster-wide Pod Security Policy
A Pod Security Policy (PSP) controls what capabilities and configuration Pods must have in order to run within your cluster. For example, you can block privileged mode, host networking, or containers running as root. When installing a cluster via Rancher or RKE, you choose if you want a restricted PSP enabled by default. If you choose to enable it, your cluster will immediately enforce strong limitations on the workload permissions.
The restricted and unrestricted PSPs are the same within RKE and Rancher, so what they activate at install is identical. Rancher allows an unlimited number of additional PSP templates, all handled at the global level. Administrators define PSPs and then apply them to every cluster that Rancher manages. This, like the RBAC configuration discussed earlier, keeps security configuration in a single place and dramatically simplifies the configuration and application of the policies.

### Harden Node Security
This isn’t a Kubernetes-specific suggestion, but it’s a good general policy. Anything that interacts with traffic that you don’t control, such as user traffic hitting an application running within Kubernetes, should be running on nodes with a small attack surface. Disable and uninstall unneeded services. Restrict root access via SSH and require a password for sudo. Use passphrases on SSH keys, or use 2FA, U2F keys, or a service like Krypton to bind keys to devices that your users have. These are examples of basic, standard configurations for secure systems.

Rancher requires nothing on the host beyond a supported version of Docker. RKE requires nothing but SSH access, and it will install the latest version of Docker supported by Kubernetes before continuing to install Kubernetes itself.

If you want to reduce the attack surface even more, take a look at RancherOS, a lightweight Linux operating system that runs all processes as Docker containers. The System Docker runs only the smallest number of processes necessary to provide access and run an instance of Docker in userspace for the actual workloads. Both lightweight and secure, RancherOS is what an operating system should be secure by default.

### Turn on Audit Logging
The Rancher Server runs inside of an RKE cluster, so in addition to the Kubernetes audit logging, it’s important to activate audit logging for API calls to the server itself. This log will show all activities that users execute to any cluster, including what happened, who did it, when they did it, and what cluster they did it to.

It’s also important to ship these logs off of the servers in question. Rancher connects to Splunk, Elasticsearch, Fluentd, Kafka, or any syslog endpoint, and from these you can generate dashboards and alerts for suspicious activity.

Information on enabling audit logging for the Rancher Server is available in our documentation.

### Rancher Capabilities
* Clusters and Node Management - Rancher supports the ability to add your k8s cluster hosted by a cloud provider, create one using Rancher Kubernetes Engine (RKE), or simply by importing an existing cluster of your own.
* Cloud Providers - Full integrated experience of creating and managing your nodes of your k8s cluster from one of the major cloud providers
  * Google Kubernetes Engine (GKE)
  * Azure Container Service (AKS)
  * Amazon's Elastic Kubernetes Service (EKS)
* Rancher Kubernetes Engine (RKE) - Allow you to create a Rancher supported k8s cluster anywhere, on any cloud or private infrastructure. You will be able to scale your hosts for your k8s deployment as you see fit through Rancher.
* Import - Import any existing k8s cluster. Only v1.8+.
* Authentication - Support for local auth, Github, and ActiveDirectory. After installing Rancher, you will be prompted to change your admin password.
* User Management - Rancher will support two default user types (admin and user) with respective default permissions. A custom user type will also be supported.
  * Admin - Full global permissions (super admin)
  * Standard User - standard user permissions including:
    * only able to manage their own clusters including namespaces, user, projects, etc.
    * can view catalogs and node drivers, but cannot manage them.
    * cannot create roles but can assign them to users invited to their cluster and/or projects.
  * Custom - custom user type role that you can use to define your own user type
* Role Based Access Control (RBAC) - Rancher allows you to create your own global cluster roles that can be easily assigned to any users to manage k8s clusters and projects. Rancher includes all out-of-box k8s roles and the ability to customize your own roles. Each custom role can be assigned to be assignable at a global, cluster, or project level.
* Project and Namespace Management - Users can create namespaces and assign them to projects. Projects are a new Rancher concepts that allows you to group a set of namespaces and assign a set of user permissions on those namespaces.
* Workload UX - Rancher is introducing a new Workload UX to create and manage their k8s workloads. 

#### Supported workload features:
* Ability to create workloads that will automatically translate into appropriate k8s resources (Pods, StatefulSets, Deployments, DaemonSets, etc.). Rancher will also automatically create an appropriate k8s service (NodePort, LoadBalance Service, ClusterIP) based on how the user wants to publish their ports. Rancher does the heavy lifting and translation for you. You do not need to know or understand k8s constructs before using this.
* Ability to create and use Ingress.
* Ability to generate DNS records for k8s services or external IP addresses.
* Ability to add authenticated registries
* Ability to manage k8s secrets
* Ability to manage your SSL certificates for Ingress.
* Ability to generate a public endpoint based on ports exposed by NodePort Services, LoadBalancer Services, Ingress, and HostPorts.
* Rancher CLI - CLI support for all Rancher 2.0 feature set.
* Pod Security Policies - Allow users to create their own pod security policy or policies that can be applied to roles.
* Catalog Support for Helm - Helm charts will be supported in the updated 2.0 catalog.
* HA and SSL support for Rancher server
* Rancher can be installed via docker run
* Rancher can be installed into an existing k8s cluster. This option will enable HA support as Rancher HA will be managed by the external k8s cluster.
##### Alert Management
* Disabled by default. Enabling will install Prometheus AlertManager
* Support for basic out-of-box alert conditions (final list TBD)
* Support for following notifiers (Slack, Email, PagerDuty, Webhooks)
* Support for alert management including creating, deleting, disabling, and muting alerts
* Support for out-of-box system alerts (system services, networking, etc.) that can be configured with a notifier
* Support for selector labels on cluster and project-wide resources (pod, nodes, etc.)
* Support for "Test" notifier feature
* No support for "management" plane alerts (i.e Cluster 1 went down)
##### Logging
* Disabled by default. Enabling will install Fluentd
* Support for ability to configure cluster-wide logging of stdout/err of containers and workloads
* Support for ability to configure project-wide logging of stdout/err of containers and workloads
* Support for ability to configure workload logging of a specific directory
* Support for following Log Targets
* Rancher embedded logging - Experimental and used for testing
* ElasticSearch
* Splunk
* Syslog
* Kafka
* CI/CD Pipelines - A simple integrated pipeline feature that allows users to create pipelines within projects for CI/CD
* Disabled by default. Enabling will install Jenkins
* Support for GitHub integration initially
* Support for creating pipelines through UI wizard, importing a YAML configuration file, or reading it the pipeline YAML directly from a GitHub project.
* Support for creating pipelines with multiple stages and steps within a stage.
* Support for automatic detection of language used to default to a container image with corresponding compiler, if required.
* Integrated with registries added into projects

## [Open Policy Agent](https://www.openpolicyagent.org/)
KUBERNETES POLICY EXAMPLES

### Container Best Practices:
* Restrict External Load Balancers – Prevent unauthorized external access 
* Block Container Privileged Mode – Prevent containers from running in privileged mode
* Block host/path ingress conflicts – Ensure no two ingresses are ever configured with the same host and/or overlapping paths
* Block Latest Image Tag – Ensure images do not use the “latest” tag
* Naming Safety – Require all resource names to match one of a list of regular expressions
* Repository Safety – Ensure images are pulled from only trusted registries
* Label Safety – Require all resources to include specified labels
* Annotation Safety – Require all resources to include specified annotations
* Require Container Resource Requirements – Containers must have CPU and memory resource requests and limits set in the deployment manifest
* Image Pull Policy – ensure the latest image with that tag
* Read-only root filesystem
* Require encrypted storage volumes
* Prevent workloads from being placed on master nodes

### Security Related:
* Segment workloads to namespaces/clusters (eg. PCI cluster, department namespace, multitenant namespace)
* Restrict subnets that developers can open egress traffic to (limitations on egress generally)
* Ensure people don’t add ingresses to the wrong ingress class and expose things to the internet that they shouldn’t
* Every application exposed externally must use an approved domain name
* Every resource must include data security label
* Requirements for images to have been scanned    
* Requirements for images to have been signed off on or come from CI CD
* Developers must not modify selectors, or labels referred to by selectors, after creation
* Services in namespace X should have AWS SSL annotation added

### Governance, Storage and Operations Related:
* Stateful deployments must use ‘recreate’ update strategy
* Two ingresses in different namespaces must not have the same hostname
* Nodes with business critical data must have storage reclaim policy set to retain
* Don't create 2nd build until 1st deployed (since deployment takes time)
* Define health check during deploy as combination of data from different sources
* Only on-call engineers can connect to production clusters, namespaces, data
* Restrict deployments to clusters based on tags 
* Restrict external LBs (example: limit the creation of Service type: LoadBalancers only in namespaces with a specific annotation (ie: ingress controllers namespaces)
* Allow deployments only to EU or worldwide clusters based on tags 
* Limit the creation of Service type: LoadBalancers with parameters 