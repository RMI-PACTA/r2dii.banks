write_tutorial <- function(suffix) {
  replacement <- sprintf("\\1%s", suffix)
  yaml <- sub("(r2dii.)package", replacement, readLines(rmd("yaml.Rmd")))
  lines <- c(
    yaml,
    readLines(rmd("setup.Rmd")),
    readme_from("maurolepore", sprintf("r2dii.%s", suffix), branch = "label-chunks")
  )

  path <- file.path(
    sprintf("intro-r2dii-%s", suffix),
    sprintf("intro-r2dii-%s.Rmd", suffix)
  )
  writeLines(lines, file.path("inst", "tutorials", path))

  invisible(suffix)
}

rmd <- function(file) {
  system.file("tutorials", file, mustWork = TRUE, package = "r2dii.banks")
}
