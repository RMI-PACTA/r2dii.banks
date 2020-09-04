write_tutorials <- function(.x = c("data", "match", "analysis")) {
  lapply(.x, write_tutorial)
}

write_tutorial <- function(.x) {
  yaml <- sub("(r2dii.)package", suffix("\\1", .x), readLines(rmd("yaml.Rmd")))
  readme <- readme_from(
    "maurolepore", suffix("r2dii.", .x), branch = "label-chunks"
  )

  lines <- c(
    yaml,
    "\n",
    readLines(rmd("setup.Rmd")),
    "\n",
    "## Description",
    "\n",
    readme
  )

  directory <- suffix("intro-r2dii-", .x)
  file <- sprintf("intro-r2dii-%s.Rmd", .x)
  path <- file.path(directory, file)
  writeLines(lines, file.path("inst", "tutorials", path))

  invisible(.x)
}

suffix <- function(x, y) sprintf("%s%s", x, y)

rmd <- function(file) {
  system.file("tutorials", file, mustWork = TRUE, package = "r2dii.banks")
}
