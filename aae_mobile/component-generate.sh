#!/bin/bash

FILES=./aae_mobile
DIRECTORY=$PWD

echo $DIRECTORY

read -r -p 'Name of new component: ' name

### Generate className for generation
componentName=$name
suffix="$(echo ${name} | cut -d'_' -f2 <<< ${name})"
prefix="$(echo ${name} | cut -d'_' -f1 <<< ${name})"
suffixName="$(tr '[:lower:]' '[:upper:]' <<< ${suffix:0:1})${suffix:1}"
className="$(tr '[:lower:]' '[:upper:]' <<< ${prefix:0:1})${prefix:1}${suffixName}"

functionName="$(tr '[:lower:]' '[:lower:]' <<< ${prefix:0:1})${prefix:1}${suffixName}"

 _generate_component_file_structure() {
    ### [_generate_component_file_structure] generates directory file structure for new component
    mkdir lib/$name && cd lib/$name
    mkdir ./bloc
    # TODO (rpaglinawan)
    mkdir ./repository
    # TODO (rpaglinawan)
    mkdir ./page
    # TODO (rpaglinawan)
    mkdir ./component
    # TODO (rpaglinawan)
}

 _generate_model() {
    ### [_generate_model] generates boiler plate code for new component view model
    template_directory="$DIRECTORY/lib/tool"
    generated_directory=$PWD
    # cd template_directory
    echo "directory in component generation: $PWD"
    cd model

    touch ${fileName}_model.dart
    touch ${fileName}_model.t.dart
    echo "generating model"
    wait 

    cat ${template_directory}/new_model.dart.tmpl >> ${fileName}_model.t.dart 

    sed -e "s/##class_name##/${className}/g" -e "s/##file_name##/${fileName}/g" -e "s/##component_name##/${functionName}/g" -e "s/##function_name##/${functionName}/g" ${fileName}_model.t.dart >> ${fileName}_model.dart

    rm *.t.*

    echo "className: ${className} \n fileName: ${fileName} \n functionName: ${functionName}"

    cd ..
}

 _generate_component() {
    ### [_generate_component] generate component
    
    template_directory="$DIRECTORY/lib/tool"
    generated_directory=$PWD
    # cd template_directory
    echo "directory in component generation: $PWD"
    echo "directory of context $FILES"
    cd $name/component
    touch ${fileName}_component.dart
    touch ${fileName}_component.t.dart
    echo "generating cache"
    wait 

    cat ${template_directory}/new_component.dart.tmpl >> ${fileName}_component.t.dart 

    sed -e "s/##class_name##/${className}/g" -e "s/##file_name##/${fileName}/g" -e "s/##component_name##/${functionName}/g" -e "s/##function_name##/${functionName}/g" ${fileName}_component.t.dart >> ${fileName}_component.dart

    rm *.t.*

    echo "className: ${className} \n fileName: ${fileName} \n functionName: ${functionName}"

    cd ..
}

 _generate_repository() {
    ### [_generate_repository] generate repository
    
    template_directory="$DIRECTORY/lib/tool"
    generated_directory=$PWD
    # cd template_directory
    echo "directory in repository generation: $PWD"
    echo "directory of context $FILES"
    cd $name/repository
    touch ${fileName}_repository.dart
    touch ${fileName}_repository.t.dart
    echo "generating cache"
    wait 

    cat ${template_directory}/new_repository.dart.tmpl >> ${fileName}_repository.t.dart 

    sed -e "s/##class_name##/${className}/g" -e "s/##file_name##/${fileName}/g" -e "s/##component_name##/${functionName}/g" -e "s/##function_name##/${functionName}/g" ${fileName}_repository.t.dart >> ${fileName}_repository.dart

    rm *.t.*

    echo "className: ${className} \n fileName: ${fileName} \n functionName: ${functionName}"

    cd ..
}

 _generate_view() {
    ### [_generate_view] generate view
    template_directory="$DIRECTORY/lib/tool"
    generated_directory=$PWD


    echo ${generated_directory}

    # cd template_directory
    echo "directory in view generation: $PWD"
    cd $name/page

    touch ${fileName}_view.dart
    touch ${fileName}_view.t.dart
    echo "generating view"
    wait

    cat ${template_directory}/new_view.dart.tmpl >> ${fileName}_view.t.dart 

    sed -e "s/##class_name##/${className}/g" -e "s/##file_name##/${fileName}/g" -e "s/##component_name##/${fileName}/g" -e "s/##function_name##/${functionName}/g" ${fileName}_view.t.dart >> ${fileName}_view.dart

    rm *.t.*

    echo "className: ${className} \n fileName: ${fileName} \n functionName: ${functionName}"

    cd ..
}

 _generate_bloc() {
    ### [_generate_bloc] generates business logic to be consumed by widget
    template_directory="$DIRECTORY/lib/tool"
    generated_directory=$PWD

    echo ${generated_directory}

    cd $name/bloc
    touch ${fileName}_bloc.dart
    touch ${fileName}_bloc.t.dart
    echo "generating view"
    wait

    cat ${template_directory}/new_bloc.dart.tmpl >> ${fileName}_bloc.t.dart

    sed -e "s/##class_name##/${className}/g" -e "s/##file_name##/${fileName}/g" -e "s/##component_name##/${fileName}/g" -e "s/##function_name##/${functionName}/g" ${fileName}_bloc.t.dart >> ${fileName}_bloc.dart 

    rm *.t.*

    echo "className: ${className} \n fileName: ${fileName} \n functionName: ${functionName}"
    cd ..
}

_generate_view_model(){
    template_directory="$DIRECTORY/lib/tool"
    generated_directory=$PWD

    touch ${fileName}_view_model.dart
    touch ${fileName}_view_model.t.dart
    echo "generating view model"
    wait

    cat ${template_directory}/new_view_model.dart.tmpl >> ${fileName}_view_model.t.dart

    sed -e "s/##class_name##/${className}/g" -e "s/##file_name##/${fileName}/g" -e "s/##component_name##/${fileName}/g" -e "s/##function_name##/${functionName}/g" ${fileName}_view_model.t.dart >> ${fileName}_view_model.dart

    rm *.t.*

    echo "className: ${className} \n fileName: ${fileName} \n functionName: ${functionName}"
    cd ..
}

_define_names() {
    ### [className] converts a lowercase string to Dart format for classes (new_component => NewComponent)
    echo "functionName name: ${functionName}"
    fileName=$componentName 

    _generate_component_file_structure
    wait
    _generate_model
    wait
    _generate_bloc
    wait
    _generate_view
    wait
    _generate_component
    wait
    _generate_view_model
    wait
    _generate_repository
}

completion=0
working=true

nohup sleep 5 &
nohup sleep 20 &

_define_names