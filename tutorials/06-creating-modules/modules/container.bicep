// defaults
param containerNames array = [
  'dogs'
  'cats'
  'fish'
]

// params
param storageAccountName string

// main
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: storageAccountName
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [ for (name, index) in containerNames: {
  name: '${storageAccount.name}/default/${name}-${index + 1}'
}]

// output
output containerIds array = [for i in range(0, length(containerNames)): blob[i].id]
