import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/uploads";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/uploads")
@tag("Uploads")
interface Uploads {
  /** Creates an upload container for file parts and returns it in the `pending` state. */
  @post
  @summary("Create an upload")
  createUpload is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateUploadRequest;
    },
    OpenAI.Upload
  >;

  /** Cancels the specified upload and returns it in the `cancelled` state. */
  @route("{upload_id}/cancel")
  @post
  @summary("Cancel an upload")
  cancelUpload is OpenAIOperation<
    {
      /** The ID of the Upload. */
      @path
      upload_id: string;
    },
    OpenAI.Upload
  >;

  /** Completes the specified upload, assembles its parts in order, and returns the resulting file resource. */
  @route("{upload_id}/complete")
  @post
  @summary("Complete an upload")
  completeUpload is OpenAIOperation<
    {
      /** The ID of the Upload. */
      @path
      upload_id: string;

      @body
      body: OpenAI.CompleteUploadRequest;
    },
    OpenAI.Upload
  >;

  /** Adds a part to the specified upload and returns the created part resource. */
  @route("{upload_id}/parts")
  @post
  @summary("Add an upload part")
  addUploadPart is OpenAIOperation<
    {
      /** The ID of the Upload. */
      @path
      upload_id: string;

      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.AddUploadPartRequest;
    },
    OpenAI.UploadPart
  >;
}
