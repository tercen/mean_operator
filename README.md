
```
https://github.com/tercen/mean-operator.git
```

```R

packrat::init(options = list(
  use.cache = TRUE,
  external.packages = 'devtools',
  load.external.packages.on.startup = FALSE))
  
devtools::install_github("tercen/TSON", ref = "1.4-rtson", subdir="rtson", upgrade_dependencies = FALSE)
devtools::install_github("tercen/teRcen", ref = "0.4.1", upgrade_dependencies = FALSE)

```

```R

packrat::status()

packrat::bundle(include.src=FALSE, overwrite = TRUE, include.bundles=FALSE)

```

