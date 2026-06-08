import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

// Official Name: Azure Health Data Services de-identification service
@useAuth(AadToken)
@service(#{ title: "Azure Health Data Services de-identification service" })
@server(
  "{endpoint}",
  "De-identification Service service endpoint",
  {
    @doc("Url of your De-identification Service.")
    endpoint: url,
  }
)
@versioned(HealthDataAIServices.DeidServices.Versions)
namespace HealthDataAIServices.DeidServices;

@doc("The Azure Active Directory OAuth2 Flow")
model AadToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode;
      #suppress "@azure-tools/typespec-client-generator-core/no-url-suffix" "OAuth2 flow metadata uses the standards-defined URL field and has no generated C# client property to rename."
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
      #suppress "@azure-tools/typespec-client-generator-core/no-url-suffix" "OAuth2 flow metadata uses the standards-defined URL field and has no generated C# client property to rename."
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token";
      scopes: ["https://deid.azure.com/.default"];
    }
  ]>;

@doc("Azure Health Data Services de-identification service versions.")
enum Versions {
  v2024_11_15: "2024-11-15",
  v2025_07_15_preview: "2025-07-15-preview",
}
