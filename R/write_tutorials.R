write_tutorials_from_readme <- function() {
  # README
  package <- c("r2dii.data", "r2dii.match", "r2dii.analysis")
  pkg <- sub("\\.", "-", package)

  raw <- sprintf(
    "https://raw.githubusercontent.com/maurolepore/%s/label-chunks", package
  )
  url <- sprintf("%s/README.Rmd", raw)

  welcome <- sprintf("First steps with %s", pkg)

  suffix <- paste0(pkg, "-first-steps")
  parent <- file.path(tutorials_path(), suffix)
  suppressWarnings(invisible(lapply(parent, dir.create)))
  path <- file.path(parent, paste0(suffix, ".Rmd"))

  write_tutorials(url, path, welcome)
}

write_tutorials_from_get_started <- function() {
  # Get started
  package <- c("r2dii.match", "r2dii.analysis")
  pkg <- sub("\\.", "-", package)

  raw <- sprintf(
    "https://raw.githubusercontent.com/maurolepore/%s/label-chunks", package
  )
  url <- sprintf("%s/vignettes/%s.Rmd", raw, pkg)

  welcome <- sprintf("Get started with %s", package)

  suffix <- paste0(pkg, "-get-started")
  parent <- file.path(tutorials_path(), suffix)
  suppressWarnings(invisible(lapply(parent, dir.create)))
  path <- file.path(parent, paste0(suffix, ".Rmd"))

  write_tutorials(url, path, welcome)
}

#' @examples
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
#' suffix <- paste0(package, "-first-steps")
#' parent <- file.path(tutorials_path(), suffix)
#' suppressWarnings(invisible(lapply(parent, dir.create)))
#' path <- file.path(parent, paste0(suffix, ".Rmd"))
#'
#' write_tutorials(url, path, welcome)
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
#' suffix <- paste0(package, "-get-started")
#' parent <- file.path(tutorials_path(), suffix)
#' suppressWarnings(invisible(lapply(parent, dir.create)))
#' path <- file.path(parent, paste0(suffix, ".Rmd"))
#'
#' write_tutorials(url, path, welcome)
#' @noRd
write_tutorials <- function(url, path, welcome) {
  for (i in seq_along(path)) {
    write_tutorial(url[[i]], path[[i]], welcome[[i]])
  }

  styler::style_file(path)

  invisible(url)
}

#' @examples
#' host <- "https://raw.githubusercontent.com/"
#' url <- paste0(host, "maurolepore/r2dii.analysis/label-chunks/vignettes/r2dii-analysis.Rmd")
#' welcome = "Welcome"
#' path <- tempfile()
#' write_tutorial(url, path)
#' writeLines(xfun::read_utf8(path))
#' @noRd
write_tutorial <- function(url, path, welcome = "Welcome") {
  # TODO: Extract as get_lines()
  lines <- c(
    get_yaml(),
    "\n",
    get_setup(),
    "\n",
    # TODO: Extract as get_welcome()
    paste("##", welcome),
    "\n",
    # TODO: Extract as get_body()
    # FIXME:
    # This "```{r, eval = FALSE}" became this:
    # "```{r unlabeled-56, eval = FALSE, exercise.setup='setup'}" but should
    # have added `exercise = FALSE`.
    chain_exercise_setup(parse_body(url))
  )

  xfun::write_utf8(lines, path)

  invisible(url)
}

get_yaml <- function(.x) {
  xfun::read_utf8(tutorials_path("yaml.Rmd"))
}

parse_body <- function(url) {
  out <- xfun::read_utf8(url)
  out <- sanitize_chunks(out)
  out <- strip_yaml(out)
  out <- strip_roxygen_note(out)
  out <- strip_setup(out)
  out <- strip_title(out)
  out <- strip_badges(out)


  out <- set_exercise_false_if_eval_false(out)

  out
}

sanitize_chunks <- function(lines) {
  out <- trim_whitespace(lines)
  out <- label_unlabeled(out)
  # out <- add_extra_lines(out)
  out
}

label_unlabeled <- function(lines) {
  out <- lines
  for (i in seq_along(out)) {
    replacement <- sprintf("{r unlabeled-%s\\1}", i)
    pattern <- "\\{[ ]*r([ ]*,.*)\\}|\\{[ ]*r([ ]*)\\}"
    out[i] <- sub(pattern, replacement, out[i])
  }

  out
}

add_extra_lines <- function(out) {
  sub("$", "\n\n\n", out)
}

trim_whitespace <- function(lines) {
  trimed_inside <- sub("```[ ]+\\{", "```{", lines)
  trimws(trimed_inside)
}

set_exercise_false_if_eval_false <- function(lines) {
  sub("eval[.]*=[.]*FALSE", "eval=FALSE, exercise=FALSE", lines)
}

get_setup <- function() {
  xfun::read_utf8(tutorials_path("setup.Rmd"))
}

tutorials_path <- function(path = NULL) {
  parent <- "tutorials"
  path <- ifelse(is.null(path), parent, file.path(parent, path))

  system.file(path, mustWork = TRUE, package = "r2dii.banks")
}

`%||%` <- function(x, y) {
  if (is_null(x)) {
    y
  } else {
    x
  }
}
