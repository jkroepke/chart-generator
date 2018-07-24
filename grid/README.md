{{- /* vim: set filetype=mustache: */ -}}
{{- $values := datasource "values" -}}
# Variables
## Chart Settings
| Name | Description | Default |
|------|-------------|---------|
| `nameOverride` | Replaces the computed name with this given name | `nil` |
| `namePrefix` | Prefix | `nil` |
| `global.namePrefix` | Global prefix | `nil` |
| `nameSuffix` | Suffix | `nil` |
| `global.nameSuffix` | Global suffix | `nil` |
| `imagePullSecrets` | Image pull secrets | `nil` |


{{- range $key, $value := $values.applications }}
## {{ $key }}
| Name | Description | Default |
|------|-------------|---------|
| `{{ $key }}.replicaCount` | k8s replicas | 1 |
| `{{ $key }}.image.repository` | Container image to use | `{{ $value.image }}` |
| `{{ $key }}.image.pullPolicy` | Container pull policy | `Always` if `imageTag` is `latest`, else `IfNotPresent` |
| `{{ $key }}.image.tag` | Container image tag to deploy |
| `{{ $key }}.imageStream` | Use openshift.io Imagestreams | false |
| `{{ $key }}.nodeSelector` | Node labels for pod assignment | {} |
| `{{ $key }}.affinity` | Affinity settings for pod assignment | {} |
| `{{ $key }}.tolerations` | Toleration labels for pod assignment | [] |
| `{{ $key }}.schedulerName` | Name of an alternate scheduler | `nil` |
| `{{ $key }}.existingSecret` | Use Existing secret for {{ $key }} | `nil` |
| `{{ $key }}.podAnnotations` | Annotations | `nil` |
| `{{ $key }}.env.open` | Public environment variables {{ $key }} | `nil` |
| `{{ $key }}.env.secret` | Use secrets for {{ $key }} | `nil` |
| `{{ $key }}.service.externalIPs` | External IPs to listen on |
| `{{ $key }}.service.port` | Port |
| `{{ $key }}.service.type` | k8s service type exposing ports, e.g. `NodePort` |
| `{{ $key }}.service.nodePort` | NodePort value if service.type is `NodePort` |

{{- end }}