import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/images";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/images")
@tag("Images")
interface Images {
  /** Creates an edited or extended image from the provided source images and prompt. */
  @sharedRoute
  @route("edits")
  @post
  @summary("Edit an image")
  createImageEditMultipart is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateImageEditRequest;
    },
    OpenAI.ImagesResponse
  >;

  /** Creates an edited or extended image from the provided source images and prompt. */
  @sharedRoute
  @route("edits")
  @post
  @summary("Edit an image")
  createImageEditJson is OpenAIOperation<
    {
      @body
      body: OpenAI.EditImageBodyJsonParam;
    },
    OpenAI.ImagesResponse
  >;

  /** Creates an image from the provided prompt. */
  @route("generations")
  @post
  @summary("Create an image")
  createImage is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateImageRequest;
    },
    OpenAI.ImagesResponse
  >;

  /** Creates a variation of the provided image. This operation only supports `dall-e-2`. */
  @route("variations")
  @post
  @summary("Create an image variation")
  createImageVariation is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateImageVariationRequest;
    },
    OpenAI.ImagesResponse
  >;
}
