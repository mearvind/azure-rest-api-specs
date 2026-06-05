import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/realtime";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/realtime")
@tag("Realtime")
interface Realtime {
  /** Creates a WebRTC realtime call and returns the SDP answer needed to complete the peer connection. */
  @route("calls")
  @post
  @summary("Create a realtime call")
  `create-realtime-call` is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.RealtimeCallCreateRequest;
    },
    {
      @statusCode
      statusCode: 201;

      @header
      Location?: string;

      @header
      contentType: "application/sdp";

      @body
      body: string;
    }
  >;

  /** Accepts an incoming SIP call and applies the provided realtime session configuration. */
  @route("calls/{call_id}/accept")
  @post
  @summary("Accept a realtime call")
  `accept-realtime-call` is OpenAIOperation<
    {
      /**The identifier for the call provided in the
  [`realtime.call.incoming`](/docs/api-reference/webhook-events/realtime/call/incoming)
  webhook.*/
      @path
      call_id: string;

      /** Session configuration to apply before the caller is bridged to the model. */
      @body
      body: OpenAI.RealtimeSessionCreateRequestGA;
    },
    TypeSpec.Http.OkResponse
  >;

  /** Ends the specified realtime call, whether it was started over SIP or WebRTC. */
  @route("calls/{call_id}/hangup")
  @post
  @summary("Hang up a realtime call")
  `hangup-realtime-call` is OpenAIOperation<
    {
      /**The identifier for the call. For SIP calls, use the value provided in the
  [`realtime.call.incoming`](/docs/api-reference/webhook-events/realtime/call/incoming)
  webhook. For WebRTC sessions, reuse the call ID returned in the `Location`
  header when creating the call with
  [`POST /v1/realtime/calls`](/docs/api-reference/realtime/create-call).*/
      @path
      call_id: string;
    },
    TypeSpec.Http.OkResponse
  >;

  /** Transfers the specified SIP call to a new destination by issuing a SIP REFER request. */
  @route("calls/{call_id}/refer")
  @post
  @summary("Refer a realtime call")
  `refer-realtime-call` is OpenAIOperation<
    {
      /**The identifier for the call provided in the
  [`realtime.call.incoming`](/docs/api-reference/webhook-events/realtime/call/incoming)
  webhook.*/
      @path
      call_id: string;

      /** Destination URI for the REFER request. */
      @body
      body: OpenAI.RealtimeCallReferRequest;
    },
    TypeSpec.Http.OkResponse
  >;

  /** Rejects an incoming SIP call with the specified SIP status response. */
  @route("calls/{call_id}/reject")
  @post
  @summary("Reject a realtime call")
  `reject-realtime-call` is OpenAIOperation<
    {
      /**The identifier for the call provided in the
  [`realtime.call.incoming`](/docs/api-reference/webhook-events/realtime/call/incoming)
  webhook.*/
      @path
      call_id: string;

      /**Provide an optional SIP status code. When omitted the API responds with
  `603 Decline`.*/
      @body
      body: OpenAI.RealtimeCallRejectRequest;
    },
    TypeSpec.Http.OkResponse
  >;

  /** Creates a short-lived client secret and returns the effective realtime session configuration. */
  @route("client_secrets")
  @post
  @summary("Create a realtime client secret")
  `create-realtime-client-secret` is OpenAIOperation<
    {
      /** Create a client secret with the given session configuration. */
      @body
      body: OpenAI.RealtimeCreateClientSecretRequest;
    },
    OpenAI.RealtimeCreateClientSecretResponse
  >;

  /** Creates an ephemeral API token for a client-side realtime session and returns the session details. */
  @route("sessions")
  @post
  @summary("Create a realtime session")
  `create-realtime-session` is OpenAIOperation<
    {
      /** Create an ephemeral API key with the given session configuration. */
      @body
      body: OpenAI.RealtimeSessionCreateRequest;
    },
    OpenAI.RealtimeSessionCreateResponse
  >;

  /** Creates an ephemeral API token for a client-side realtime transcription session and returns the session details. */
  @route("transcription_sessions")
  @post
  @summary("Create a realtime transcription session")
  `create-realtime-transcription-session` is OpenAIOperation<
    {
      /** Create an ephemeral API key with the given session configuration. */
      @body
      body: OpenAI.RealtimeTranscriptionSessionCreateRequest;
    },
    OpenAI.RealtimeTranscriptionSessionCreateResponse
  >;

  /** Creates a short-lived client secret for the Realtime Translation API and returns the effective translation session configuration. */
  @route("translations/client_secrets")
  @post
  @summary("Create a realtime translation client secret")
  `create-realtime-translation-client-secret` is OpenAIOperation<
    {
      /** Create a client secret with the given translation session configuration. */
      @body
      body: OpenAI.RealtimeTranslationClientSecretCreateRequest;
    },
    OpenAI.RealtimeTranslationClientSecretCreateResponse
  >;
}
