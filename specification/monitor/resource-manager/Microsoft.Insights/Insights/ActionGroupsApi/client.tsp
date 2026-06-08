import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(ActionGroupsApi.AzureFunctionReceiver.httpTriggerUrl,
  "httpTriggerUri",
  "csharp"
);
@@clientName(ActionGroupsApi.LogicAppReceiver.callbackUrl,
  "callbackUri",
  "csharp"
);
