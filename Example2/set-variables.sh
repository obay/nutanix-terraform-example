#!/bin/bash

PRISM_IP="192.168.1.20" # This is your cluster virtual IP address.
PRISM_USERNAME="admin" # Prism username
PRISM_PASSWORD="supersecretpassword" # Prism password
CLUSTER_NAME="NutanixJeddah" # Nutanix Cluster Name that you want to use.
SUBNET_NAME="LAN" # Subnet / vLAN name that will be connected to the NIC when the VM is created
WINDOWS_STD_SERVER_IMAGE_NAME="Windows Server 2019 with SQL Server Golden Image" # The name of the QCOW2 image/disk that will be used as a disk for the VM

# environment variables starting wiith TF_VAR are picked up by Terraform as variables to be used by the configuration
export TF_VAR_prism_endpoint=$PRISM_IP
export TF_VAR_prism_username=$PRISM_USERNAME
export TF_VAR_prism_password=$PRISM_PASSWORD

# The following REST API call obtains the cluster UUID.
# You can get this same detail from Prism -> Settings --> Cluster Details --> CLUSTER UUID
ENTITY_TYPE="clusters"
REQUEST_DATA='{ "kind": "cluster" }'
ENTITY_NAME=$CLUSTER_NAME
JQ_FILTER=".entities[] | select(.spec.name==\"$ENTITY_NAME\").metadata.uuid"
export TF_VAR_cluster_id=`curl -s --insecure --user "$PRISM_USERNAME:$PRISM_PASSWORD" --request POST "https://$PRISM_IP:9440/api/nutanix/v3/$ENTITY_TYPE/list" --header 'Content-Type: application/json' --data-raw "$REQUEST_DATA" | jq -r "$JQ_FILTER"`

# This is the UUID of the Subnet that will be used to deploy the VM
ENTITY_TYPE="subnets"
REQUEST_DATA='{ "kind": "subnet" }'
ENTITY_NAME=$SUBNET_NAME
JQ_FILTER=".entities[] | select(.spec.name==\"$ENTITY_NAME\").metadata.uuid"
export TF_VAR_Subnet_UUID=`curl -s --insecure --user "$PRISM_USERNAME:$PRISM_PASSWORD" --request POST "https://$PRISM_IP:9440/api/nutanix/v3/$ENTITY_TYPE/list" --header 'Content-Type: application/json' --data-raw "$REQUEST_DATA" | jq -r "$JQ_FILTER"`

# This is the QCOW2 image UUID that will be used as the disk
ENTITY_TYPE="images"
REQUEST_DATA='{ "kind": "image" }'
ENTITY_NAME=$WINDOWS_STD_SERVER_IMAGE_NAME
JQ_FILTER=".entities[] | select(.spec.name==\"$ENTITY_NAME\").metadata.uuid"
export TF_VAR_Windows_Server_2019_Image_UUID=`curl -s --insecure --user "$PRISM_USERNAME:$PRISM_PASSWORD" --request POST "https://$PRISM_IP:9440/api/nutanix/v3/$ENTITY_TYPE/list" --header 'Content-Type: application/json' --data-raw "$REQUEST_DATA" | jq -r "$JQ_FILTER"`

# Windows answer file encoded ni base64.
export TF_VAR_windows_server_unattend_xml=`base64 server_autoattend.xml`

terraform fmt
terraform validate
terraform init
