targetScope = 'subscription'

// defaults
param deployStorage bool = true
param deployments array = [
  'dev'
  'test'
]

// params
param resourceGroupName string
param storageAccountPrefix string

// main
module storageAccount './modules/storageaccount.bicep' = if(deployStorage) {
  name: 'storageAccount'
  scope: resourceGroup(resourceGroupName)
  params: {
    namePrefix: storageAccountPrefix
  }
}

module deploymentStorageAccounts './modules/storageaccount.bicep' = [ for item in deployments: {
  name: '${item}storageAccount'
  scope: resourceGroup(resourceGroupName)
  params: {
    namePrefix: '${storageAccountPrefix}${item}'
  }
}]

// output
output storageAccountId string = storageAccount.outputs.id
output storageAccountName string = storageAccount.outputs.name
output storageAccountEndpoint string = storageAccount.outputs.endpoint
output containerIds array = storageAccount.outputs.containerIds

output deploymentNames array = [ for i in range(0, length(deployments)): deploymentStorageAccounts[i].outputs.name ]
