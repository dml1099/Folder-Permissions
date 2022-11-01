#Script to retrive permissions of a defined share path.
#Creates CSV file with results

$FolderPath = Get-ChildItem -Directory -Path "FolderPath"  -Force #-Recurse 
#Use Recurse to retrive permissions below targeted dircetory
$Report = @()
Foreach ($Folder in $FolderPath) {
    $Acl = Get-Acl -Path $Folder.FullName
    foreach ($Access in $acl.Access)
        {
            $Properties = [ordered]@{
                        'FolderName'=$Folder.FullName;
                        'AD Group or User'=$Access.IdentityReference;
                        'Permissions'=$Access.FileSystemRights;
                        'Inherited'=$Access.IsInherited
                                    }
            $Report += New-Object -TypeName PSObject -Property $Properties
        }
}
#Make .CSV
$clientName=HOSTNAME.EXE
$Report | Export-Csv -notype -path "PathForCSV"