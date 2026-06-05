import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/completions";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/completions")
@tag("Completions")
interface Completions {
  /** Creates a completion for the provided prompt and returns the result or streamed completion chunks. */
  @post
  @summary("Create a completion")
  createCompletion is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateCompletionRequest;
    },
    OpenAI.CreateCompletionResponse
  >;
}
