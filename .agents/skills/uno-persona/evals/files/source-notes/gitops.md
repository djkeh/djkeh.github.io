# Frozen source notes: GitOps and Kubernetes configuration

Retrieved: 2026-08-08 UTC

## OpenGitOps principles

Source: [https://opengitops.dev/](https://opengitops.dev/)

* A GitOps-managed system expresses its desired state declaratively.
* Desired state is stored with immutability, versioning, and complete version history.
* Software agents automatically pull desired-state declarations from the source.
* Software agents continuously observe actual state and attempt to apply the desired state.

## Kubernetes declarative configuration

Source: [https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/)

* Kubernetes can create, update, and delete objects from configuration files with `kubectl apply`.
* Configuration files are typically stored in source control such as Git, while live object configuration is observed from cluster storage.
* Direct writes to live objects can remain without being merged back into the configuration files, creating a difference that operators must recognize.
* `kubectl diff` previews changes that `kubectl apply` would make. It uses server-side dry run and needs the corresponding API permissions.

## Evaluation boundary

The manual `kubectl` drift example, pull-request workflow, health checks, rollback policy, and plaintext-secret warning are scenario requirements supplied by the evaluation prompt. Treat them as requested operational guidance, not as direct claims from the two sources unless the note above explicitly supports them.
