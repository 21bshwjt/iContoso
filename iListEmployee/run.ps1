using namespace System.Net
param($Request, $TriggerMetadata)
$body = html -Content {
    head -Content {
        title -Content "Contoso Employee"
    }
    body -Content {
        $employees = Get-Content .\database\employees.json | ConvertFrom-Json
        table -Content {
            Thead -Content {
                th -Content "First Name"
                th -Content "Last Name"
                th -Content "Department"
                th -Content "Country"
            }
            Tbody -Content {
                foreach($employee in $employees.employees) {
                    tr -Content {
                        td -Content $employee.firstname
                        td -Content $employee.lastname
                        td -Content $employee.department
                        td -Content $employee.country
                    }
                }
            }
        }
    }
}
# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    headers = @{'content-type' = 'text/html'}
    StatusCode = [httpstatuscode]::OK
    Body = $body
})