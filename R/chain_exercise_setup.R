chain_exercise_setup <- function(lines) {
  x <- lines[chunk_start_id(lines)]

  labels <- sub("```\\{r.([^,]*).*\\}", "\\1", x)
  replacements <- c("setup", labels[1:(length(labels) - 1)])

  for (i in seq_along(x)) {
    patt <- sprintf("(```\\{r.[^,]*%s[^,]*.*)\\}", labels[[i]])
    repl <- sprintf("\\1, exercise.setup='%s'}", replacements[[i]])
    lines <- sub(patt, repl, lines)
  }

  lines
}
