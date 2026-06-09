import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(
  ModelInference.ChatMessageAudioContentItem.audioUrl,
  "audioUri",
  "csharp"
);
@@clientName(
  ModelInference.ChatMessageImageContentItem.imageUrl,
  "imageUri",
  "csharp"
);
