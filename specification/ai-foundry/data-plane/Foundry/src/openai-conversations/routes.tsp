import "../common/openai-templates.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/conversations";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/conversations")
@tag("Conversations")
interface Conversations {
  /** Returns the items in the specified conversation. */
  @list
  @route("{conversation_id}/items")
  @get
  @summary("List conversation items")
  listConversationItems is OpenAIAgentOperation<
    {
      /** The ID of the conversation to list items for. */
      @path
      conversation_id: string;

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

      /**Specify additional output data to include in the model response. Currently supported values are:
  - `web_search_call.action.sources`: Include the sources of the web search tool call.
  - `code_interpreter_call.outputs`: Includes the outputs of python code execution in code interpreter tool call items.
  - `computer_call_output.output.image_url`: Include image urls from the computer call output.
  - `file_search_call.results`: Include the search results of the file search tool call.
  - `message.input_image.image_url`: Include image urls from the input message.
  - `message.output_text.logprobs`: Include logprobs with assistant messages.
  - `reasoning.encrypted_content`: Includes an encrypted version of reasoning tokens in reasoning item outputs. This enables reasoning items to be used in multi-turn conversations when using the Responses API statelessly (like when the `store` parameter is set to `false`, or when an organization is enrolled in the zero data retention program).*/
      @query(#{ explode: true })
      include?: OpenAI.IncludeEnum[];
    },
    OpenAI.ConversationItemList
  >;

  /** Creates items in the specified conversation and returns the created items. */
  @route("{conversation_id}/items")
  @post
  @summary("Create conversation items")
  createConversationItems is OpenAIAgentOperation<
    {
      /** The ID of the conversation to add the item to. */
      @path
      conversation_id: string;

      /**Additional fields to include in the response. See the `include`
  parameter for [listing Conversation items above](/docs/api-reference/conversations/list-items#conversations_list_items-include) for more information.*/
      @query(#{ explode: true })
      include?: OpenAI.IncludeEnum[];

      @body
      body: OpenAI.CreateConversationItemsParametersBody;
    },
    OpenAI.ConversationItemList
  >;

  /** Deletes the specified item from the conversation. */
  @route("{conversation_id}/items/{item_id}")
  @delete
  @summary("Delete a conversation item")
  deleteConversationItem is OpenAIAgentOperation<
    {
      /** The ID of the conversation that contains the item. */
      @path
      conversation_id: string;

      /** The ID of the item to delete. */
      @path
      item_id: string;
    },
    OpenAI.ConversationResource
  >;

  /** Retrieves the specified item from the conversation. */
  @route("{conversation_id}/items/{item_id}")
  @get
  @summary("Get a conversation item")
  getConversationItem is OpenAIAgentOperation<
    {
      /** The ID of the conversation that contains the item. */
      @path
      conversation_id: string;

      /** The ID of the item to retrieve. */
      @path
      item_id: string;

      /**Additional fields to include in the response. See the `include`
  parameter for [listing Conversation items above](/docs/api-reference/conversations/list-items#conversations_list_items-include) for more information.*/
      @query(#{ explode: true })
      include?: OpenAI.IncludeEnum[];
    },
    OpenAI.ConversationItem
  >;

  /** Creates a conversation and returns the created resource. */
  @post
  @summary("Create a conversation")
  createConversation is OpenAIAgentOperation<
    {
      @body
      body: OpenAI.CreateConversationBody;
    },
    OpenAI.ConversationResource
  >;

  /** Deletes the specified conversation without deleting its items. */
  @route("{conversation_id}")
  @delete
  @summary("Delete a conversation")
  deleteConversation is OpenAIAgentOperation<
    {
      /** The ID of the conversation to delete. */
      @path
      conversation_id: string;
    },
    OpenAI.DeletedConversationResource
  >;

  /** Retrieves the specified conversation by ID. */
  @route("{conversation_id}")
  @get
  @summary("Get a conversation")
  getConversation is OpenAIAgentOperation<
    {
      /** The ID of the conversation to retrieve. */
      @path
      conversation_id: string;
    },
    OpenAI.ConversationResource
  >;

  /** Updates the specified conversation and returns the updated resource. */
  @route("{conversation_id}")
  @post
  @summary("Update a conversation")
  updateConversation is OpenAIAgentOperation<
    {
      /** The ID of the conversation to update. */
      @path
      conversation_id: string;

      @body
      body: OpenAI.UpdateConversationBody;
    },
    OpenAI.ConversationResource
  >;

  /** Returns conversations filtered by the provided agent criteria. */
  @operationId("listConversations")
  @get
  @summary("List conversations")
  listConversations is OpenAIAgentFilteredPagedOperation<
    {
      /** Filter by agent name. If provided, only items associated with the specified agent will be returned. */
      @query
      agent_name?: string;

      /** Filter by agent ID in the format `name:version`. If provided, only items associated with the specified agent ID will be returned. */
      @query
      agent_id?: string;
    },
    OpenAI.ConversationResource
  >;
}
