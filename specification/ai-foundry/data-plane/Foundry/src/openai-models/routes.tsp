import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/models";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/models")
@tag("Models")
interface OpenAIModels {
  /** Returns the models currently available in the current project. */
  @list
  @get
  @summary("List models")
  listModels is OpenAIOperation<{}, OpenAI.ListModelsResponse>;

  /** Deletes the specified fine-tuned model. This operation requires the Owner role in the organization. */
  @route("{model}")
  @delete
  @summary("Delete a model")
  deleteModel is OpenAIOperation<
    {
      /** The model to delete */
      @path
      `model`: string;
    },
    OpenAI.DeleteModelResponse
  >;

  /** Retrieves the specified model and returns its basic metadata and permissions. */
  @route("{model}")
  @get
  @summary("Get a model")
  retrieveModel is OpenAIOperation<
    {
      /** The ID of the model to use for this request */
      @path
      `model`: string;
    },
    OpenAI.Model
  >;
}
