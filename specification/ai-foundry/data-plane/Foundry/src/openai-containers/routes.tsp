import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/containers";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/containers")
@tag("Containers")
interface Containers {
  /** Returns the containers available in the current project. */
  @list
  @get
  @summary("List containers")
  ListContainers is OpenAIOperation<
    {
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

      /** Filter results by container name. */
      @query(#{ explode: true })
      name?: string;
    },
    OpenAI.ContainerListResource
  >;

  /** Creates a container and returns the created resource. */
  @post
  @summary("Create a container")
  CreateContainer is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateContainerBody;
    },
    OpenAI.ContainerResource
  >;

  /** Deletes the specified container. */
  @route("{container_id}")
  @delete
  @summary("Delete a container")
  DeleteContainer is OpenAIOperation<
    {
      /** The ID of the container to delete. */
      @path
      container_id: string;
    },
    TypeSpec.Http.OkResponse
  >;

  /** Retrieves the specified container by ID. */
  @route("{container_id}")
  @get
  @summary("Get a container")
  RetrieveContainer is OpenAIOperation<
    {
      @path
      container_id: string;
    },
    OpenAI.ContainerResource
  >;

  /** Returns the files associated with the specified container. */
  @list
  @route("{container_id}/files")
  @get
  @summary("List container files")
  ListContainerFiles is OpenAIOperation<
    {
      @path
      container_id: string;

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
    },
    OpenAI.ContainerFileListResource
  >;

  /** Adds a file to the specified container by uploading content or referencing an existing file ID. */
  @sharedRoute
  @route("{container_id}/files")
  @post
  @summary("Create a container file")
  CreateContainerFileMultipart is OpenAIOperation<
    {
      @path
      container_id: string;

      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateContainerFileBody;
    },
    OpenAI.ContainerFileResource
  >;

  /** Adds a file to the specified container by uploading content or referencing an existing file ID. */
  @sharedRoute
  @route("{container_id}/files")
  @post
  @summary("Create a container file")
  CreateContainerFileJson is OpenAIOperation<
    {
      @path
      container_id: string;

      @body
      body: OpenAI.CreateContainerFileBody;
    },
    OpenAI.ContainerFileResource
  >;

  /** Deletes the specified file association from the container. */
  @route("{container_id}/files/{file_id}")
  @delete
  @summary("Delete a container file")
  DeleteContainerFile is OpenAIOperation<
    {
      @path
      container_id: string;

      @path
      file_id: string;
    },
    TypeSpec.Http.OkResponse
  >;

  /** Retrieves the specified file association from the container. */
  @route("{container_id}/files/{file_id}")
  @get
  @summary("Get a container file")
  RetrieveContainerFile is OpenAIOperation<
    {
      @path
      container_id: string;

      @path
      file_id: string;
    },
    OpenAI.ContainerFileResource
  >;

  /** Returns the content for the specified file in the container. */
  @route("{container_id}/files/{file_id}/content")
  @get
  @summary("Get container file content")
  RetrieveContainerFileContent is OpenAIOperation<
    {
      @path
      container_id: string;

      @path
      file_id: string;
    },
    TypeSpec.Http.OkResponse
  >;
}
