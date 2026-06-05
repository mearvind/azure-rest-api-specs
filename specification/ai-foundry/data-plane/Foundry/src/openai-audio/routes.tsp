import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/audio";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/audio")
@tag("Audio")
interface Audio {
  /** Generates spoken audio from the provided text and returns audio content or streamed audio events. */
  @route("speech")
  @post
  @summary("Create speech")
  createSpeech is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateSpeechRequest;
    },
    {
      @header("Transfer-Encoding")
      TransferEncoding?: string;

      @header
      contentType: "application/octet-stream";

      @body
      body: bytes;
    }
  >;

  /** Transcribes the uploaded audio into the input language and returns a transcription payload or transcript events. */
  @route("transcriptions")
  @post
  @summary("Create a transcription")
  createTranscription is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateTranscriptionRequest;
    },
    TypeSpec.Http.Body<
      | OpenAI.CreateTranscriptionResponseJson
      | OpenAI.CreateTranscriptionResponseDiarizedJson
      | OpenAI.CreateTranscriptionResponseVerboseJson>
  >;

  /** Translates the uploaded audio into English and returns the translated transcript. */
  @route("translations")
  @post
  @summary("Create a translation")
  createTranslation is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateTranslationRequest;
    },
    TypeSpec.Http.Body<
      | OpenAI.CreateTranslationResponseJson
      | OpenAI.CreateTranslationResponseVerboseJson>
  >;
}
