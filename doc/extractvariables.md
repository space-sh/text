---
modulename: Text
title: /extractvariables/
giturl: gitlab.com/space-sh/text
editurl: /edit/master/doc/extractvariables.md
weight: 200
---
# Text module: Extract variables

Extract all variable names from text contents.

## Example

Extract VARIABLE from the input:
```sh
space -m text /extractvariables/ -- 'Hello \${VARIABLE}'
```

Exit status code is expected to be 0 on success.
