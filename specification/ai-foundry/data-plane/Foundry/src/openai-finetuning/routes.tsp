import "../common/models.tsp";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/fine-tuning";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/fine_tuning")
@tag("Fine-tuning")
interface FineTuning {
  /** Returns the permissions for the specified fine-tuned model checkpoint. This operation requires an admin API key. */
  @list
  @route("checkpoints/{fine_tuned_model_checkpoint}/permissions")
  @get
  @summary("List checkpoint permissions")
  listFineTuningCheckpointPermissions is OpenAIOperation<
    {
      /** The ID of the fine-tuned model checkpoint to get permissions for. */
      @path
      fine_tuned_model_checkpoint: string;

      /** The ID of the project to get permissions for. */
      @query(#{ explode: true })
      project_id?: string;

      /** Identifier for the last permission ID from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of permissions to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 10;

      /** The order in which to retrieve permissions. */
      @query(#{ explode: true })
      order?: "ascending" | "descending" = "descending";
    },
    OpenAI.ListFineTuningCheckpointPermissionResponse
  >;

  /** Creates a permission for the specified fine-tuned model checkpoint. This operation requires an admin API key. */
  @route("checkpoints/{fine_tuned_model_checkpoint}/permissions")
  @post
  @summary("Create a checkpoint permission")
  createFineTuningCheckpointPermission is OpenAIOperation<
    {
      /** The ID of the fine-tuned model checkpoint to create a permission for. */
      @path
      fine_tuned_model_checkpoint: string;

      @body
      body: OpenAI.CreateFineTuningCheckpointPermissionRequest;
    },
    OpenAI.ListFineTuningCheckpointPermissionResponse
  >;

  /** Deletes the specified permission from the fine-tuned model checkpoint. This operation requires an admin API key. */
  @route("checkpoints/{fine_tuned_model_checkpoint}/permissions/{permission_id}")
  @delete
  @summary("Delete a checkpoint permission")
  deleteFineTuningCheckpointPermission is OpenAIOperation<
    {
      /** The ID of the fine-tuned model checkpoint to delete a permission for. */
      @path
      fine_tuned_model_checkpoint: string;

      /** The ID of the fine-tuned model checkpoint permission to delete. */
      @path
      permission_id: string;
    },
    OpenAI.DeleteFineTuningCheckpointPermissionResponse
  >;

  /** Returns the fine-tuning jobs available to the current organization. */
  @list
  @route("jobs")
  @get
  @summary("List fine-tuning jobs")
  listPaginatedFineTuningJobs is OpenAIOperation<
    {
      /** Identifier for the last job from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of fine-tuning jobs to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Alternatively, set `metadata=null` to indicate no metadata. */
      @query(#{ explode: true })
      metadata?: Record<string> | null;
    },
    OpenAI.ListPaginatedFineTuningJobsResponse
  >;

  /** Creates a fine-tuning job from the provided dataset and returns the enqueued job details. */
  @route("jobs")
  @post
  @summary("Create a fine-tuning job")
  createFineTuningJob is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateFineTuningJobRequest;
    },
    OpenAI.FineTuningJob
  >;

  /** Retrieves the specified fine-tuning job and its current status. */
  @route("jobs/{fine_tuning_job_id}")
  @get
  @summary("Get a fine-tuning job")
  retrieveFineTuningJob is OpenAIOperation<
    {
      /** The ID of the fine-tuning job. */
      @path
      fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  /** Cancels the specified fine-tuning job and returns its updated state. */
  @route("jobs/{fine_tuning_job_id}/cancel")
  @post
  @summary("Cancel a fine-tuning job")
  cancelFineTuningJob is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to cancel. */
      @path
      fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  /** Returns the checkpoints for the specified fine-tuning job. */
  @list
  @route("jobs/{fine_tuning_job_id}/checkpoints")
  @get
  @summary("List fine-tuning checkpoints")
  listFineTuningJobCheckpoints is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to get checkpoints for. */
      @path
      fine_tuning_job_id: string;

      /** Identifier for the last checkpoint ID from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of checkpoints to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 10;
    },
    OpenAI.ListFineTuningJobCheckpointsResponse
  >;

  /** Returns the status events for the specified fine-tuning job. */
  @list
  @route("jobs/{fine_tuning_job_id}/events")
  @get
  @summary("List fine-tuning events")
  listFineTuningEvents is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to get events for. */
      @path
      fine_tuning_job_id: string;

      /** Identifier for the last event from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of events to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;
    },
    OpenAI.ListFineTuningJobEventsResponse
  >;

  /** Pauses the specified fine-tuning job and returns its updated state. */
  @route("jobs/{fine_tuning_job_id}/pause")
  @post
  @summary("Pause a fine-tuning job")
  pauseFineTuningJob is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to pause. */
      @path
      fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  /** Resumes the specified fine-tuning job and returns its updated state. */
  @route("jobs/{fine_tuning_job_id}/resume")
  @post
  @summary("Resume a fine-tuning job")
  resumeFineTuningJob is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to resume. */
      @path
      fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;
}
