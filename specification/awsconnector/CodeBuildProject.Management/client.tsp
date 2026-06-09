import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(
  Microsoft.AwsConnector.BuildStatusConfig.targetUrl,
  "targetUri",
  "csharp"
);
@@clientName(
  Microsoft.AwsConnector.ProjectBadge.badgeRequestUrl,
  "badgeRequestUri",
  "csharp"
);
@@clientName(Microsoft.AwsConnector.Webhook.payloadUrl, "payloadUri", "csharp");
