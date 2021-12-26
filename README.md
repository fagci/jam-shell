# JAM-shell

Bash script template engine.

Primary developing for JAM stack web applications, static blogs or static sites.

Can be used to generate configs.

## Features

Templates with variable expansion

```twig
<title>{ title }</title>
```

Shell script variables, executions
```bash
Created at: $(date +'%Y-%m-%d')
```

YAML-like frontmatter
```yaml
---
date: 2021-12-27
author: $(whoami)
generator: $0
---
```

Frontmatter-like shell script
```bash
---
date=2021-12-27
author=$(whoami)
generator=$0
---
```

Use custom templates
```bash
---
template='another-template.html'
---
```
