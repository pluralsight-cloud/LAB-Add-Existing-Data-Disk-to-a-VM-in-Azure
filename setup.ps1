# Find the new RAW disk
$disk = Get-Disk | Where-Object PartitionStyle -Eq 'RAW'
Initialize-Disk -Number $disk.Number -PartitionStyle MBR -PassThru |
    New-Partition -AssignDriveLetter -UseMaximumSize |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel "DataDisk" -Confirm:$false

# Get drive letter
$driveLetter = ($disk | Get-Partition | Get-Volume).DriveLetter

# Copy file from extension download directory to data disk
Copy-Item -Path ".\myfile.txt" -Destination "$($driveLetter):\myfile.txt"
