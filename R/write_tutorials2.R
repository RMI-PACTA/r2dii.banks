write_tutorials2 <- function(.x = c("data", "match", "analysis")) {
  lapply(.x, write_tutorial2)
}

#' @examples
#' .x <- "data"
#' write_tutorial2(.x)
#' @noRd
write_tutorial2 <- function(.x) {
  lines <- c(
    get_yaml(.x),
    "\n",
    get_setup(),
    "\n",
    "## Description",
    "\n",
    get_readme(.x)
  )

  directory <- suffix("intro-r2dii-", .x)
  file <- sprintf("intro-r2dii-%s.Rmd", .x)
  path <- file.path(directory, file)
  writeLines(lines, file.path("inst", "tutorials", path))

  invisible(.x)
}

get_yaml <- function(.x) {
  sub("(r2dii.)package", suffix("\\1", .x), readLines(rmd("yaml.Rmd")))
}

get_setup <- function() {
  readLines(rmd("setup.Rmd"))
}

get_readme <- function(.x) {
  readme <- readme_from(
    "maurolepore", suffix("r2dii.", .x), branch = "label-chunks"
  )
  strip_badges(strip_yaml(readme))
}

suffix <- function(x, y) sprintf("%s%s", x, y)

rmd <- function(file) {
  system.file("tutorials", file, mustWork = TRUE, package = "r2dii.banks")
}
