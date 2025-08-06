The `invoke_model` method in Amazon Bedrock's Boto3 client is used to perform inference by sending a prompt and associated parameters to a specified model. Here's a breakdown of what this method expects:([Boto3][1])

---

### Required Parameters

1. **`body`**: A JSON-formatted string containing the prompt and any inference parameters specific to the model you're invoking. This should be encoded as bytes. For example:

   ```python
   body = json.dumps({
       "prompt": prompt,
       "max_tokens_to_sample": 200,
       "temperature": 0.5,
       "top_k": 250,
       "top_p": 1,
       "stop_sequences": ["\n\nHuman:"]
   }).encode('utf-8')
   ```



The specific fields within the body can vary depending on the model. It's essential to refer to the model's documentation to ensure correct parameters are used.&#x20;

2. **`modelId`**: A string that uniquely identifies the model you wish to invoke. This can be the model's ID or its Amazon Resource Name (ARN). The exact value depends on the type of model (e.g., base model, provisioned model, imported model). ([Boto3][2])

---

### Optional Parameters

* **`contentType`**: Specifies the MIME type of the input data. For JSON input, set this to `"application/json"`.

* **`accept`**: Indicates the desired MIME type of the response. Typically, this is set to `"application/json"`.

* **`trace`**: Determines whether to enable tracing for the invocation. Possible values include `"ENABLED"`, `"DISABLED"`, and `"ENABLED_FULL"`.([Boto3][1])

* **`guardrailIdentifier`** and **`guardrailVersion`**: If you wish to apply a guardrail to the invocation, specify its identifier and version here.([AWS Documentation][3])

* **`performanceConfigLatency`**: Allows you to choose between `"standard"` and `"optimized"` latency configurations.

---

### Example Usage

```python
import boto3
import json

# Initialize the Bedrock Runtime client
bedrock = boto3.client("bedrock-runtime", region_name="your-region")

# Define the prompt and parameters
prompt = "Your prompt here"
body = json.dumps({
    "prompt": prompt,
    "max_tokens_to_sample": 200,
    "temperature": 0.5,
    "top_k": 250,
    "top_p": 1,
    "stop_sequences": ["\n\nHuman:"]
}).encode('utf-8')

# Invoke the model
response = bedrock.invoke_model(
    body=body,
    modelId="your-model-id",
    accept="application/json",
    contentType="application/json"
)

# Process the response
result = json.loads(response['body'].read())
print(result)
```



Ensure that you replace `"your-region"` and `"your-model-id"` with the appropriate values for your use case.

---

For more detailed information on the `invoke_model` method and its parameters, refer to the Boto3 documentation. ([Boto3][2])

[1]: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/bedrock-runtime/client/invoke_model.html?utm_source=chatgpt.com "invoke_model - Boto3 1.37.38 documentation"
[2]: https://boto3.amazonaws.com/v1/documentation/api/1.35.24/reference/services/bedrock-runtime/client/invoke_model.html?utm_source=chatgpt.com "invoke_model - Boto3 1.35.24 documentation - AWS"
[3]: https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_InvokeModel.html?utm_source=chatgpt.com "InvokeModel - Amazon Bedrock - AWS Documentation"
