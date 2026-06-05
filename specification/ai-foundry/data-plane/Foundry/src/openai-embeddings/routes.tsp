import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/embeddings";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/embeddings")
@tag("Embeddings")
interface Embeddings {
  /** Creates an embedding vector for the provided input. */
  @post
  @summary("Create an embedding")
  createEmbedding is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateEmbeddingRequest;
    },
    OpenAI.CreateEmbeddingResponse
  >;
}
