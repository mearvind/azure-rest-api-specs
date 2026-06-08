import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ManufacturingPlatform.MdsResourceProperties.serviceUrl,
  "serviceUri",
  "csharp"
);
