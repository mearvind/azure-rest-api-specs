import "./common.tsp";
using TypeSpec.Versioning;

namespace Microsoft.App.DynamicSessions;

/** SessionPool Metadata. */
@added(Versions.v2025_02_02_preview)
model SessionPoolMetadataResponse {
  /** List of runtimes. */
  runtimes: Runtime[];

  /** List of pre-installed packages. */
  preInstalledPackages: Package[];

  /** Creation date in RFC3339 format. */
  createdAt: utcDateTime;

  /** Last updated date in RFC3339 format. */
  lastUpdatedAt: utcDateTime;

  /** Jupyter kernel information. */
  jupyterKernel: JupyterKernel;
}

/** Runtime information. */
@added(Versions.v2025_02_02_preview)
model Runtime {
  /** Name of the runtime. */
  name: string;

  /** Version of the runtime. */
  version: string;
}

/** Package information. */
@added(Versions.v2025_02_02_preview)
model Package {
  /** Name of the package. */
  name: string;

  /** Version of the package. */
  version: string;
}

/** Jupyter kernel information. */
@added(Versions.v2025_02_02_preview)
model JupyterKernel {
  /** Name of the kernel. */
  name: string;

  /** Version of the kernel. */
  version: string;

  /** Project URL of the kernel. */
  #suppress "@azure-tools/typespec-client-generator-core/no-url-suffix" "Importing this project's existing client.tsp would apply unrelated customizations; keeping the existing C# SDK surface avoids a breaking change."
  projectUrl: url;

  /** Description of the kernel. */
  description: string;
}
