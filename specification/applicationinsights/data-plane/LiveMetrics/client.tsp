import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Azure.Monitor.LiveMetrics.Request.Url, "Uri", "csharp");
