param name string
param location string = ''
param appServicePlanId string 
param storageAccountName string = ''
param tags object = {}

@secure()
param appSettings object = {}
param serviceName string = 'function'
// param applicationInsightsName string = ''
param runtimeName string
param runtimeVersion string
param clientKey string
param azureOpenAIName string = ''
param azureCognitiveSearchName string = ''
// param formRecognizerName string = ''
// param contentSafetyName string = ''


module function '../core/host/functions.bicep' = {
  name: '${name}-app-module'
  params: {
    name: name
    location: location
    tags: union(tags, { 'azd-service-name': serviceName })
    appServicePlanId: appServicePlanId
    storageAccountName: storageAccountName
    runtimeName: runtimeName
    runtimeVersion: runtimeVersion
    appSettings: union(appSettings, {
      // AzureWebJobsStorage: 'DefaultEndpointsProtocol=https;AccountName=${storage.name};AccountKey=${storage.listKeys().keys[0].value};EndpointSuffix=${environment().suffixes.storage}'
      // AZURE_BLOB_ACCOUNT_KEY: storage.listKeys().keys[0].value
      // APPINSIGHTS_INSTRUMENTATIONKEY: applicationInsights.properties.InstrumentationKey
      AZURE_OPENAI_KEY: openAI.listKeys().key1
      AZURE_SEARCH_KEY: search.listAdminKeys().primaryKey
      // AZURE_FORM_RECOGNIZER_KEY: formrecognizer.listKeys().key1
      // AZURE_CONTENT_SAFETY_KEY: ContentSafety.listKeys().key1
    })
  }
}

// resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
//   name: storageAccountName
// }

// resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = if (!empty(applicationInsightsName)) {
//   name: applicationInsightsName
// }

resource openAI 'Microsoft.CognitiveServices/accounts@2023-05-01' existing = {
  name: azureOpenAIName
}

resource search 'Microsoft.Search/searchServices@2021-04-01-preview' existing = {
  name: azureCognitiveSearchName
}

// resource formrecognizer 'Microsoft.CognitiveServices/accounts@2022-12-01' existing = {
//   name: formRecognizerName
// }

// resource ContentSafety 'Microsoft.CognitiveServices/accounts@2022-03-01' existing = {
//   name: contentSafetyName
// }

resource functionNameDefaultClientKey 'Microsoft.Web/sites/host/functionKeys@2018-11-01' = {
  name: '${name}/default/clientKey'
  properties: {
    name: 'ClientKey'
    value: clientKey
  }
  dependsOn: [
    function
    waitFunctionDeploymentSection
  ]
}

resource waitFunctionDeploymentSection 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  kind: 'AzurePowerShell'
  name: 'WaitFunctionDeploymentSection'
  location: location
  properties: {
    azPowerShellVersion: '3.0'
    scriptContent: 'start-sleep -Seconds 300'
    cleanupPreference: 'Always'
    retentionInterval: 'PT1H'
  }
  dependsOn: [
    function
  ]
}
