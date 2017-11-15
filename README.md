
```
https://github.com/tercen/mean-operator.git
```

```R
# Necessary in RStudio if we want to install package from source with R code only, we don't need Rtools ...
options(buildtools.check = function(action) TRUE)

packrat::init(options = list(
  use.cache = TRUE,
  external.packages = 'devtools',
  load.external.packages.on.startup = FALSE))
  
devtools::install_github("tercen/TSON", ref = "1.4-rtson", subdir="rtson", upgrade_dependencies = FALSE)
devtools::install_github("tercen/teRcen", ref = "0.4.1", upgrade_dependencies = TRUE)

remove.packages("tercen", lib = "./packrat/lib/x86_64-pc-linux-gnu/3.3.2")

remove.packages("tercen", lib = "./packrat/lib/x86_64-w64-mingw32/3.3.2")
remove.packages("rtson", lib = "./packrat/lib/x86_64-w64-mingw32/3.3.2")
```

```R

packrat::status()
packrat::snapshot()

packrat::bundle(include.src=FALSE, overwrite = TRUE, include.bundles=FALSE)

```

