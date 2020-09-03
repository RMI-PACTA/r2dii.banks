rs <- c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/bionic/latest")
options(repos = rs)

install.packages(c(
  "knitr",
  "learnr",
  "r2dii.banks",
  "rmarkdown",
  "shiny"
))
