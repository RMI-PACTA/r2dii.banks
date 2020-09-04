write_tutorials_from_readme <- function() {
  # README
  package <- c("r2dii.data", "r2dii.match", "r2dii.analysis")
  raw <- sprintf(
    "https://raw.githubusercontent.com/maurolepore/%s/label-chunks", package
  )

  url <- sprintf("%s/README.Rmd", raw)

  welcome <- sprintf("First steps with %s", package)

  suffix <- paste0(package, "_first-steps")
  parent <- file.path(tutorials_path(), suffix)
  suppressWarnings(invisible(lapply(parent, dir.create)))
  path <- file.path(parent, paste0(suffix, ".Rmd"))

  write_tutorials(url, path, welcome)
}

write_tutorials_from_get_started <- function() {
  # Get started
  package <- c("r2dii.match", "r2dii.analysis")
  raw <- sprintf(
    "https://raw.githubusercontent.com/maurolepore/%s/label-chunks", package
  )

  url <- sprintf("%s/vignettes/%s.Rmd", raw, sub("\\.", "-", package))

  welcome <- sprintf("Get started with %s", package)

  suffix <- paste0(package, "_get-started")
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
#' suffix <- paste0(package, "_first-steps")
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
#' suffix <- paste0(package, "_get-started")
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

  invisible(url)
}

#' @examples
#' host <- "https://raw.githubusercontent.com/"
#' url <- paste0(host, "maurolepore/r2dii.match/label-chunks/vignettes/r2dii-match.Rmd")
#' path <- tempfile()
#' write_tutorial(url, path)
#' writeLines(readLines(path))
#' @noRd
write_tutorial <- function(url, path, welcome = "Welcome") {
  lines <- c(
    get_yaml(),
    "\n",
    get_setup(),
    "\n",
    paste("##", welcome),
    "\n",
    chain_exercise_setup(parse_body(url))
  )
  writeLines(lines, path)

  invisible(url)
}

get_yaml <- function(.x) {
  readLines(tutorials_path("yaml.Rmd"))
}

parse_body <- function(url) {
  out <- readLines(url)
  out <- sanitize_chunks(out)
  out <- strip_yaml(out)
  out <- strip_roxygen_note(out)
  out <- strip_setup(out)
  out <- strip_title(out)
  out <- strip_badges(out)
  out
}

sanitize_chunks <- function(lines) {
  out <- trim_whitespace(lines)
  out <- label_unlabeled(out)
  out
}

label_unlabeled <- function(lines) {
  out <- lines

  out <- c(
    "```{r a-b}",
    "```{r a-b, echo=TRUE}",
    "```{r }",
    "```{r}",
    "```{r, eval=FALSE}",
    "```{r eval=FALSE}",
    "```{r validate-matches, eval=FALSE, include=FALSE}",
    "whatever"
  )

  for (i in seq_along(out)) {
    replacement <- sprintf("{r unlabeled-%s\\1}", i)
    pattern <- "\\{[ ]*r([ ]*,.*)\\}|\\{[ ]*r([ ]*)\\}"
    out[i] <- sub(pattern, replacement, out[i])
#
#     pattern <- "\\{[ ]*r([ ]*)\\}"
#     out[i] <- sub(pattern, replacement, out[i])
  }

  out
}

trim_whitespace <- function(lines) {
  trimed_inside <- sub("```[ ]+\\{", "```{", lines)
  trimws(trimed_inside)
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
