@description('Existing Event Hub namespace name.')
param eventHubNamespaceName string

@description('Existing Event Hub name.')
param eventHubName string

@description('Consumer groups to assoicate with Event Hub.')
@metadata({
  consumerGroupName: 'Consumer Group name.'
  userMetadata: 'Placeholder to store user-defined string data with maximum length 1024, e.g. it can be used to store descriptive data, such as list of teams and their contact information.'
})
param consumerGroups array = []

resource namespace 'Microsoft.EventHub/namespaces@2021-11-01' existing = {
  name: eventHubNamespaceName

  resource eventHub 'eventhubs@2021-11-01' existing = {
    name: eventHubName
  }
}

resource eventHubConsumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2021-11-01' = [for consumerGroup in consumerGroups: {
  parent: namespace::eventHub
  name: consumerGroup.consumerGroupName
  properties: {
    userMetadata: contains(consumerGroup, 'userMetadata') ? consumerGroup.userMetadata : null
  }
}]
