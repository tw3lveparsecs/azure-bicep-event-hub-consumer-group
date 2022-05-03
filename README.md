# Event Hub Consumer Group
The module will create consumer groups within an existing event hub. 

```bicep
param deploymentName string = 'csgroup${utcNow()}'

module consumerGroups 'consumergroup.bicep' = {
  name: deploymentName
  params: {
    eventHubNamespaceName: 'MyExistingEventHubNamespace'
    eventHubName: 'MyExistingEventHub'
    consumerGroups: [
      {
        consumerGroupName: 'ConsumerGroupName1'
      }
      {
        consumerGroupName: 'ConsumerGroupName2'
      }
    ]
  }
}
```