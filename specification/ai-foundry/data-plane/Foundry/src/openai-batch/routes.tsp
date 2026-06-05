import "../common/models.tsp";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/batch";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/batches")
@tag("Batch")
interface Batches {
  /** Returns the batches available to the current organization. */
  @list
  @get
  @summary("List batches")
  listBatches is OpenAIOperation<
    {
      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;
    },
    OpenAI.ListBatchesResponse
  >;

  /** Creates and starts a batch from an uploaded request file. */
  @post
  @summary("Create a batch")
  createBatch is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateBatchParametersBody;
    },
    OpenAI.Batch
  >;

  /** Retrieves the specified batch by ID. */
  @route("{batch_id}")
  @get
  @summary("Get a batch")
  retrieveBatch is OpenAIOperation<
    {
      /** The ID of the batch to retrieve. */
      @path
      batch_id: string;
    },
    OpenAI.Batch
  >;

  /** Cancels the specified in-progress batch and returns its updated status. */
  @route("{batch_id}/cancel")
  @post
  @summary("Cancel a batch")
  cancelBatch is OpenAIOperation<
    {
      /** The ID of the batch to cancel. */
      @path
      batch_id: string;
    },
    OpenAI.Batch
  >;
}
