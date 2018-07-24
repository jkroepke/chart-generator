#!/bin/sh

rm -rf build

gomplate --exclude='grid/templates/application' -d "values=file://${PWD}/values.yaml?type=application/yaml" --input-dir grid --output-dir build

for APP in $(gomplate -d values=file://$PWD/values.yaml?type=application/yaml -i '{{ range $index, $element := (ds "values").applications }}{{ $index }} {{ end }}'); do
    echo "${APP}" | gomplate  -d app=stdin: -d "values=file://${PWD}/values.yaml?type=application/yaml" --input-dir "grid/templates/application" --output-dir "build/templates/${APP}"
done;