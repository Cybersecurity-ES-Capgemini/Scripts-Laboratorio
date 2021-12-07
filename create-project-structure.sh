#
# This script creates a folder specific structure over one specific folder.
# 
# It reads the root folder, client name, project name and project description to create the following folder:
#   |
#   -> <ROOT_FOLDER>\<CLIENT>\<PROJECT_FOLDER_NAME>
# 
# And once created, it creates all folders from the defined structure
# 
# Defaults:
#   - This script has some default values that can be customized on script execution:
#   |
#   -> ROOT_FOLDER: "/var/projects/CAP-Ciberseguridad-ES/Documentacion_Proyectos"
#   -> PROJECT_FOLDER_NAME: "<DATE (in yyyMM format)>-<PROJECT_DESCRIPTION>"
# 
# Note: Before creating all the folder structure, user will be asked to confirm the location where all structure folders
#       will be created. This confirmation accepts ("y" or "yes") to accept and ("n", "N" or "no") to deny the creation.
#       Otherwise, the script must exit without creating folders.
#    
#

#### Static variables ####
IFS=""
folders=('00 Informacion Recibida' '01 Reporting' '02 Fieldwork' '03 Screenshots' '04 Capturas de Tráfico' '05 Credenciales' '06 Reconocimiento previo' '07 Otros')
defaultFolder="$HOME/Documents/Documentacion_Proyectos"
##########################

#### Input information reading ####
read -p 'Enter Client Name: ' client
read -p 'Enter project description: ' description
DATE=$(date +%Y%m)
defaultProject="$DATE-$description"
###################################

#### Default values replacing (if needed) ####
read -p "Enter project folder name [$defaultProject]: " project

if [[ $project == "" ]]; then
  project=$defaultProject
fi

read -p "Enter root projects folder [$defaultFolder]: " folder

if [[ $folder == "" ]]; then
  folder=$defaultFolder
fi

if [[ ${folder[-1]} == "/" ]]; then
  folder=${folder%?}
fi
root_folder="$folder/$client/$project"
##############################################

#### Confirmation ####
read -p "Are you sure you want to create folder structure in $root_folder ? (y/[N]/yes/no): " confirmation
######################
echo $confirmation
#### Execution ####

if [[ $confirmation == "y"  || $confirmation == "yes" ]]; then
  for folder in ${folders[@]}; do
    mkdir -p "$root_folder/$folder"
    if [[ $? -ne 0 ]]; then
      echo "Error during creating folder. Please, review user and folder permissions."
      exit 1
    fi
  done
  echo "Folders created"

elif [[ $confirmation == "" || $confirmation == "n" || $confirmation == "N" || $confirmation == "no" ]]; then
  echo "Exiting folder creation..."

else
  echo "Confirmation option not recognized. Exiting folder creation..."
fi
###################