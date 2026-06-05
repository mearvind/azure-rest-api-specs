import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/moderations";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/moderations")
@tag("Moderations")
interface Moderations {
  /** Classifies the provided text or image inputs and returns moderation results. */
  @post
  @summary("Create a moderation")
  createModeration is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateModerationRequest;
    },
    OpenAI.CreateModerationResponse
  >;
}
