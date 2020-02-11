---
modulename: Text
title: /preprocess/
giturl: gitlab.com/space-sh/text
editurl: /edit/master/doc/preprocess
weight: 200
---
# Text module: Preprocess text contents

Performs variable substitution taking values from environment variables, filtering out `#ifdef`, `#ifndef` and other preprocessing directives.


## Example

Complete processing:
```bash
cat << EXAMPLE | NAME=Cadet ASTONISHED=false space -m text /preprocess/ -- -
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
