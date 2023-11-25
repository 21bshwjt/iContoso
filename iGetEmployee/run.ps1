using namespace System.Net
param($Request, $TriggerMetadata)
$employees = Get-Content .\database\employees.json | ConvertFrom-Json
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'application\json' }
        StatusCode = [httpstatuscode]::OK
        Body       = $employees
    })