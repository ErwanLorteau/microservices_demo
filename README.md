# Steps performed

All mandatory steps No optionnal steps

# Report

Available at the root of the git repo

# Deployment

Simply follow the instrution provided in the original readme of the microservice demo, with a single change You need a gcloud account with enhanced quota (more ip adress range, and 1300gb) to deploy on 4 nodes with e2 instances as stated in the guidelines (no autopilot)

For the minimal configuration file, it is available in release/kubernetes-manifests.yaml The original deployment file is rename with "old" appended to it The one with the two frontend service and a 75-25 splitting is rename with with "canary" appended

# Load generator

Use the following script, the VM will run a preconfigured instance of locust with the correct locust file, on debian10. Once the vm are running, go to the gcloud panel and use the external ip to access it on port 8089 to acces locust GUI

# Scripts

The terraform script is available in terraform/terraform_vm_script.tf Set the "count" option to suit the number of vm you want. Beware, it does not delete the VM afterwards

# Grafana

Install heml, grafana and prometheus directly on the shell console, then link them as datasource All the metric used for the chart are provided in the report, just copy them

# Performance evaluation

Nothing much to say, all on the report

# Canary

Apply the canary config file, the virtualservice file, and the decisionrule inside /release to use it. some details on how to implement itios etc are provided on the report

# Contributor/group

Erwan Lorteau
