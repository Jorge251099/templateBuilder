#!/bin/bash
#

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
endColour="\033[0m\e[0m"



function ctrl_c (){
  echo -e "\n${redColour}[!] Saliendo...${endColour}"
  exit 1
}

function finally(){
  echo -e "\n${yellowColour}[*]${endColour} ${grayColour}Programa terminado...${endColour}"
}

function error(){
  echo -ne "\n${redColour}[!] Se ha producido un error.${endColour}"
}

trap ctrl_c INT
trap finally EXIT
trap error ERR

declare -A tipos_archivos #declaramos un array asociativo con los tipos archivos

tipos_archivos=(
  [1]=Bash
  [2]=python
  [3]=javaScript
  [4]=cpp
  [5]=Exit
  )

execution(){
: << _doc_
    Este pequeño script se hace para evitar tantos "echo", y así
    hacer el uso de "here-document" sobre cat.
_doc_

  cat - << EOF #"EOF" -> es el "here tag"
Escoje la operación: 
$( :<<_eof
  haremos una sustitución por un menú interactivo
_eof

  for key in ${!tipos_archivos[@]}; do
    #printf "%s. %s\n" \
    #  $key \
    #  ${tipos_archivos[$key]}
    echo -e "${yellowColour}$key.${endColour} ${blueColour}${tipos_archivos[$key]}${endColour}"
  done

)
EOF
#|-------Fin del menú dinamico 

  #read -p "tipo de archivo: " opcion
  echo -e "${yellowColour}[+]${endColour} ${grayColour}Tipo de archivo: ${endColour}" && read opcion 
}

while 
  execution
  true
do
  [[ ! "$opcion" =~ ^[1-5]$ ]] && echo "el valor tiene que ser entre 1 y 5" #definimos a opcion como valor entero
  if [ "$opcion" -eq 1 ];then
    echo -e "${yellowColour}[+]${endColour}${grayColour} Crearas un archivo de tipo bash${endColour}"
    echo -ne "${yellowColour}[+]${endColour} ${grayColour}Escriba el nombre: ${endColour}" && read nombre
    /usr/bin/touch ${nombre}.sh 
    /usr/bin/chmod +x ${nombre}.sh
    echo "#!/bin/bash

#Purpose:
#Version:1.0
#Created Date:
#Modified Date:
#Website:
#Script name: ${nombre}
#Author: Jorge Donaires Mendoza

#LINEOFTEXT

# END #

    ">${nombre}.sh
    break
  elif [ "$opcion" -eq 2 ];then
    echo -e "${yellowColour}[+]${endColour}${grayColour} Crearas un archivo de tipo python${endColour}"
    echo -ne "${yellowColour}[+]${endColour} ${grayColour}Escriba el nombre: ${endColour}" && read nombre
    /usr/bin/touch ${nombre}.py 
    /usr/bin/chmod +x ${nombre}.py
    echo "#!/env/bin/python

#Purpose:
#Version:1.0
#Created Date:
#Modified Date:
#Website:
#Script name: ${nombre}
#Author: Jorge Donaires Mendoza

#LINEOFTEXT

def main():
  print ('Hello World!!!')

if __name__ == '__main__':

  try:
    main()

  except KeyboardInterrupt:
    print('Programa cancelado')

# END #
    ">${nombre}.py
    break
  elif [ "$opcion" -eq 3 ];then
    echo -e "${yellowColour}[+]${endColour}${grayColour} Crearas un archivo de tipo Java Script${endColour}"
    echo -ne "${yellowColour}[+]${endColour} ${grayColour}Escriba el nombre: ${endColour}" && read nombre
    /usr/bin/touch ${nombre}.js 
    break
  elif [ "$opcion" -eq 4 ];then
    echo -e "${yellowColour}[+]${endColour}${grayColour} Crearas un archivo de tipo C++${endColour}"
    echo -ne "${yellowColour}[+]${endColour} ${grayColour}Escriba el nombre: ${endColour}" && read nombre
    /usr/bin/touch ${nombre}.cpp
    /usr/bin/chmod +x ${nombre}.cpp
    echo "#include<iostream>
//Purpose:
//Version:1.0
//Created Date:
//Modified Date:
//Website:
//Script name: ${nombre}
//Author: Jorge Donaires Mendoza

//LINEOFTEXT

using namespace std;

int main(){

  cout<<"Hello Word";

  return 0
}

// END //

    ">${nombre}.cpp
    break
  elif [ "$opcion" -eq 5 ]; then
    echo -e "\n${yellowColour}[-]${endColour} ${blueColour} Saliendo del programa. ${endColour}\n"
    exit 0
  fi
done
