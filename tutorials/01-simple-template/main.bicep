param location string = 'eastus'

@minLength(3)
@maxLength(24)
param storageAccountName string = 'myuniquestorageaccount01'

var storageSku = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'Storage'
  sku: {
    name: storageSku
  }
}

output storageId string = storageAccount.id
