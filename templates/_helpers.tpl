{{/*
Expand the name of the chart.
*/}}
{{- define "sorry-cypress.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sorry-cypress.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sorry-cypress.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sorry-cypress.labels" -}}
helm.sh/chart: {{ include "sorry-cypress.chart" . }}
{{ include "sorry-cypress.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sorry-cypress.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sorry-cypress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sorry-cypress.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sorry-cypress.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Set graphql schema url or api url of sorry-cypress
*/}}
{{- define "sorry-cypress.apiUrl" -}}
{{ required "A valid .Values.hostname entry required!" .Values.hostname }}/api
{{- end -}}

{{/*
Set dashboard url
*/}}
{{- define "sorry-cypress.dashboardUrl" -}}
{{ required "A valid .Values.hostname entry required!" .Values.hostname }}/
{{- end -}}

{{/*
Set S3 accessKey
*/}}
{{- define "sorry-cypress.s3.accessKey" -}}
{{ required "A valid .Values.director.config.s3.accessKey entry required!" .Values.director.config.s3.accessKey }}
{{- end -}}

{{/*
Set S3 secretKey
*/}}
{{- define "sorry-cypress.s3.secretKey" -}}
{{ required "A valid .Values.director.config.s3.secretKey entry required!" .Values.director.config.s3.secretKey }}
{{- end -}}

{{/*
Set S3 bucketName
*/}}
{{- define "sorry-cypress.s3.bucketName" -}}
{{ required "A valid .Values.director.config.s3.bucketName entry required!" .Values.director.config.s3.bucketName }}
{{- end -}}

{{/*
Set S3 regionName
*/}}
{{- define "sorry-cypress.s3.regionName" -}}
{{ required "A valid .Values.director.config.s3.regionName entry required!" .Values.director.config.s3.regionName }}
{{- end -}}

{{/*
Set mongodb database name
*/}}
{{- define "sorry-cypress.mongodb.database" -}}
{{- default "sorry-cypress" .Values.director.config.mongodb.database -}}
{{- end -}}

{{/*
Set mongodb uri
*/}}
{{- define "sorry-cypress.mongodb.uri" -}}
{{- default "mongodb://mongo:27017" .Values.director.config.mongodb.uri -}}
{{- end -}}

{{/*
Execution drivers for sorry-cypress director
*/}}
{{- define "sorry-cypress.director.executionDrivers" -}}
../execution/mongo/driver
{{- end -}}

{{/*
Screenshots drivers for sorry-cypress director
*/}}
{{- define "sorry-cypress.director.screenshotsDrivers" -}}
../screenshots/s3.driver
{{- end -}}

{{/*
Set ingress paths
*/}}
{{- define "sorry-cypress.ingress.paths" -}}
paths:
  - path: /
    backend:
      serviceName: dashboard
      servicePort: {{ .Values.service.dashboard.port }}
  - path: /api
    backend:
      serviceName: api
      servicePort: {{ .Values.service.api.port }}
  - path: /director
    backend:
      serviceName: director
      servicePort: {{ .Values.service.director.port }}
{{- end -}}
