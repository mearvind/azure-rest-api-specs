import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/files";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/files")
@tag("Files")
interface Files {
  /** Returns the files available in the current project. */
  @list
  @get
  @summary("List files")
  listFiles is OpenAIOperation<
    {
      /** Only return files with the given purpose. */
      @query(#{ explode: true })
      purpose?: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 10,000, and the default is 10,000. */
      @query(#{ explode: true })
      limit?: integer = 10000;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;
    },
    OpenAI.ListFilesResponse
  >;

  /** Uploads a file for use with supported APIs and returns the created file resource. */
  @post
  @summary("Upload a file")
  createFile is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateFileRequest;
    },
    OpenAI.OpenAIFile
  >;

  /** Deletes the specified file and removes it from any vector stores. */
  @route("{file_id}")
  @delete
  @summary("Delete a file")
  deleteFile is OpenAIOperation<
    {
      /** The ID of the file to use for this request. */
      @path
      file_id: string;
    },
    OpenAI.DeleteFileResponse
  >;

  /** Retrieves metadata for the specified file. */
  @route("{file_id}")
  @get
  @summary("Get a file")
  retrieveFile is OpenAIOperation<
    {
      /** The ID of the file to use for this request. */
      @path
      file_id: string;
    },
    OpenAI.OpenAIFile
  >;

  /** Returns the content of the specified file. */
  @route("{file_id}/content")
  @get
  @summary("Get file content")
  downloadFile is OpenAIOperation<
    {
      /** The ID of the file to use for this request. */
      @path
      file_id: string;
    },
    TypeSpec.Http.Body<string>
  >;
}
