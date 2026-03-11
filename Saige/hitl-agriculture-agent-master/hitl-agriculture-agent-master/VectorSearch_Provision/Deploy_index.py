from google.cloud import aiplatform
from google.api_core.exceptions import NotFound

#==============================================================
# CONFIG
#===============================================================

PROJECT_ID = "animated-flare-421518"
REGION = "us-central1"      

INDEX_DISPLAY_NAME = "sage_index_005"
ENDPOINT_DISPLAY_NAME = "sage-index-endpoint"
ENDPOINT_RESOURCE_NAME = "projects/802455386518/locations/us-central1/indexEndpoints/2337590307954098176"



#==============================================================
# INTI
#==============================================================

aiplatform.init(project=PROJECT_ID, location=REGION)
print("Initialized AI Platform with project:", PROJECT_ID, "and region:", REGION)

#==============================================================
# GET EXISTING INDEX
#==============================================================
indexes = aiplatform.MatchingEngineIndex.list(filter=f"display_name={INDEX_DISPLAY_NAME}")
if not indexes:
    raise ValueError(f"No index found with display name: {INDEX_DISPLAY_NAME}")
index = indexes[0]
print("Found index:", index.resource_name)

#==============================================================
# GET EXISTING ENDPOINT
#==============================================================
try:
    endpoint = aiplatform.MatchingEngineIndexEndpoint(endpoint_resource_name=ENDPOINT_RESOURCE_NAME)

    # Force fetch to check if the endpoint exists
    _ = endpoint.gca_resource
    print("Found endpoint:", endpoint.resource_name)
except NotFound:
    print("Endpoint not found. creating new endpoint...")
    endpoint = aiplatform.MatchingEngineIndexEndpoint.create(
        display_name=ENDPOINT_DISPLAY_NAME,
        project=PROJECT_ID,
        location=REGION,
        public_endpoint_enabled=True,
    )
    print("Endpoint created:", endpoint.resource_name)
    
#==============================================================
# DEPLOY INDEX TO ENDPOINT
#==============================================================

endpoint = aiplatform.MatchingEngineIndexEndpoint(endpoint.resource_name)

already_deployed = False

for deployed_index in endpoint.deployed_indexes:
    if deployed_index.index_resource_name == index.resource_name:
        already_deployed = True
        print(f"Index {index.display_name} is already deployed to endpoint {endpoint.display_name}.")
        break
if already_deployed:
    print("Index is already deployed. No action needed.")
else:
    print(f"Deploying index {index.display_name} to endpoint {endpoint.display_name}...")
    endpoint.deploy_index(
        index=index,
        deployed_index_id=f"{INDEX_DISPLAY_NAME}_deployed",
    )
    print("Deployment initiated. This may take a few minutes.")
    print("Index deployed successfully to endpoint:", endpoint.display_name)

print ("\nDone")