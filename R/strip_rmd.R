#' @example
#' url <- "https://git.io/JU37u"
#' out <- strip_tutorials_path(url)
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
  lines[indices_excluding_setup(lines)]
}

indices_excluding_setup <- function(lines) {
  from <- setup_range(lines)$from
  to <- setup_range(lines)$to
  except_setup <- setdiff(seq_along(lines), from:to)
}

setup_range <- function(lines) {
  start_pattern <- untrim("```\\{r.*\\}")
  start_id <- grep(start_pattern, lines)

  setup_pattern <-"opts_chunk\\$set\\("
  setup_id <- grep(setup_pattern, lines)

  end_pattern <- untrim("```")
  end_id <- grep(end_pattern, lines)

  list(
    from = start_id[start_id < setup_id][[1]],
    to = end_id[end_id > setup_id][[1]]
  )
}

strip_badges <- function(lines) {
  from <- untrim("<!-- badges: start -->")
  to <- untrim("<!-- badges: end -->")
  remove_lines_range(lines, from, to)
}

strip_roxygen_note <- function(lines) {
  note <- untrim("<!-- README.md is generated.*-->")
  sub(note, "", lines)
}

strip_title <- function(lines) {
  title <- untrim(".*src='https://imgur.com/A5ASZPE.png.*")
  sub(title, "", lines)
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
