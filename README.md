# "Chat with your data" Solution Accelerator  

Welcome to the "Chat with your data" Solution Accelerator repository!
The "Chat with your data" Solution Accelerator is a powerful tool that combines the capabilities of Azure Cognitive Search and Large Language Models (LLMs) to create a conversational search experience. This solution accelerator uses an Azure OpenAI GPT model and an Azure Cognitive Search index generated from your data, which is integrated into a web application to provide a natural language interface for search queries.

![A screenshot of the accelerator architecture.](media/architecture.png)

This repository provides a template for setting up the solution accelerator, along with detailed instructions on how to use and customize it to fit your specific needs.

## About this repo

This repository provides a template for setting up the solution accelerator, along with detailed instructions on how to use and customize it to fit your specific needs. It provides the following features:

* Chat with an Azure OpenAI model using your own data
* Upload and process your documents
* Index public web pages
* Easy prompt configuration
* Multiple chunking strategies

## When should you use this repo? 

You should use this repo when your scenario customization needs exceed the out-of-the-box experience offered by [Azure OpenAI on your data](https://learn.microsoft.com/azure/ai-services/openai/concepts/use-your-data) and you don't require to streamline the entire development cycle of your AI application, as you can with [Azure Machine Learning prompt flow](https://learn.microsoft.com/en-us/azure/machine-learning/prompt-flow/overview-what-is-prompt-flow). 

The accelerator presented here provides several options, for example:
* The ability to ground a model using both data and public web pages
* Advanced prompt engineering capabilities
* An admin site for ingesting/inspecting/configuring your dataset on the fly
* Running a Retrieval Augmented Generation (RAG) solution locally, as a Docker container

*Have you seen [ChatGPT + Enterprise data with Azure OpenAI and Cognitive Search demo](https://github.com/Azure-Samples/azure-search-openai-demo)? If you would like to play with prompts, understanding RAG pattern different implementation approaches and similar demo tasks, take a look at that repo. Note that the demo in that repo should not be used in Proof of Concepts (POCs) that later will be adapted for production environments. Instead, consider the use of this repo and follow the best practices outlines in this repo.

Here is a comparison table with a few features offered by Azure, an available GitHub demo sample and this repo, that can provide guidance when you need to decide which one to use:

| Name	| Feature or Sample? |	What is it? | When to use? |
| ---------|---------|---------|---------|
|[Azure OpenAI on your data](https://learn.microsoft.com/azure/ai-services/openai/concepts/use-your-data) | Azure feature | Azure OpenAI Service offers out-of-the-box, end-to-end RAG implementation that uses a REST API or the web-based interface in the Azure AI Studio to create a solution that connects to your data to enable an enhanced chat experience with Azure OpenAI ChatGPT models and Azure Cognitive Search. | This should be the first option considered for developers that need an end-to-end solution for Azure OpenAI Service with an Azure Cognitive Search retriever. Simply select supported data sources, that ChatGPT model in Azure OpenAI Service , and any other Azure resources needed to configure your enterprise application needs. |
|[Azure Machine Learning prompt flow](https://learn.microsoft.com/azure/machine-learning/concept-retrieval-augmented-generation)	| Azure feature | RAG in Azure Machine Learning is enabled by integration with Azure OpenAI Service for large language models and vectorization. It includes support for Faiss and Azure Cognitive Search as vector stores, as well as support for open-source offerings, tools, and frameworks such as LangChain for data chunking. Azure Machine Learning prompt flow offers the ability to test data generation, automate prompt creation, visualize prompt evaluation metrics, and integrate RAG workflows into MLOps using pipelines.  | When Developers need more control over processes involved in the development cycle of LLM-based AI applications, they should use Azure Machine Learning prompt flow to create executable flows and evaluate performance through large-scale testing. |
|["Chat with your data" Solution Accelerator](https://aka.ms/ChatWithYourDataSolutionAccelerator) - (This repo)	| Azure sample | End-to-end baseline RAG pattern sample that uses Azure Cognitive Search as a retriever.	| This sample should be used by Developers when the  RAG pattern implementations provided by Azure are not able to satisfy business requirements. This sample provides a means to customize the solution. Developers must add their own code to meet requirements, and adapt with best practices according to individual company policies. |
|[ChatGPT + Enterprise data with Azure OpenAI and Cognitive Search demo](https://github.com/Azure-Samples/azure-search-openai-demo) | Azure sample | RAG pattern demo that uses Azure Cognitive Search as a retriever. | Developers who would like to use or present an end-to-end demonstration of the RAG pattern should use this sample. This includes the ability to deploy and test different retrieval modes, and prompts to support business use cases. |


## Supported file types

Out-of-the-box, you can upload the following file types:
* PDF
* JPEG
* JPG
* PNG
* TXT
* HTML
* MD (Markdown)
* DOCX

## Prerequisites

* Azure subscription - [Create one for free](https://azure.microsoft.com/free/) with contributor access.
* An [Azure OpenAI resource](https://learn.microsoft.com/azure/ai-services/openai/how-to/create-resource?pivots=web-portal) and a deployment for one of the following Chat model and an embedding model:
    * Chat Models
       * GPT-3.5
       * GPT-4
  * Embedding Model 
     * text-embedding-ada-002
    
  **NOTE**: The deployment template defaults to **gpt-35-turbo** and **text-embedding-ada-002**. If your deployment names are different, update them in the deployment process.

## Getting started

1. Click the following deployment button to create the required resources for this accelerator directly in your Azure Subscription. 

    [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fgithub.com%2FAzure-Samples%2Fazure-search-openai-solution-accelerator%2Fblob%2Fmain%2Finfrastructure%2Fdeployment.json)

    

1. Add the following fields:

    
    |Field  |Description  |
    |---------|---------|
    |Resource group   | The resource group that will contain the resources for this accelerator. You can select **Create new** to create a new group.        |
    |Resource prefix   | A text string that will be appended to each resource that gets created, and used as the website name for the web app. This name cannot contain spaces or special characters.        |
    |Azure OpenAI resource    | The name of your Azure OpenAI resource. This resource must have already been created previously.         |
    |Azure OpenAI key    | The access key associated with your Azure OpenAI resource.        |
    |Orchestration strategy| Use Azure OpenAI Functions (openai_functions) or LangChain (langchain) for messages orchestration. If you are using a new model version 0613 select "openai_functions" (or "langchain"), if you are using a 0314 model version select "langchain"|
    
    You can find the [ARM template](./infrastructure/deployment.json) used, along with a [Bicep file](./infrastructure/deployment.bicep) for deploying this accelerator in the `/infrastructure` directory.

   **NOTE**: By default, the deployment name in the application settings is equal to the model name (gpt-35-turbo and text-embedding-ada-002). If you named the deployment in a different way, you should update the application settings to match your deployment names.
    
1. Navigate to the admin site, where you can upload documents. It will be located at:
    
    `https://{MY_RESOURCE_PREFIX}-website-admin.azurewebsites.net/`

    Where `{MY_RESOURCE_PREFIX}` is replaced with the resource prefix you used during deployment. Then select **Ingest Data** and add your data. You can find sample data in the `/data` directory.
    
    ![A screenshot of the admin site.](./media/admin-site.png)


2. Navigate to the web app to start chatting on top of your data. The web app can be found at:

    `https://{MY_RESOURCE_PREFIX}-website.azurewebsites.net/`

    Where `{MY_RESOURCE_PREFIX}` is replaced with the resource prefix you used during deployment. 

    
    ![A screenshot of the chat app.](./media/chat-app.png)

## Develoy with Azure Developer CLI
Then bring down the project code:

1. Create a new folder and switch to it in the terminal
1. Run `azd auth login`
1. Run `azd init -t azure-search-openai-demo`
    * note that this command will initialize a git repository and you do not need to clone this repository

### Deploying from scratch

Execute the following command, if you don't have any pre-existing Azure services and want to start from a fresh deployment.

1. Run `azd up` - This will provision Azure resources and deploy this sample to those resources, including building the search index based on the files found in the `./data` folder.
    * **Important**: Beware that the resources created by this command will incur immediate costs, primarily from the Cognitive Search resource. These resources may accrue costs even if you interrupt the command before it is fully executed. You can run `azd down` or delete the resources manually to avoid unnecessary spending.
    * You will be prompted to select two locations, one for the majority of resources and one for the OpenAI resource, which is currently a short list. That location list is based on the [OpenAI model availability table](https://learn.microsoft.com/azure/cognitive-services/openai/concepts/models#model-summary-table-and-region-availability) and may become outdated as availability changes.
1. After the application has been successfully deployed you will see a URL printed to the console.  Click that URL to interact with the application in your browser.
It will look like the following:

!['Output from running azd up'](docs/endpoint.png)

> NOTE: It may take 5-10 minutes for the application to be fully deployed. If you see a "Python Developer" welcome screen or an error page, then wait a bit and refresh the page.

### Deploying with existing Azure resources

If you already have existing Azure resources, you can re-use those by setting `azd` environment values.

#### Existing resource group

1. Run `azd env set AZURE_RESOURCE_GROUP {Name of existing resource group}`
1. Run `azd env set AZURE_LOCATION {Location of existing resource group}`

#### Existing OpenAI resource

##### Azure OpenAI:

1. Run `azd env set AZURE_OPENAI_SERVICE {Name of existing OpenAI service}`
1. Run `azd env set AZURE_OPENAI_RESOURCE_GROUP {Name of existing resource group that OpenAI service is provisioned to}`
1. Run `azd env set AZURE_OPENAI_CHATGPT_DEPLOYMENT {Name of existing ChatGPT deployment}`. Only needed if your ChatGPT deployment is not the default 'chat'.
1. Run `azd env set AZURE_OPENAI_EMB_DEPLOYMENT {Name of existing GPT embedding deployment}`. Only needed if your embeddings deployment is not the default 'embedding'.

When you run `azd up` after and are prompted to select a value for `openAiResourceGroupLocation`, make sure to select the same location as the existing OpenAI resource group.

##### Openai.com OpenAI:

1. Run `azd env set OPENAI_HOST openai`
2. Run `azd env set OPENAI_ORGANIZATION {Your OpenAI organization}`
3. Run `azd env set OPENAI_API_KEY {Your OpenAI API key}`
4. Run `azd up`

You can retrieve your OpenAI key by checking [your user page](https://platform.openai.com/account/api-keys) and your organization by navigating to [your organization page](https://platform.openai.com/account/org-settings).
Learn more about creating an OpenAI free trial at [this link](https://openai.com/pricing).
Do *not* check your key into source control.

When you run `azd up` after and are prompted to select a value for `openAiResourceGroupLocation`, you can select any location as it will not be used.


#### Existing Azure Cognitive Search resource

1. Run `azd env set AZURE_SEARCH_SERVICE {Name of existing Azure Cognitive Search service}`
1. Run `azd env set AZURE_SEARCH_SERVICE_RESOURCE_GROUP {Name of existing resource group with ACS service}`
1. If that resource group is in a different location than the one you'll pick for the `azd up` step,
  then run `azd env set AZURE_SEARCH_SERVICE_LOCATION {Location of existing service}`
1. If the search service's SKU is not standard, then run `azd env set AZURE_SEARCH_SERVICE_SKU {Name of SKU}`. The free tier won't work as it doesn't support managed identity. ([See other possible values](https://learn.microsoft.com/azure/templates/microsoft.search/searchservices?pivots=deployment-language-bicep#sku))
1. If you have an existing index that is set up with all the expected fields, then run `azd env set AZURE_SEARCH_INDEX {Name of existing index}`. Otherwise, the `azd up` command will create a new index.

You can also customize the search service (new or existing) for non-English searches:

1. To configure the language of the search query to a value other than "en-us", run `azd env set AZURE_SEARCH_QUERY_LANGUAGE {Name of query language}`. ([See other possible values](https://learn.microsoft.com/python/api/azure-search-documents/azure.search.documents.models.querylanguage?view=azure-python-preview))
1. To turn off the spell checker, run `azd env set AZURE_SEARCH_QUERY_SPELLER none`. ([See other possible values](https://learn.microsoft.com/python/api/azure-search-documents/azure.search.documents.models.queryspellertype?view=azure-python-preview))
1. To configure the name of the analyzer to use for a searchable text field to a value other than "en.microsoft", run `azd env set AZURE_SEARCH_ANALYZER_NAME {Name of analyzer name}`. ([See other possible values](https://learn.microsoft.com/dotnet/api/microsoft.azure.search.models.field.analyzer?view=azure-dotnet-legacy&viewFallbackFrom=azure-dotnet))

#### Other existing Azure resources

You can also use existing Form Recognizer and Storage Accounts. See `./infra/main.parameters.json` for list of environment variables to pass to `azd env set` to configure those existing resources.

#### Provision remaining resources

Now you can run `azd up`, following the steps in [Deploying from scratch](#deploying-from-scratch) above.
That will both provision resources and deploy the code.


### Deploying again

If you've only changed the backend/frontend code in the `app` folder, then you don't need to re-provision the Azure resources. You can just run:

```azd deploy```

If you've changed the infrastructure files (`infra` folder or `azure.yaml`), then you'll need to re-provision the Azure resources. You can do that by running:

```azd up```

## Development and run the accelerator locally

To customize the accelerator or run it locally, first, copy the `.env.sample` file to your development environment's `.env` file, and edit it according to [environment variable values table](#environment-variables) below.

### Running the full solution locally

You can run the full solution locally with the following commands - this will spin up 3 different Docker containers:

|Container  |Description  |
|---------|---------|
|frontend | A container for the chat app, enabling you to chat on top of your data.         |
|backend     | A container for the "admin" site where you can upload and explore your data.         |
|batch processing functions     | A container helping with processing requests.          |

Run the following `docker compose` command.

```shell
cd docker
docker compose up
```

### Develop & run the frontend locally

For faster development, you can run the frontend Typescript React UI app and the Python Flask app in development mode. This allows the app to "hot reload" meaning your changes will automatically be reflected in the app without having to refresh or restart the local servers. 

To run the app locally with hot refresh, first follow the instructions to [update your .env file with the needed values](#develop--run-the-frontend-locally).

#### Starting the Flask app in dev mode
Open a terminal and enter the following commands
```shell
python -m pip install -r requirements.txt
python -m flask --app ./app.py --debug run
```

#### Starting the Typescript React app in dev mode
Open a new separate terminal and enter the following commands:
```shell
cd frontend
npm install
npm run dev
```
The local vite server will return a url that you can use to access the chat interface locally, such as  `http://localhost:5174/`.

#### Building the frontend Docker image

```shell
docker build -f docker\WebApp.Dockerfile -t YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE .
docker run --env-file .env -p 8080:80 YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE
docker push YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE
```

### Develop & run the backend

If you want to develop and run the backend container locally, use the following commands.

#### Running the backend locally

```shell
cd backend
python -m pip install -r requirements.txt
streamlit run Admin.py
```

Then access `http://localhost:8501/` for getting to the admin interface.

#### Building the backend Docker image

```shell
docker build -f docker\AdminWebApp.Dockerfile -t YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE .
docker run --env-file .env -p 8081:80 YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE
docker push YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE
```

### Develop & run the batch processing functions

If you want to develop and run the batch processing functions container locally, use the following commands.

#### Running the batch processing locally

First, install [Azure Functions Core Tools](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=windows%2Cportal%2Cv2%2Cbash&pivots=programming-language-python).


```shell
cd backend
func start
```

Or use the [Azure Functions VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions).

#### Building the batch processing Docker image

```shell
docker build -f docker\Backend.Dockerfile -t YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE .
docker run --env-file .env -p 7071:80 YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE
docker push YOUR_DOCKER_REGISTRY/YOUR_DOCKER_IMAGE
```

## Environment variables

| App Setting | Value | Note |
| --- | --- | ------------- |
|AZURE_SEARCH_SERVICE||The URL of your Azure Cognitive Search resource. e.g. https://<search-service>.search.windows.net|
|AZURE_SEARCH_INDEX||The name of your Azure Cognitive Search Index|
|AZURE_SEARCH_KEY||An **admin key** for your Azure Cognitive Search resource|
|AZURE_SEARCH_USE_SEMANTIC_SEARCH|False|Whether or not to use semantic search|
|AZURE_SEARCH_SEMANTIC_SEARCH_CONFIG||The name of the semantic search configuration to use if using semantic search.|
|AZURE_SEARCH_TOP_K|5|The number of documents to retrieve from Azure Cognitive Search.|
|AZURE_SEARCH_ENABLE_IN_DOMAIN|True|Limits responses to only queries relating to your data.|
|AZURE_SEARCH_CONTENT_COLUMNS||List of fields in your Azure Cognitive Search index that contains the text content of your documents to use when formulating a bot response. Represent these as a string joined with "|", e.g. `"product_description|product_manual"`|
|AZURE_SEARCH_CONTENT_VECTOR_COLUMNS||Field from your Azure Cognitive Search index for storing the content's Vector embeddings|
|AZURE_SEARCH_DIMENSIONS|1536| Azure OpenAI Embeddings dimensions. 1536 for `text-embedding-ada-002`|
|AZURE_SEARCH_FIELDS_ID|id|`AZURE_SEARCH_FIELDS_ID`: Field from your Azure Cognitive Search index that gives a unique idenitfier of the document chunk. `id` if you don't have a specific requirement.|
|AZURE_SEARCH_FILENAME_COLUMN||`AZURE_SEARCH_FILENAME_COLUMN`: Field from your Azure Cognitive Search index that gives a unique idenitfier of the source of your data to display in the UI.|
|AZURE_SEARCH_TITLE_COLUMN||Field from your Azure Cognitive Search index that gives a relevant title or header for your data content to display in the UI.|
|AZURE_SEARCH_URL_COLUMN||Field from your Azure Cognitive Search index that contains a URL for the document, e.g. an Azure Blob Storage URI. This value is not currently used.|
|AZURE_SEARCH_FIELDS_TAG|tag|Field from your Azure Cognitive Search index that contains tags for the document. `tag` if you don't have a specific requirement.|
|AZURE_SEARCH_FIELDS_METADATA|metadata|Field from your Azure Cognitive Search index that contains metadata for the document. `metadata` if you don't have a specific requirement.|
|AZURE_OPENAI_RESOURCE||the name of your Azure OpenAI resource|
|AZURE_OPENAI_MODEL||The name of your model deployment|
|AZURE_OPENAI_MODEL_NAME|gpt-35-turbo|The name of the model|
|AZURE_OPENAI_KEY||One of the API keys of your Azure OpenAI resource|
|AZURE_OPENAI_EMBEDDING_MODEL|text-embedding-ada-002|The name of you Azure OpenAI embeddings model deployment|
|AZURE_OPENAI_TEMPERATURE|0|What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. A value of 0 is recommended when using your data.|
|AZURE_OPENAI_TOP_P|1.0|An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. We recommend setting this to 1.0 when using your data.|
|AZURE_OPENAI_MAX_TOKENS|1000|The maximum number of tokens allowed for the generated answer.|
|AZURE_OPENAI_STOP_SEQUENCE||Up to 4 sequences where the API will stop generating further tokens. Represent these as a string joined with "|", e.g. `"stop1|stop2|stop3"`|
|AZURE_OPENAI_SYSTEM_MESSAGE|You are an AI assistant that helps people find information.|A brief description of the role and tone the model should use|
|AZURE_OPENAI_API_VERSION|2023-06-01-preview|API version when using Azure OpenAI on your data|
|AzureWebJobsStorage||The connection string to the Azure Blob Storage for the Azure Functions Batch processing|
|BACKEND_URL||The URL for the Backend Batch Azure Function. Use http://localhost:7071 for local execution and http://backend for docker compose|
|DOCUMENT_PROCESSING_QUEUE_NAME|doc-processing|The name of the Azure Queue to handle the Batch processing|
|AZURE_BLOB_ACCOUNT_NAME||The name of the Azure Blob Storage for storing the original documents to be processed|
|AZURE_BLOB_ACCOUNT_KEY||The key of the Azure Blob Storage for storing the original documents to be processed|
|AZURE_BLOB_CONTAINER_NAME||The name of the Container in the Azure Blob Storage for storing the original documents to be processed|
|AZURE_FORM_RECOGNIZER_ENDPOINT||The name of the Azure Form Recognizer for extracting the text from the documents|
|AZURE_FORM_RECOGNIZER_KEY||The key of the Azure Form Recognizer for extracting the text from the documents|
|APPINSIGHTS_CONNECTION_STRING||The Application Insights connection string to store the application logs|
|ORCHESTRATION_STRATEGY | openai_functions | Orchestration strategy. Use Azure OpenAI Functions (openai_functions) or LangChain (langchain) for messages orchestration. If you are using a new model version 0613 select "openai_functions" (or "langchain"), if you are using a 0314 model version select "langchain" |


## Resources used in this solution

This solution accelerator deploys the following resources. It's crucial to comprehend the functionality of each. Below are the links to their respective documentation:
- [Azure OpenAI Service Documentation](https://learn.microsoft.com/azure/ai-services/openai/)
- [Azure Cognitive Search Documentation](https://learn.microsoft.com/azure/search/)
- [Azure Blob Storage Documentation](https://learn.microsoft.com/azure/storage/blobs/)
- [Azure Functions Documentation](https://learn.microsoft.com/azure/azure-functions/)
- [Azure AI Document Intelligence Documentation](https://learn.microsoft.com/azure/ai-services/document-intelligence/)
- [Azure App Service Documentation](https://learn.microsoft.com/azure/app-service/)


## Pricing Considerations

This solution accelerator deploys multiple resources. Evaluate the cost of each component prior to deployment.

The following are links to the pricing details for some of the resources:
- [Azure OpenAI service pricing](https://azure.microsoft.com/pricing/details/cognitive-services/openai-service/). GPT and embedding models are charged separately.
- [Azure Cognitive Search pricing](https://azure.microsoft.com/pricing/details/search/). Cognitive Search core service and semantic search are charged separately.
- [Azure Blob Storage pricing](https://azure.microsoft.com/pricing/details/storage/blobs/)
- [Azure Functions pricing](https://azure.microsoft.com/pricing/details/functions/)
- [Azure AI Document Intelligence pricing](https://azure.microsoft.com/pricing/details/ai-document-intelligence/)
- [Azure Web App Pricing](https://azure.microsoft.com/pricing/details/app-service/windows/)


## Azure Cognitive Search used as retriever in RAG

Azure Cognitive Search, when used as a retriever in the Retrieval-Augmented Generation (RAG) pattern, plays a key role in fetching relevant information from a large corpus of data. The RAG pattern involves two key steps: retrieval of documents and generation of responses. Azure Cognitive Search, in the retrieval phase, filters and ranks the most relevant documents from the dataset based on a given query.

The importance of optimizing data in the index for relevance lies in the fact that the quality of retrieved documents directly impacts the generation phase. The more relevant the retrieved documents are, the more accurate and pertinent the generated responses will be.

Azure Cognitive Search allows for fine-tuning the relevance of search results through features such as [scoring profiles](https://learn.microsoft.com/azure/search/index-add-scoring-profiles), which assign weights to different fields, [Lucene's powerful full-text search capabilities](https://learn.microsoft.com/azure/search/query-lucene-syntax), [vector search](https://learn.microsoft.com/azure/search/vector-search-overview) for similarity search, multi-modal search, recommendations, [hybrid search](https://learn.microsoft.com/azure/search/hybrid-search-overview) and [semantic search](https://learn.microsoft.com/azure/search/search-get-started-semantic) to use AI from Microsoft to rescore search results and moving results that have more semantic relevance to the top of the list. By leveraging these features, one can ensure that the most relevant documents are retrieved first, thereby improving the overall effectiveness of the RAG pattern.

Moreover, optimizing the data in the index also enhances the efficiency, the speed of the retrieval process and increases relevance which is an integral part of the RAG pattern.



## Best practices specific to Azure Cognitive Search
- Consider switching security keys and using [RBAC](https://learn.microsoft.com/azure/search/search-security-rbac) instead for authentication.
- Consider setting up a [firewall](https://learn.microsoft.com/azure/search/service-configure-firewall), [private endpoints](https://learn.microsoft.com/azure/search/service-create-private-endpoint) for inbound connections and [shared private links](https://learn.microsoft.com/azure/search/search-indexer-howto-access-trusted-service-exception) for [built-in pull indexers](https://learn.microsoft.com/en-us/azure/search/search-indexer-overview).
- For the best results, prepare your index data and consider [analyzers](https://learn.microsoft.com/azure/search/search-analyzers).
- Analyze your [resource capacity needs](https://learn.microsoft.com/azure/search/search-capacity-planning).



## Best practices before deploying Azure RAG implementations to production
- Follow the best practices described in [Azure Well-Architected-Framework](https://learn.microsoft.com/azure/well-architected/).
- Understand the [Retrieval Augmented Generation (RAG) in Azure Cognitive Search](https://learn.microsoft.com/en-us/azure/search/retrieval-augmented-generation-overview).
- Understand the [functionality and configuration that would adapt better to your solution](https://techcommunity.microsoft.com/t5/azure-ai-services-blog/azure-cognitive-search-outperforming-vector-search-with-hybrid/ba-p/3929167) and test with your own data for optimal retrieval.
- Experiment with different options, define the prompts that are optimal for your needs and find ways to implement functionality tailored to your business needs with [this demo](https://github.com/Azure-Samples/azure-search-openai-demo), so you can then adapt to the accelerator.
- Follow the [Responsible AI best practices](https://www.microsoft.com/en-us/ai/tools-practices).
- Understand the [levels of access of your users and application](https://techcommunity.microsoft.com/t5/azure-ai-services-blog/access-control-in-generative-ai-applications-with-azure/ba-p/3956408).


## Chunking: Importance for RAG and strategies implemented as part of this repo

Chunking is essential for managing large data sets, optimizing relevance, preserving context, integrating workflows, and enhancing the user experience. See [How to chunk documents](https://learn.microsoft.com/en-us/azure/search/vector-search-how-to-chunk-documents) for more information.

These are the chunking strategy options you can choose from:
- **Layout**: An AI approach to determine a good chunking strategy.
-  **Page**: This strategy involves breaking down long documents into pages.
- **Fixed-Size Overlap**: This strategy involves defining a fixed size that’s sufficient for semantically meaningful paragraphs (for example, 250 words) and allows for some overlap (for example, 10-25% of the content). This usually helps creating good inputs for embedding vector models. Overlapping a small amount of text between chunks can help preserve the semantic context.
-  **Paragraph**: This strategy allows breaking down a difficult text into more manageable pieces and rewrite these “chunks” with a summarization of all of them.


## Licensing

This repository is licensed under the [MIT License](LICENSE.md).

The data set under the /data folder is licensed under the [CDLA-Permissive-2 License](CDLA-Permissive-2.md).


## Data Set

The data set under the /data folder has been generated with Azure OpenAI GPT and DALL-E 2 models.

# DISCLAIMER
This presentation, demonstration, and demonstration model are for informational purposes only and (1) are not subject to SOC 1 and SOC 2 compliance audits, and (2) are not designed, intended or made available as a medical device(s) or as a substitute for professional medical advice, diagnosis, treatment or judgment. Microsoft makes no warranties, express or implied, in this presentation, demonstration, and demonstration model. Nothing in this presentation, demonstration, or demonstration model modifies any of the terms and conditions of Microsoft’s written and signed agreements. This is not an offer and applicable terms and the information provided are subject to revision and may be changed at any time by Microsoft.

This presentation, demonstration, and demonstration model do not give you or your organization any license to any patents, trademarks, copyrights, or other intellectual property covering the subject matter in this presentation, demonstration, and demonstration model.

The information contained in this presentation, demonstration and demonstration model represents the current view of Microsoft on the issues discussed as of the date of presentation and/or demonstration, for the duration of your access to the demonstration model. Because Microsoft must respond to changing market conditions, it should not be interpreted to be a commitment on the part of Microsoft, and Microsoft cannot guarantee the accuracy of any information presented after the date of presentation and/or demonstration and for the duration of your access to the demonstration model.

No Microsoft technology, nor any of its component technologies, including the demonstration model, is intended or made available as a substitute for the professional advice, opinion, or judgment of (1) a certified financial services professional, or (2) a certified medical professional. Partners or customers are responsible for ensuring the regulatory compliance of any solution they build using Microsoft technologies.
