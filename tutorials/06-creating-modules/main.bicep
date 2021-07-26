targetScope = 'subscription'

// defaults
param deployStorage bool = true

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

// output
output storageAccountId string = storageAccount.outputs.id
output storageAccountName string = storageAccount.outputs.name
output storageAccountEndpoint string = storageAccount.outputs.endpoint
output containerIds array = storageAccount.outputs.containerIds
