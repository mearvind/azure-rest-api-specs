import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Network.ApplicationGatewayCustomError.customErrorPageUrl,
  "customErrorPageUri",
  "csharp"
);
@@clientName(Microsoft.Network.ApplicationGatewayRedirectConfigurationPropertiesFormat.targetUrl,
  "targetUri",
  "csharp"
);
@@clientName(Microsoft.Network.FirewallPacketCaptureParameters.sasUrl,
  "sasUri",
  "csharp"
);
@@clientName(Microsoft.Network.GetVpnSitesConfigurationRequest.outputBlobSasUrl,
  "outputBlobSasUri",
  "csharp"
);
@@clientName(Microsoft.Network.NetworkVirtualApplianceBootDiagnosticParameters.consoleScreenshotStorageSasUrl,
  "consoleScreenshotStorageSasUri",
  "csharp"
);
@@clientName(Microsoft.Network.NetworkVirtualApplianceBootDiagnosticParameters.serialConsoleStorageSasUrl,
  "serialConsoleStorageSasUri",
  "csharp"
);
@@clientName(Microsoft.Network.P2SVpnConnectionHealth.sasUrl,
  "sasUri",
  "csharp"
);
@@clientName(Microsoft.Network.P2SVpnConnectionHealthRequest.outputBlobSasUrl,
  "outputBlobSasUri",
  "csharp"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayMigrationParameters.resourceUrl,
  "resourceUri",
  "csharp"
);
@@clientName(Microsoft.Network.VpnConnectionPacketCaptureStopParameters.sasUrl,
  "sasUri",
  "csharp"
);
@@clientName(Microsoft.Network.VpnGatewayPacketCaptureStopParameters.sasUrl,
  "sasUri",
  "csharp"
);
@@clientName(Microsoft.Network.VpnPacketCaptureStopParameters.sasUrl,
  "sasUri",
  "csharp"
);
@@clientName(Microsoft.Network.VpnProfileResponse.profileUrl,
  "profileUri",
  "csharp"
);
