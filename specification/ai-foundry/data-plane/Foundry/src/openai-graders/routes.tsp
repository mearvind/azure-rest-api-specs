import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/graders";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/fine_tuning/alpha/graders")
@tag("Fine-tuning")
interface Graders {
  /** Runs the specified grader and returns its evaluation results. */
  @route("run")
  @post
  @summary("Run a grader")
  runGrader is OpenAIOperation<
    {
      @body
      body: OpenAI.RunGraderRequest;
    },
    OpenAI.RunGraderResponse
  >;

  /** Validates the specified grader definition and returns the validation result. */
  @route("validate")
  @post
  @summary("Validate a grader")
  validateGrader is OpenAIOperation<
    {
      @body
      body: OpenAI.ValidateGraderRequest;
    },
    OpenAI.ValidateGraderResponse
  >;
}
