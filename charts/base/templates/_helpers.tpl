{{/*
Expand the name of the chart.
*/}}
{{- define "base.name" -}}
{{- default .Chart.Name .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "base.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "base.version" -}}
{{- default .Chart.Version .Values.version | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "base.appVersion" -}}
{{- default .Chart.AppVersion .Values.appVersion | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "base.chart" -}}
{{- printf "%s-%s" (include "base.name" .) (include "base.version" .) | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "base.labels" -}}
helm.sh/chart: {{ include "base.chart" . }}
{{ include "base.selectorLabels" . }}
app.kubernetes.io/version: {{ include "base.appVersion" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "base.selectorLabels" -}}
app.kubernetes.io/name: {{ include "base.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "base.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "base.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
