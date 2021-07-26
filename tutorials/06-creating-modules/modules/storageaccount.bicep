// defaults
param currentYear string = utcNow('yyyy')
param location string = resourceGroup().location
param namePrefix string = 'myunique'
param globalRedundancy bool = true

// vars
var storageAccountNameFull = '${namePrefix}${uniqueString(resourceGroup().id)}'
var storageAccountName = take(storageAccountNameFull, 24)

// main
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = if(currentYear == '2021') {
  name: storageAccountName
  location: location
  kind: 'Storage'
  sku: {
    name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS'
  }
}

module container './container.bicep' = {
  name: 'container'
  params: {
    storageAccountName: storageAccount.name
  }
}

// output
output id string  = storageAccount.id
output name string = storageAccount.name
output endpoint string = storageAccount.properties.primaryEndpoints.blob
output containerIds array = container.outputs.containerIds
