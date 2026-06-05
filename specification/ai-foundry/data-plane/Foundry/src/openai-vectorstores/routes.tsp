import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/vector-stores";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/vector_stores")
@tag("Vector stores")
interface VectorStores {
  /** Returns the vector stores available in the current project. */
  @list
  @get
  @summary("List vector stores")
  listVectorStores is OpenAIOperation<
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

      /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
      @query(#{ explode: true })
      before?: string;
    },
    OpenAI.ListVectorStoresResponse
  >;

  /** Creates a vector store and returns the created resource. */
  @post
  @summary("Create a vector store")
  createVectorStore is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateVectorStoreRequest;
    },
    OpenAI.VectorStoreObject
  >;

  /** Deletes the specified vector store. */
  @route("{vector_store_id}")
  @delete
  @summary("Delete a vector store")
  deleteVectorStore is OpenAIOperation<
    {
      /** The ID of the vector store to delete. */
      @path
      vector_store_id: string;
    },
    OpenAI.DeleteVectorStoreResponse
  >;

  /** Retrieves the specified vector store by ID. */
  @route("{vector_store_id}")
  @get
  @summary("Get a vector store")
  getVectorStore is OpenAIOperation<
    {
      /** The ID of the vector store to retrieve. */
      @path
      vector_store_id: string;
    },
    OpenAI.VectorStoreObject
  >;

  /** Updates the specified vector store and returns the updated resource. */
  @route("{vector_store_id}")
  @post
  @summary("Update a vector store")
  modifyVectorStore is OpenAIOperation<
    {
      /** The ID of the vector store to modify. */
      @path
      vector_store_id: string;

      @body
      body: OpenAI.UpdateVectorStoreRequest;
    },
    OpenAI.VectorStoreObject
  >;

  /** Creates a file batch for the specified vector store. */
  @route("{vector_store_id}/file_batches")
  @post
  @summary("Create a vector store file batch")
  createVectorStoreFileBatch is OpenAIOperation<
    {
      /** The ID of the vector store for which to create a File Batch. */
      @path
      vector_store_id: string;

      @body
      body: OpenAI.CreateVectorStoreFileBatchRequest;
    },
    OpenAI.VectorStoreFileBatchObject
  >;

  /** Retrieves the specified file batch for the vector store. */
  @route("{vector_store_id}/file_batches/{batch_id}")
  @get
  @summary("Get a vector store file batch")
  getVectorStoreFileBatch is OpenAIOperation<
    {
      /** The ID of the vector store that the file batch belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file batch being retrieved. */
      @path
      batch_id: string;
    },
    OpenAI.VectorStoreFileBatchObject
  >;

  /** Cancels the specified vector store file batch as soon as possible. */
  @route("{vector_store_id}/file_batches/{batch_id}/cancel")
  @post
  @summary("Cancel a vector store file batch")
  cancelVectorStoreFileBatch is OpenAIOperation<
    {
      /** The ID of the vector store that the file batch belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file batch to cancel. */
      @path
      batch_id: string;
    },
    OpenAI.VectorStoreFileBatchObject
  >;

  /** Returns the files in the specified vector store file batch. */
  @list
  @route("{vector_store_id}/file_batches/{batch_id}/files")
  @get
  @summary("List vector store batch files")
  listFilesInVectorStoreBatch is OpenAIOperation<
    {
      /** The ID of the vector store that the files belong to. */
      @path
      vector_store_id: string;

      /** The ID of the file batch that the files belong to. */
      @path
      batch_id: string;

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

      /** Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`. */
      @query(#{ explode: true })
      filter?: OpenAI.ListVectorStoreFilesFilter;
    },
    OpenAI.ListVectorStoreFilesResponse
  >;

  /** Returns the files attached to the specified vector store. */
  @list
  @route("{vector_store_id}/files")
  @get
  @summary("List vector store files")
  listVectorStoreFiles is OpenAIOperation<
    {
      /** The ID of the vector store that the files belong to. */
      @path
      vector_store_id: string;

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

      /** Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`. */
      @query(#{ explode: true })
      filter?: OpenAI.ListVectorStoreFilesFilter;
    },
    OpenAI.ListVectorStoreFilesResponse
  >;

  /** Attaches a file to the specified vector store and returns the created file resource. */
  @route("{vector_store_id}/files")
  @post
  @summary("Create a vector store file")
  createVectorStoreFile is OpenAIOperation<
    {
      /** The ID of the vector store for which to create a File. */
      @path
      vector_store_id: string;

      @body
      body: OpenAI.CreateVectorStoreFileRequest;
    },
    OpenAI.VectorStoreFileObject
  >;

  /** Removes the specified file from the vector store without deleting the underlying file. */
  @route("{vector_store_id}/files/{file_id}")
  @delete
  @summary("Delete a vector store file")
  deleteVectorStoreFile is OpenAIOperation<
    {
      /** The ID of the vector store that the file belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file to delete. */
      @path
      file_id: string;
    },
    OpenAI.DeleteVectorStoreFileResponse
  >;

  /** Retrieves the specified file attachment from the vector store. */
  @route("{vector_store_id}/files/{file_id}")
  @get
  @summary("Get a vector store file")
  getVectorStoreFile is OpenAIOperation<
    {
      /** The ID of the vector store that the file belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file being retrieved. */
      @path
      file_id: string;
    },
    OpenAI.VectorStoreFileObject
  >;

  /** Updates the attributes of the specified vector store file. */
  @route("{vector_store_id}/files/{file_id}")
  @post
  @summary("Update a vector store file")
  updateVectorStoreFileAttributes is OpenAIOperation<
    {
      /** The ID of the vector store the file belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file to update attributes. */
      @path
      file_id: string;

      @body
      body: OpenAI.UpdateVectorStoreFileAttributesRequest;
    },
    OpenAI.VectorStoreFileObject
  >;

  /** Returns the parsed content for the specified vector store file. */
  @route("{vector_store_id}/files/{file_id}/content")
  @get
  @summary("Get vector store file content")
  retrieveVectorStoreFileContent is OpenAIOperation<
    {
      /** The ID of the vector store. */
      @path
      vector_store_id: string;

      /** The ID of the file within the vector store. */
      @path
      file_id: string;
    },
    OpenAI.VectorStoreFileContentResponse
  >;

  /** Searches the specified vector store for chunks relevant to the provided query and filters. */
  @route("{vector_store_id}/search")
  @post
  @summary("Search a vector store")
  searchVectorStore is OpenAIOperation<
    {
      /** The ID of the vector store to search. */
      @path
      vector_store_id: string;

      @body
      body: OpenAI.VectorStoreSearchRequest;
    },
    OpenAI.VectorStoreSearchResultsPage
  >;
}
