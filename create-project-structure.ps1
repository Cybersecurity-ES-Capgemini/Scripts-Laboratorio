<#
This script creates a folder specific structure over one specific folder.

It reads the root folder, client name, project name and project description to create the following folder:
  |
  -> <ROOT_FOLDER>\<CLIENT>\<PROJECT_FOLDER_NAME>

And once created, it creates all folders from the defined structure

Defaults:
  - This script has some default values that can be customized on script execution:
  |
  -> ROOT_FOLDER: "C:\Users\<UserName>\OneDrive - Capgemini\General - CAP-Ciberseguridad-ES\Documentacion Proyectos"
  -> PROJECT_FOLDER_NAME: "<DATE (in yyyMM format)> - <PROJECT_DESCRIPTION>"

Note: Before creating all the folder structure, user will be asked to confirm the location where all structure folders
      will be created. This confirmation accepts ("y" or "yes") to accept and ("n", "N" or "no") to deny the creation.
      Otherwise, the script must exit without creating folders.
    
#>

#### Static variables ####
$folders = @("01 Informacion Recibida","02 Informacion Enviada","03 Presentaciones","04 Papeles de Trabajo","05 Correos y comunicaciones","06 OneNote Seguimiento","07 Manuales")
$defaultFolder = "C:\Users\$env:UserName\OneDrive - Capgemini\General - CAP-Ciberseguridad-ES\Documentacion Proyectos"
##########################

#### Input information reading ####
$client = Read-Host 'Enter Client Name'
$description = Read-Host 'Enter project description'
$date = Get-Date -Format "yyyyMM"
$defaultProject = $date + " - " + $description
###################################

#### Default values replacing (if needed) ####
$project = Read-Host "Enter project folder name [$defaultProject]"

if ($project -eq ""){
	$project = $defaultProject
}

$folder = Read-Host "Enter root projects folder [$defaultFolder]"

if ($folder -eq ""){
	$folder = $defaultFolder
}

$root_folder = $folder + '\' + $client + '\' + $project
##############################################

#### Confirmation ####
$confirmation = Read-Host "Are you sure you want to create folder structure in $root_folder ? (y/N/yes/no)"
######################

#### Execution ####
If ($confirmation -eq "y" -Or $confirmation -eq "yes") {
	Foreach ($folder in $folders) {
		New-Item -Path $root_folder -Name $folder -ItemType "directory"
	}
  echo "Folders created"
}

ElseIf ($confirmation -eq "n" -Or $confirmation -eq "N" -Or $confirmation -eq "no") {
  echo "Exiting folder creation..."
}

Else {
  echo "Confirmation option not recognized. Exiting folder creation..."
}
###################