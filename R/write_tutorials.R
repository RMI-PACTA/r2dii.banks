#' @examples
#'
#' # README
#' package <- c("r2dii.data", "r2dii.match", "r2dii.analysis")
#' raw <- sprintf(
#'   "https://raw.githubusercontent.com/maurolepore/%s/label-chunks", package
#' )
#'
#' url <- sprintf("%s/README.Rmd", raw)
#'
#' welcome <- sprintf("First steps with %s", package)
#'
#' suffix <- paste0(package, "_first-steps")
#' parent <- file.path(tutorials_path(), suffix)
#' suppressWarnings(invisible(lapply(parent, dir.create)))
#' path <- file.path(parent, paste0(suffix, ".Rmd"))
#'
#' write_tutorials(url, path, welcome)
#'
#' show <- 100L
#' cat(head(readLines(path[[1]]), show), sep = "\n")
#'
#'
#'
#' # Get started
#' package <- c("r2dii.match", "r2dii.analysis")
#' raw <- sprintf(
#'   "https://raw.githubusercontent.com/maurolepore/%s/label-chunks", package
#' )
#'
#' url <- sprintf("%s/vignettes/%s.Rmd", raw, sub("\\.", "-", package))
#'
#' welcome <- sprintf("Get started with %s", package)
#'
#' suffix <- paste0(package, "_get-started")
#' parent <- file.path(tutorials_path(), suffix)
#' suppressWarnings(invisible(lapply(parent, dir.create)))
#' path <- file.path(parent, paste0(suffix, ".Rmd"))
#'
#' write_tutorials(url, path, welcome)
#'
#' show <- 100L
#' cat(head(readLines(path[[1]]), show), sep = "\n")
#' @noRd
write_tutorials <- function(url, path, welcome) {
  for (i in seq_along(path)) {
    write_tutorial2(url[[i]], path[[i]], welcome[[i]])
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
  readLines(tutorials_path("yaml.Rmd"))
}

get_body <- function(url) {
  out <-readLines(url)
  out <- strip_yaml(out)
  out <- strip_roxygen_note(out)
  out <- strip_setup(out)
  out <- strip_title(out)
  out <- strip_badges(out)
  out
}

get_setup <- function() {
  readLines(tutorials_path("setup.Rmd"))
}

tutorials_path <- function(path = NULL) {
  parent <- "tutorials"
  path <- ifelse(is.null(path), parent, file.path(parent, path))

  system.file(path, mustWork = TRUE, package = "r2dii.banks")
}

`%||%` <- function (x, y){
    if (is_null(x)) {
      y
    } else {
      x
    }
}
