
```
https://github.com/tercen/mean-operator.git
```

```R
# Necessary in RStudio if we want to install package from source with R code only, we don't need Rtools ...
options(buildtools.check = function(action) TRUE)
library(checkpoint)
checkpoint("2016-11-01")

packrat::init(options = list(
  use.cache = TRUE
  ))
  
devtools::install_github("tercen/TSON", ref = "1.4-rtson", subdir="rtson", upgrade_dependencies = TRUE)
devtools::install_github("tercen/teRcen", ref = "0.4.6", upgrade_dependencies = TRUE)

remove.packages("tercen", lib = "./packrat/lib/x86_64-pc-linux-gnu/3.3.2")

remove.packages("tercen", lib = "./packrat/lib/x86_64-w64-mingw32/3.3.2")
remove.packages("rtson", lib = "./packrat/lib/x86_64-w64-mingw32/3.3.2")
```

```R

packrat::status()
packrat::snapshot()

packrat::off()

packrat::bundle(include.src=FALSE, overwrite = TRUE, include.bundles=FALSE)

```

