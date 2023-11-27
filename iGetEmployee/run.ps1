using namespace System.Net
param($Request, $TriggerMetadata)

# Replace these values with your actual Azure Storage Account details
$storageAccountName = "fnstorageacct01"
$containerName = "testcon"
$blobName = "yourfile.json"
$resourceGroupName = "dadaops_rg"

# Get the storage account key
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -AccountName $storageAccountName)[0].Value

# Create a storage context
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Get the JSON content from the blob
$jsonContent = Get-AzStorageBlobContent -Container $containerName -Blob $blobName -Context $ctx


$employees = Get-Content $jsonContent.Name | ConvertFrom-Json
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'application\json' }
        StatusCode = [httpstatuscode]::OK
        Body       = $employees
    })