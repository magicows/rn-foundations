# Repository guidance

Keep every skill independently installable.

- Do not depend on Claude plugin manifests, assistant-specific environment variables, sibling skills, parent directories, or globally installed helper files.
- Do not bundle general React Native documentation. Link to primary documentation when current API guidance is required.
- Keep runtime helpers diagnostic and non-destructive by default.
- Preserve third-party attribution when adapting existing resources.
- Run `bash scripts/validate.sh` after changing a skill.
