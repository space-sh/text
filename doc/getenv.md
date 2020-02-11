---
modulename: Text
title: /getenv/
giturl: gitlab.com/space-sh/text
editurl: /edit/master/doc/getenv.md
weight: 200
---
# Text module: Read environment variable values

Extract all values from a list of variable names.

## Example

Read the value of `VARIABLE` environment variable from the input:
```sh
VARIABLE="true" space -m text /getenv/ -- 'VARIABLE'
```

Exit status code is expected to be 0 on success.
