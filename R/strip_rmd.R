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

strip_badges <- function(lines) {
  from <- untrim("<!-- badges: start -->")
  to <- untrim("<!-- badges: end -->")
  remove_lines_range(lines, from, to)
}

untrim <- function(x) {
  sprintf("^[ ]*%s[ ]*$", x)
}

remove_lines_range <- function(lines, from, to) {
  if (!has_patteren(lines, from)) return(lines)
  if (!has_patteren(lines, to)) return(lines)

  .from <- grep(from, lines)[[1]]
  to_candidates <- grep(to, lines)
  .to <- to_candidates[to_candidates > .from][[1]]

  useful <- setdiff(seq_along(lines), .from:.to)
  lines[useful]
}

has_patteren <- function(lines, from) {
  length(grep(from, lines)) > 0L
}
