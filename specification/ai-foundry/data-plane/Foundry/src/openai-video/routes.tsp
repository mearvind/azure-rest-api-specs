import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/video";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/videos")
@tag("Videos")
interface VideoGeneration {
  /** Returns the recently generated videos for the current project. */
  @list
  @get
  @summary("List videos")
  ListVideos is OpenAIOperation<
    {
      /** Number of items to retrieve */
      @minValue(0)
      @maxValue(100)
      @query(#{ explode: true })
      limit?: integer;

      /** Sort order of results by timestamp. Use `asc` for ascending order or `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum;

      /** Identifier for the last item from the previous pagination request */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;
    },
    OpenAI.VideoListResource
  >;

  /** Creates a video generation job from the provided prompt and reference assets. */
  @post
  @summary("Create a video")
  createVideo is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoMultipartBody;
    },
    OpenAI.VideoResource
  >;

  /** Creates a reusable character from an uploaded video. */
  @route("characters")
  @post
  @summary("Create a video character")
  CreateVideoCharacter is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoCharacterBody;
    },
    OpenAI.VideoCharacterResource
  >;

  /** Retrieves the specified video character by ID. */
  @route("characters/{character_id}")
  @get
  @summary("Get a video character")
  GetVideoCharacter is OpenAIOperation<
    {
      /** The identifier of the character to retrieve. */
      @path
      character_id: string;
    },
    OpenAI.VideoCharacterResource
  >;

  /** Creates a video generation job by editing a source video or an existing generated video. */
  @sharedRoute
  @route("edits")
  @post
  @summary("Edit a video")
  CreateVideoEditMultipart is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoEditMultipartBody;
    },
    OpenAI.VideoResource
  >;

  /** Creates a video generation job by editing a source video or an existing generated video. */
  @sharedRoute
  @route("edits")
  @post
  @summary("Edit a video")
  CreateVideoEditJson is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateVideoEditJsonBody;
    },
    OpenAI.VideoResource
  >;

  /** Creates an extension of the specified completed video. */
  @sharedRoute
  @route("extensions")
  @post
  @summary("Extend a video")
  CreateVideoExtendMultipart is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoExtendMultipartBody;
    },
    OpenAI.VideoResource
  >;

  /** Creates an extension of the specified completed video. */
  @sharedRoute
  @route("extensions")
  @post
  @summary("Extend a video")
  CreateVideoExtendJson is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateVideoExtendJsonBody;
    },
    OpenAI.VideoResource
  >;

  /** Permanently deletes the specified completed or failed video and its stored assets. */
  @route("{video_id}")
  @delete
  @summary("Delete a video")
  DeleteVideo is OpenAIOperation<
    {
      /** The identifier of the video to delete. */
      @path
      video_id: string;
    },
    OpenAI.DeletedVideoResource
  >;

  /** Retrieves the latest metadata for the specified generated video. */
  @route("{video_id}")
  @get
  @summary("Get a video")
  GetVideo is OpenAIOperation<
    {
      /** The identifier of the video to retrieve. */
      @path
      video_id: string;
    },
    OpenAI.VideoResource
  >;

  /** Streams the rendered content or preview asset for the specified video. */
  @route("{video_id}/content")
  @get
  @summary("Get video content")
  RetrieveVideoContent is OpenAIOperation<
    {
      /** The identifier of the video whose media to download. */
      @path
      video_id: string;

      /** Which downloadable asset to return. Defaults to the MP4 video. */
      @query(#{ explode: true })
      variant?: OpenAI.VideoContentVariant;
    },
    {
      @header
      contentType: "video/mp4";

      @body
      body: bytes;
    }
  >;

  /** Creates a remix of the specified completed video using a refreshed prompt. */
  @route("{video_id}/remix")
  @post
  @summary("Create a video remix")
  CreateVideoRemix is OpenAIOperation<
    {
      /** The identifier of the completed video to remix. */
      @path
      video_id: string;

      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoRemixBody;
    },
    OpenAI.VideoResource
  >;
}
