az deployment group create --resource-group ODL-azure-1233019 --name rollout01 \
            --template-file template.json --parameters @parameters.json


# az account set --subscription fa31592b-96b0-4bad-bcd1-439a3555fc9c
# az aks get-credentials --resource-group ODL-azure-1233019 --name demo-aks --overwrite-existing