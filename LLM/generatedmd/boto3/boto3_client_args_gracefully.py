session_token = os.getenv("AWS_SESSION_TOKEN")  # Optional

boto3_args = {
    "service_name": "bedrock-runtime",
    "region_name": aws_region,
    "aws_access_key_id": aws_access_key_id,
    "aws_secret_access_key": aws_secret_access_key,
}

if session_token:
    boto3_args["aws_session_token"] = session_token

bedrock = boto3.client(**boto3_args)
