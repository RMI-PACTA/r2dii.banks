#' @example
#' url <- "https://git.io/JU37u"
#' out <- strip_rmd(url)
#' cat(head(out), sep = "\n")
#'
#' # Compare
#' cat(head(readLines(url)), sep = "\n")
#' @noRd
strip_rmd <- function(url) {
  strip_setup(strip_yaml(readLines(url)))
}

strip_yaml <- function(lines) {
  remove_lines_range(lines, untrim("---"), untrim("---"))
}

strip_setup <- function(lines) {
  from <- untrim("```\\{r setup.*\\}")
  to <- untrim("```")
  remove_lines_range(lines, from, to)
}

untrim <- function(x) {
  sprintf("^[ ]*%s[ ]*$", x)
}

remove_lines_range <- function(lines, from, to) {
  .from <- grep(from, lines)[[1]]
  to_candidates <- grep(to, lines)
  .to <- to_candidates[to_candidates > .from][[1]]

  useful <- setdiff(seq_along(lines), .from:.to)
  lines[useful]
}

remove_lines <- function(lines, pattern) {
  lines <- grep(pattern, lines)[1:2]
  first <- lines[[2]] + 1L
  last <- length(lines)
  lines[first:last]
}

readme_from <- function(owner, repo, branch = "master") {
  url <- readme_url(owner = owner, repo = repo, branch = branch)
  readLines(url)
}

readme_url <- function(owner, repo, branch = "master") {
  sprintf(
    "https://raw.githubusercontent.com/%s/%s/%s/README.Rmd",
    owner, repo, branch
  )
}

remove_readme_header <- function(readme_lines) {
  start <- grep("<!-- badges: end -->", readme_lines) + 1L
  end <- length(readme_lines)
  readme_lines[start:end]
}

