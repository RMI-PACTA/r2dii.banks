remove_lines <- function(lines, pattern) {
  lines <- grep(pattern, lines)[1:2]
  first <- lines[[2]] + 1L
  last <- length(lines)
  lines[first:last]
}

readme_from <- function(owner, repo, branch = "master") {
  url <- readme_url(owner = owner, repo = repo, branch = branch)
  xfun::read_utf8(url)
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
