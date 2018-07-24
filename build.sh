#!/bin/sh

rm -rf build

CHART_NAME=$(gomplate -d values=file://$PWD/values.yaml?type=application/yaml -i '{{ (ds "values").chartName }}')

OUTPUT_DIR="build/${CHART_NAME}/"

# Generate chart for global apps
gomplate --exclude='grid/templates/application' -d "values=file://${PWD}/values.yaml?type=application/yaml" --input-dir grid --output-dir "${OUTPUT_DIR}"

# Generate chart for every app
for APP in $(gomplate -d values=file://$PWD/values.yaml?type=application/yaml -i '{{ range $index, $element := (ds "values").applications }}{{ $index }} {{ end }}'); do
    echo "${APP}" | gomplate  -d app=stdin: -d "values=file://${PWD}/values.yaml?type=application/yaml" --input-dir "grid/templates/application" --output-dir "${OUTPUT_DIR}/templates/${APP}"
done;

# Clear non used files
find build -type f -empty -delete

# lint results
helm lint "${OUTPUT_DIR}"