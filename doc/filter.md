---
modulename: Text
title: /filter/
giturl: gitlab.com/space-sh/text
editurl: /edit/master/doc/filter.md
weight: 200
---
# Text module: Filter out conditional preprocessing directives

Parses text and filters away `#ifdef`, `#ifndef` and other conditionals.

## Example

Filter out text from `stdin`:
```bash
cat << EXAMPLE | space -m text /filter/ -- -
#ifntrue \${ASTONISHED}
#ifdef \${NAME}
Eh \${NAME}, really?
#endif
#ifndef \${NAME}
Eh Anonymous, really?
#endif
#endif
EXAMPLE
```

Exit status code is expected to be 0 on success.
