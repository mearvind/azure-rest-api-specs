import "../common/openai-templates.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/responses";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/responses")
@tag("Responses")
interface Responses {
  /** Creates a model response from the provided input and tools configuration. */
  @post
  @summary("Create a response")
  createResponse is OpenAIAgentSessionOperation<
    {
      @body
      body: OpenAI.CreateResponse;
    },
    OpenAI.Response
  >;

  /** Deletes the specified model response. */
  @route("{response_id}")
  @delete
  @summary("Delete a response")
  deleteResponse is OpenAIAgentSessionOperation<
    {
      /** The ID of the response to delete. */
      @path
      response_id: string;
    },
    OpenAI.DeleteResponseResponse
  >;

  /** Retrieves the specified model response. */
  @route("{response_id}")
  @get
  @summary("Get a response")
  getResponse is OpenAIAgentSessionOperation<
    {
      /** The ID of the response to retrieve. */
      @path
      response_id: string;

      /**Additional fields to include in the response. See the `include`
  parameter for Response creation above for more information.*/
      @query(#{ explode: true })
      include?: OpenAI.IncludeEnum[];

      /**If set to true, the model response data will be streamed to the client
  as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
  See the [Streaming section below](/docs/api-reference/responses-streaming)
  for more information.*/
      @query(#{ explode: true })
      stream?: boolean;

      /** The sequence number of the event after which to start streaming. */
      @query(#{ explode: true })
      starting_after?: integer;

      /**When true, stream obfuscation will be enabled. Stream obfuscation adds
  random characters to an `obfuscation` field on streaming delta events
  to normalize payload sizes as a mitigation to certain side-channel
  attacks. These obfuscation fields are included by default, but add a
  small amount of overhead to the data stream. You can set
  `include_obfuscation` to false to optimize for bandwidth if you trust
  the network links between your application and the OpenAI API.*/
      @query(#{ explode: true })
      include_obfuscation?: boolean;
    },
    OpenAI.Response
  >;

  /** Cancels the specified background model response and returns its updated state. */
  @route("{response_id}/cancel")
  @post
  @summary("Cancel a response")
  cancelResponse is OpenAIAgentSessionOperation<
    {
      /** The ID of the response to cancel. */
      @path
      response_id: string;
    },
    OpenAI.Response
  >;

  /** Returns the input items for the specified response. */
  @list
  @route("{response_id}/input_items")
  @get
  @summary("List response input items")
  listInputItems is OpenAIAgentPagedOperation<
    {
      /** The ID of the response to retrieve input items for. */
      @path
      response_id: string;

      /**A limit on the number of objects to be returned. Limit can range between
  1 and 100, and the default is 20.*/
      @query(#{ explode: true })
      limit?: integer = 20;

      /**The order to return the input items in. Default is `desc`.
  - `asc`: Return the input items in ascending order.
  - `desc`: Return the input items in descending order.*/
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum;

      /** An item ID to list items after, used in pagination. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /**Additional fields to include in the response. See the `include`
  parameter for Response creation above for more information.*/
      @query(#{ explode: true })
      include?: OpenAI.IncludeEnum[];
    },
    OpenAI.ResponseItemList
  >;

  /** Compacts a conversation and returns the compacted response object. */
  @route("compact")
  @post
  @summary("Compact a conversation")
  Compactconversation is OpenAISharedOperation<
    {
      @header
      contentType: "application/json" | "application/x-www-form-urlencoded";

      @body
      body: OpenAI.CompactResponseMethodPublicBody;
    },
    OpenAI.CompactResource
  >;

  /** Starts a streaming response for the provided input and returns server-sent events. */
  @operationId("createResponseStream")
  @post
  @summary("Create a response stream")
  createResponseStream is OpenAIAgentStreamingOperation<
    {
      @body
      body: OpenAI.CreateResponse;
    },
    OpenAI.ResponseAudioDeltaEvent
  >;

  /** Streams events for the specified response starting after the requested sequence number. */
  @operationId("getResponseStream")
  @get
  @route("{response_id}")
  @summary("Get a response stream")
  getResponseStream is OpenAIAgentStreamingOperation<
    {
      @path
      response_id: string;

      @query(#{ name: "include[]", explode: true })
      includables?: OpenAI.IncludeEnum[] = #[];

      @header
      accept: "text/event-stream";

      @query
      starting_after?: int32;
    },
    OpenAI.ResponseAudioDeltaEvent
  >;

  /** Returns responses filtered by the provided agent or conversation criteria. */
  @operationId("listResponses")
  @get
  @summary("List responses")
  listResponses is OpenAIAgentFilteredPagedOperation<
    {
      /** Filter by agent name. If provided, only items associated with the specified agent will be returned. */
      @query
      agent_name?: string;

      /** Filter by agent ID in the format `name:version`. If provided, only items associated with the specified agent ID will be returned. */
      @query
      agent_id?: string;

      /** Filter by conversation ID. If provided, only responses associated with the specified conversation will be returned. */
      @query
      conversation_id?: string;
    },
    OpenAI.Response
  >;

  /** Compacts the current session conversation and returns the compacted response object. */
  @operationId("compactResponseConversation")
  @post
  @route("compact")
  @summary("Compact a session conversation")
  compactResponseConversation is OpenAIAgentSessionOperation<
    {
      @body
      body: OpenAI.CompactResponseMethodPublicBody;
    },
    OpenAI.CompactResource
  >;
}
