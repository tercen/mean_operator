https://rstudio.github.io/packrat/walkthrough.html

```R

devtools::install_github("tercen/TSON", ref = "1.4-rtson", subdir="rtson")
devtools::install_github("tercen/teRcen", ref = "0.3")

packrat::init(options = list(
  use.cache = TRUE,
  external.packages = 'devtools',
  load.external.packages.on.startup = FALSE))

```

```R

packrat::status()

packrat::bundle(include.src=FALSE, overwrite = TRUE, include.bundles=FALSE)

```

```bash
R -e "packrat::unbundle('./packrat/bundles/testpackrat3-2017-10-21.tar.gz', '../unbundle')"
```