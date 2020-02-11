---
modulename: Text
title: /variablesubst/
giturl: gitlab.com/space-sh/text
editurl: /edit/master/doc/variablesubst.md
weight: 200
---
# Text module: Substitute in-text environment variables with values

Substitute variables in text for their given values 

## Example

Replace variables in provided text with values:
```sh
space -m text /variablesubst/ -- 'Hello \${VARIABLE}' 'VARIABLE' 'VARIABLE=World' 
```

Exit status code is expected to be 0 on success.
