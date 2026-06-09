import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(
  Products.ProductDetails.universalAmendmentUrl,
  "universalAmendmentUri",
  "csharp"
);
