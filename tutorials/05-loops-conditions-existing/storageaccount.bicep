param currentYear string = utcNow('yyyy')

param location string = resourceGroup().location
param namePrefix string = 'myunique'
param globalRedundancy bool = true

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = if(currentYear == '2021') {
  name: storageAccountName
  location: location
  kind: 'Storage'
  sku: {
    name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS'
  }
}

output storageId string  = storageAccount.id
output storageName string = storageAccount.name
output storageEndpoint string = storageAccount.properties.primaryEndpoints.blob
