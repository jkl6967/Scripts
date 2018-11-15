#Read-SqlTableData output formats:
#    -- DataSet. An object of type System.Data.DataSet that contains one table. 
#    -- DataTable. An object of type System.Data.DataTable. The TableName property of this object is the same as the table that this cmdlet queries. 
#    -- DataRows. A collection of System.Data.DateRow objects.
#A simple way to access a column's value and return as string is to use .Item(n) member
#Can use cmdlet in Windows PowerShell
#& is the call operator runs a command, script or script block.  a good example is
#    $j = "get-executionpolicy"
#    $j
#    returns get-executionpolicy
#    & $j
#    returns AllSigned

$fileArray = {$targetArray = Get-Content c:\temp\UPDATEHOSP7daysbackPGPRD20181107.txt | foreach {$_.Split("$")}; foreach($row in $targetArray) {$targetRow = $row.Split(","); $targetRow[3]}}

& $fileArray

$tableArray = Read-SqlTableData -ServerInstance "ODWV8087\SQL2_VD_EPICDW" -Database "NED" -SchemaName "dbo" -Table "Dly_Unit_Hospitalist" -ColumnName "pat_enc_csn_id" | foreach {$_.Item(0).ToString()}

$Same = $fileArray | Where {$tableArray -Contains $_}

$Same