strip_yaml <- function(lines) {
  remove_lines_range(lines, untrim("---"), untrim("---"))
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

strip_setup <- function(lines) {
  lines[indices_excluding_setup(lines)]
}

indices_excluding_setup <- function(lines) {
  from <- setup_range(lines)$from
  to <- setup_range(lines)$to
  except_setup <- setdiff(seq_along(lines), from:to)
}

setup_range <- function(lines) {
  start_id <- chunk_start_id(lines)

  setup_pattern <- "opts_chunk\\$set\\("
  setup_id <- grep(setup_pattern, lines)

  end_pattern <- untrim("```")
  end_id <- grep(end_pattern, lines)

  list(
    from = start_id[start_id < setup_id][[1]],
    to = end_id[end_id > setup_id][[1]]
  )
}

chunk_start_id <- function(lines) {
  start_pattern <- "^[ ]*```[ ]*\\{r.*\\}"
  grep(start_pattern, lines)
}

untrim <- function(x) {
  sprintf("^[ ]*%s[ ]*$", x)
}

remove_lines_range <- function(lines, from, to) {
  if (!has_patteren(lines, from)) {
    return(lines)
  }
  if (!has_patteren(lines, to)) {
    return(lines)
  }

  .from <- grep(from, lines)[[1]]
  to_candidates <- grep(to, lines)
  .to <- to_candidates[to_candidates > .from][[1]]

  useful <- setdiff(seq_along(lines), .from:.to)
  lines[useful]
}

has_patteren <- function(lines, from) {
  length(grep(from, lines)) > 0L
}
