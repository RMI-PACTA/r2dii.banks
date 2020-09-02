readme_url <- function(owner, repo, branch = "master") {
  sprintf(
    "https://raw.githubusercontent.com/%s/%s/%s/README.Rmd",
    owner, repo, branch
  )
}

remove_header <- function(readme_lines) {
  start <- grep("<!-- badges: end -->", readme_lines) + 1L
  end <- length(readme_lines)
  readme_lines[start:end]
}

readme_from <- function(owner, repo, branch = "master") {
  url <- readme_url(owner = owner, repo = repo, branch = branch)
  remove_header(readLines(url))
}
