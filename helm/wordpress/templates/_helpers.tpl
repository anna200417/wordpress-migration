{{- define "wordpress-legacy.name" -}}
wordpress-legacy
{{- end -}}

{{- define "wordpress-legacy.fullname" -}}
{{ include "wordpress-legacy.name" . }}
{{- end -}}
