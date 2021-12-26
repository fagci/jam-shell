# JAM-shell

Bash script template engine.

Primary developing for JAM stack web applications, static blogs or static sites.

Can be used to generate configs.

## Features

__Templates with variable expansion__

```twig
<title>{ title }</title>
```

__Shell script variables, executions__
```bash
Created at: $(date +'%Y-%m-%d')
```

__YAML-like frontmatter__
```yaml
---
date: 2021-12-27
author: $(whoami)
generator: $0
---
```

_Note: text with spaces must be enclosed with double quotes_

__Frontmatter-like shell script__
```bash
---
date=2021-12-27
author=$(whoami)
generator=$0
---
```

_Note: text with spaces must be enclosed with double quotes_

__Use custom templates__
```bash
---
template='another-template.html'
---
```
