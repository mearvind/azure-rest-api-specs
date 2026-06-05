import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/threads";
import "@azure-tools/openai-typespec/models/runs";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/messages";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/threads")
@tag("Threads")
interface Threads {
  /** Creates a thread and returns the created resource. */
  @tag("Assistants")
  @post
  @summary("Create a thread")
  createThread is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateThreadRequest;
    },
    OpenAI.ThreadObject
  >;

  /** Creates a thread, starts a run, and returns the created run. */
  @tag("Assistants")
  @route("runs")
  @post
  @summary("Create a thread and run")
  createThreadAndRun is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateThreadAndRunRequest;
    },
    OpenAI.RunObject
  >;

  /** Deletes the specified thread. */
  @tag("Assistants")
  @route("{thread_id}")
  @delete
  @summary("Delete a thread")
  deleteThread is OpenAIOperation<
    {
      /** The ID of the thread to delete. */
      @path
      thread_id: string;
    },
    OpenAI.DeleteThreadResponse
  >;

  /** Retrieves the specified thread by ID. */
  @tag("Assistants")
  @route("{thread_id}")
  @get
  @summary("Get a thread")
  getThread is OpenAIOperation<
    {
      /** The ID of the thread to retrieve. */
      @path
      thread_id: string;
    },
    OpenAI.ThreadObject
  >;

  /** Updates the specified thread metadata and returns the updated resource. */
  @tag("Assistants")
  @route("{thread_id}")
  @post
  @summary("Update a thread")
  modifyThread is OpenAIOperation<
    {
      /** The ID of the thread to modify. Only the `metadata` can be modified. */
      @path
      thread_id: string;

      @body
      body: OpenAI.ModifyThreadRequest;
    },
    OpenAI.ThreadObject
  >;

  /** Returns the messages in the specified thread. */
  @tag("Assistants")
  @list
  @route("{thread_id}/messages")
  @get
  @summary("List messages")
  listMessages is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) the messages belong to. */
      @path
      thread_id: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
      @query(#{ explode: true })
      before?: string;

      /** Filter messages by the run ID that generated them. */
      @query(#{ explode: true })
      run_id?: string;
    },
    OpenAI.ListMessagesResponse
  >;

  /** Creates a message in the specified thread. */
  @tag("Assistants")
  @route("{thread_id}/messages")
  @post
  @summary("Create a message")
  createMessage is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) to create a message for. */
      @path
      thread_id: string;

      @body
      body: OpenAI.CreateMessageRequest;
    },
    OpenAI.MessageObject
  >;

  /** Deletes the specified message from the thread. */
  @tag("Assistants")
  @route("{thread_id}/messages/{message_id}")
  @delete
  @summary("Delete a message")
  deleteMessage is OpenAIOperation<
    {
      /** The ID of the thread to which this message belongs. */
      @path
      thread_id: string;

      /** The ID of the message to delete. */
      @path
      message_id: string;
    },
    OpenAI.DeleteMessageResponse
  >;

  /** Retrieves the specified message from the thread. */
  @tag("Assistants")
  @route("{thread_id}/messages/{message_id}")
  @get
  @summary("Get a message")
  getMessage is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) to which this message belongs. */
      @path
      thread_id: string;

      /** The ID of the message to retrieve. */
      @path
      message_id: string;
    },
    OpenAI.MessageObject
  >;

  /** Updates the specified message and returns the updated resource. */
  @tag("Assistants")
  @route("{thread_id}/messages/{message_id}")
  @post
  @summary("Update a message")
  modifyMessage is OpenAIOperation<
    {
      /** The ID of the thread to which this message belongs. */
      @path
      thread_id: string;

      /** The ID of the message to modify. */
      @path
      message_id: string;

      @body
      body: OpenAI.ModifyMessageRequest;
    },
    OpenAI.MessageObject
  >;

  /** Returns the runs for the specified thread. */
  @tag("Assistants")
  @list
  @route("{thread_id}/runs")
  @get
  @summary("List runs")
  listRuns is OpenAIOperation<
    {
      /** The ID of the thread the run belongs to. */
      @path
      thread_id: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
      @query(#{ explode: true })
      before?: string;
    },
    OpenAI.ListRunsResponse
  >;

  /** Creates a run for the specified thread and returns the created run. */
  @tag("Assistants")
  @route("{thread_id}/runs")
  @post
  @summary("Create a run")
  createRun is OpenAIOperation<
    {
      /** The ID of the thread to run. */
      @path
      thread_id: string;

      /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.
  See the [file search tool documentation](/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
      @query(#{ explode: true })
      `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[];

      @body
      body: OpenAI.CreateRunRequest;
    },
    OpenAI.RunObject
  >;

  /** Retrieves the specified run from the thread. */
  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}")
  @get
  @summary("Get a run")
  getRun is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) that was run. */
      @path
      thread_id: string;

      /** The ID of the run to retrieve. */
      @path
      run_id: string;
    },
    OpenAI.RunObject
  >;

  /** Updates the specified run and returns the updated resource. */
  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}")
  @post
  @summary("Update a run")
  modifyRun is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) that was run. */
      @path
      thread_id: string;

      /** The ID of the run to modify. */
      @path
      run_id: string;

      @body
      body: OpenAI.ModifyRunRequest;
    },
    OpenAI.RunObject
  >;

  /** Cancels the specified in-progress run. */
  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}/cancel")
  @post
  @summary("Cancel a run")
  cancelRun is OpenAIOperation<
    {
      /** The ID of the thread to which this run belongs. */
      @path
      thread_id: string;

      /** The ID of the run to cancel. */
      @path
      run_id: string;
    },
    OpenAI.RunObject
  >;

  /** Returns the steps for the specified run. */
  @tag("Assistants")
  @list
  @route("{thread_id}/runs/{run_id}/steps")
  @get
  @summary("List run steps")
  listRunSteps is OpenAIOperation<
    {
      /** The ID of the thread the run and run steps belong to. */
      @path
      thread_id: string;

      /** The ID of the run the run steps belong to. */
      @path
      run_id: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
      @query(#{ explode: true })
      before?: string;

      /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.
  See the [file search tool documentation](/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
      @query(#{ explode: true })
      `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[];
    },
    OpenAI.ListRunStepsResponse
  >;

  /** Retrieves the specified run step. */
  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}/steps/{step_id}")
  @get
  @summary("Get a run step")
  getRunStep is OpenAIOperation<
    {
      /** The ID of the thread to which the run and run step belongs. */
      @path
      thread_id: string;

      /** The ID of the run to which the run step belongs. */
      @path
      run_id: string;

      /** The ID of the run step to retrieve. */
      @path
      step_id: string;

      /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.
  See the [file search tool documentation](/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
      @query(#{ explode: true })
      `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[];
    },
    OpenAI.RunStepObject
  >;

  /** Submits tool outputs for a run that is waiting on `submit_tool_outputs`. */
  @tag("Assistants")
  @route("{thread_id}/runs/{run_id}/submit_tool_outputs")
  @post
  @summary("Submit tool outputs")
  submitToolOuputsToRun is OpenAIOperation<
    {
      /** The ID of the [thread](/docs/api-reference/threads) to which this run belongs. */
      @path
      thread_id: string;

      /** The ID of the run that requires the tool output submission. */
      @path
      run_id: string;

      @body
      body: OpenAI.SubmitToolOutputsRunRequest;
    },
    OpenAI.RunObject
  >;
}
