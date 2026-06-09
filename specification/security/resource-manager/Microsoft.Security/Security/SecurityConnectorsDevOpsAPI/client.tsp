import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(
  SecurityConnectorsDevOpsAPI.AzureDevOpsRepositoryProperties.repoUrl,
  "repoUri",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.GitHubOwnerProperties.ownerUrl,
  "ownerUri",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.GitHubRepositoryProperties.repoUrl,
  "repoUri",
  "csharp"
);
