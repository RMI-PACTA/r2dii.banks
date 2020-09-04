#' @examples
#' host <- "https://raw.githubusercontent.com"
#' x <- c("r2dii.data", "r2dii.match", "r2dii.analysis")
#' url <- sprintf("%s/maurolepore/%s/label-chunks/README.Rmd", host, x)
#' path <- tempfile(x)
#' output <- write_tutorials2(url, path)
#'
#' show <- 20L
#' cat(head(readLines(path[[1]]), show), sep = "\n")
#' @noRd
write_tutorials2 <- function(url, path) {
  for (i in seq_along(path)) {
    write_tutorial2(url[[i]], path[[i]])
  }

  invisible(url)
}

#' @examples
#' host <- "https://raw.githubusercontent.com/"
#' url <- paste0(host, "maurolepore/r2dii.data/label-chunks/README.Rmd")
#' path <- tempfile()
#' write_tutorial2(url, path)
#' cat(readLines(path), sep = "\n")
#' @noRd
write_tutorial2 <- function(url, path, welcome = "## Welcome") {
  lines <- c(
    get_yaml(),
    "\n",
    get_setup(),
    "\n",
    welcome,
    "\n",
    get_body(url)
  )
  writeLines(lines, path)

  invisible(url)
}

get_yaml <- function(.x) {
  readLines(rmd("yaml.Rmd"))
}

get_body <- function(url) {
  strip_setup(strip_badges(strip_yaml(readLines(url))))
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

`%||%` <- function (x, y){
    if (is_null(x)) {
      y
    } else {
      x
    }
}
