# Basic sanity test to verify that the deployed index functionality.

import numpy as np

# Random vector for testing
embedding = np.random.rand(1536).tolist()

DEPLOY_INDEX_ID = "sage_index_005_deployed"

response = endpoint.find_neighbors(
    deployed_index_id= DEPLOY_INDEX_ID,
    queries=[embedding],
    num_neighbors=1,
)

print("Sanity test query result:", response) #response will be empty for now, bcoz the index is empty. We just want to verify that the deployed index can be queried without error.