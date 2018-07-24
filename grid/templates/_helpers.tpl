{{- /* vim: set filetype=mustache: */ -}}
{{- $values := datasource "values" -}}
{{- `{{- /* vim: set filetype=mustache: */ -}}
{{- /*
name defines a template for the name of the ` -}}{{ $values.chartName }}{{- ` chart.

The prevailing wisdom is that names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters.

Parameters:

- .Values.nameOverride: Replaces the computed name with this given name
- .Values.namePrefix: Prefix
- .Values.global.namePrefix: Global prefix
- .Values.nameSuffix: Suffix
- .Values.global.nameSuffix: Global suffix

The applied order is: "global prefix + prefix + name + suffix + global suffix"

Usage: 'name: "{{- template "` -}}{{ $values.chartName }}{{- `.name" . -}}"'
*/ -}}

{{- define "` -}}{{ $values.chartName }}{{- `.name"}}
{{- $global := default (dict) .Values.global -}}
{{- $base := default .Chart.Name .Values.nameOverride -}}
{{- $gpre := default "" $global.namePrefix -}}
{{- $pre := default "" .Values.namePrefix -}}
{{- $suf := default "" .Values.nameSuffix -}}
{{- $gsuf := default "" $global.nameSuffix -}}
{{- $name := print $gpre $pre $base $suf $gsuf -}}
{{- $name | lower | trunc 54 | trimSuffix "-" -}}
{{- end -}}


{{- /*
fullname defines a suitably unique name for a resource by combining
the release name and the ` -}}{{ $values.chartName }}{{- ` chart name.

The prevailing wisdom is that names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters.

Parameters:

- .Values.fullnameOverride: Replaces the computed name with this given name
- .Values.fullnamePrefix: Prefix
- .Values.global.fullnamePrefix: Global prefix
- .Values.fullnameSuffix: Suffix
- .Values.global.fullnameSuffix: Global suffix

The applied order is: "global prefix + prefix + name + suffix + global suffix"

Usage: 'name: "{{- template "` -}}{{ $values.chartName }}{{- `.fullname" . -}}"'
*/ -}}
{{- define "` -}}{{ $values.chartName }}{{- `.fullname"}}
{{- $global := default (dict) .Values.global -}}
{{- $base := default (printf "%s-%s" .Release.Name .Chart.Name) .Values.fullnameOverride -}}
{{- $gpre := default "" $global.fullnamePrefix -}}
{{- $pre := default "" .Values.fullnamePrefix -}}
{{- $suf := default "" .Values.fullnameSuffix -}}
{{- $gsuf := default "" $global.fullnameSuffix -}}
{{- $name := print $gpre $pre $base $suf $gsuf -}}
{{- $name | lower | trunc 54 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "` -}}{{ $values.chartName }}{{- `.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Generate chart secret name
*/}}
{{- define "` -}}{{ $values.chartName }}{{- `.secretName" -}}
{{ default (include "` -}}{{ $values.chartName }}{{- `.fullname" .) .Values.existingSecret }}
{{- end -}}

{{- /*
` -}}{{ $values.chartName }}{{- `.labels.standard prints the standard ` -}}{{ $values.chartName }}{{- ` Helm labels.

The standard labels are frequently used in metadata.
*/ -}}
{{- define "` -}}{{ $values.chartName }}{{- `.labels.standard" -}}
app: {{ template "` -}}{{ $values.chartName }}{{- `.name" . }}
chart: {{ template "` -}}{{ $values.chartName }}{{- `.chart" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
{{- end -}}

{{/* matchLabels */}}
{{- define "` -}}{{ $values.chartName }}{{- `.matchLabels" -}}
release: {{ .Release.Name }}
app: "{{ template "harbor.name" . }}"
{{- end -}}

{{/* image */}}
{{- define "` -}}{{ $values.chartName }}{{- `.image" -}}
{{- if default true .imagestream -}}" "{{- else -}}{{ .image.repository }}:{{ .image.tag }}{{- end -}}
{{- end -}}
` -}}