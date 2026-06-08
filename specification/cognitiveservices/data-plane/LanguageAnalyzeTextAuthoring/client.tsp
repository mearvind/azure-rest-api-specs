import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Language.Text.Authoring.TextAnalysisAuthoringExportProjectJobState.resultUrl,
  "resultUri",
  "csharp"
);
