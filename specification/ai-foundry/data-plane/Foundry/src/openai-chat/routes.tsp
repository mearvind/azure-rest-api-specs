import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/chat";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/chat")
@tag("Chat")
interface Chat {
  /** Returns the stored chat completions created with the `store` parameter set to `true`. */
  @list
  @route("completions")
  @get
  @summary("List chat completions")
  listChatCompletions is OpenAIOperation<
    {
      /** The model used to generate the Chat Completions. */
      @query(#{ explode: true })
      `model`?: string;

      /**A list of metadata keys to filter the Chat Completions by. Example:
  `metadata[key1]=value1&metadata[key2]=value2`*/
      @query(#{ explode: true })
      metadata?: OpenAI.Metadata | null;

      /** Identifier for the last chat completion from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of Chat Completions to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order for Chat Completions by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.asc;
    },
    OpenAI.ChatCompletionList
  >;

  /** Creates a chat completion for the provided conversation and returns the completion or streamed chunks. */
  @route("completions")
  @post
  @summary("Create a chat completion")
  createChatCompletion is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateChatCompletionRequest;
    },
    OpenAI.CreateChatCompletionResponse
  >;

  /** Deletes the specified stored chat completion when it was created with `store=true`. */
  @route("completions/{completion_id}")
  @delete
  @summary("Delete a chat completion")
  deleteChatCompletion is OpenAIOperation<
    {
      /** The ID of the chat completion to delete. */
      @path
      completion_id: string;
    },
    OpenAI.ChatCompletionDeleted
  >;

  /** Retrieves the specified stored chat completion when it was created with `store=true`. */
  @route("completions/{completion_id}")
  @get
  @summary("Get a chat completion")
  getChatCompletion is OpenAIOperation<
    {
      /** The ID of the chat completion to retrieve. */
      @path
      completion_id: string;
    },
    OpenAI.CreateChatCompletionResponse
  >;

  /** Updates the metadata for the specified stored chat completion. */
  @route("completions/{completion_id}")
  @post
  @summary("Update a chat completion")
  updateChatCompletion is OpenAIOperation<
    {
      /** The ID of the chat completion to update. */
      @path
      completion_id: string;

      @body
      body: OpenAI.UpdateChatCompletionParametersBody;
    },
    OpenAI.CreateChatCompletionResponse
  >;

  /** Returns the stored messages for the specified chat completion when it was created with `store=true`. */
  @list
  @route("completions/{completion_id}/messages")
  @get
  @summary("List chat completion messages")
  getChatCompletionMessages is OpenAIOperation<
    {
      /** The ID of the chat completion to retrieve messages from. */
      @path
      completion_id: string;

      /** Identifier for the last message from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of messages to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order for messages by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.asc;
    },
    OpenAI.ChatCompletionMessageList
  >;
}
