#' @examples
#' host <- "https://raw.githubusercontent.com"
#' x <- c("r2dii.data", "r2dii.match", "r2dii.analysis")
#' url <- sprintf("%s/maurolepore/%s/label-chunks/README.Rmd", host, x)
#' path <- tempfile(x)
#' output <- write_readme_tutorials(url, path)
#' cat(readLines(output[[1]]), sep = "\n")
#' @noRd
write_readme_tutorials <- function(url, path) {
  for (i in seq_along(path)) {
    write_tutorial2(url[[i]], path[[i]])
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
  readLines(rmd("yaml.Rmd"))
}

get_body <- function(url) {
  strip_setup(strip_badges(strip_yaml(readLines(url))))
}

get_setup <- function() {
  readLines(rmd("setup.Rmd"))
}

get_readme <- function(.x) {
  readme <- readme_from(
    "maurolepore", suffix("r2dii.", .x), branch = "label-chunks"
  )
  strip_badges(strip_yaml(readme))
}

suffix <- function(x, y) sprintf("%s%s", x, y)

rmd <- function(file) {
  system.file("tutorials", file, mustWork = TRUE, package = "r2dii.banks")
}

==> devtools::check()

Updating r2dii.banks documentation
Loading r2dii.banks
Loading required package: r2dii.analysis
Loading required package: r2dii.data
Loading required package: r2dii.match
── Building ────────────────────────── r2dii.banks ──
Setting env vars:
Warning: [/home/mauro/git/r2dii.banks/R/strip_rmd.R:1] @example spans multiple lines. Do you want @examples?
● CFLAGS    : -Wall -pedantic -fdiagnostics-color=always
● CXXFLAGS  : -Wall -pedantic -fdiagnostics-color=always
● CXX11FLAGS: -Wall -pedantic -fdiagnostics-color=always
─────────────────────────────────────────────────────
✓  checking for file ‘/home/mauro/git/r2dii.banks/DESCRIPTION’ ...
─  preparing ‘r2dii.banks’:
✓  checking DESCRIPTION meta-information ...
─  checking for LF line-endings in source and make files and shell scripts
─  checking for empty or unneeded directories
   Removed empty directory ‘r2dii.banks/man’
─  building ‘r2dii.banks_0.0.1.9000.tar.gz’
   Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
     storing paths of more than 100 bytes is not portable:
     ‘r2dii.banks/inst/tutorials/intro-r2dii-analysis/rsconnect/documents/intro-r2dii-analysis.Rmd/shinyapps.io/’
   Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
     storing paths of more than 100 bytes is not portable:
     ‘r2dii.banks/inst/tutorials/intro-r2dii-analysis/rsconnect/documents/intro-r2dii-analysis.Rmd/shinyapps.io/2dii/’
   Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
     storing paths of more than 100 bytes is not portable:
     ‘r2dii.banks/inst/tutorials/intro-r2dii-analysis/rsconnect/documents/intro-r2dii-analysis.Rmd/shinyapps.io/2dii/intro-r2dii-analysis.dcf’
   Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
     storing paths of more than 100 bytes is not portable:
     ‘r2dii.banks/inst/tutorials/intro-r2dii-data/rsconnect/documents/intro-r2dii-data.Rmd/shinyapps.io/2dii/’
   Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
     storing paths of more than 100 bytes is not portable:
     ‘r2dii.banks/inst/tutorials/intro-r2dii-data/rsconnect/documents/intro-r2dii-data.Rmd/shinyapps.io/2dii/intro-r2dii-data.dcf’
   Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
     storing paths of more than 100 bytes is not portable:
     ‘r2dii.banks/inst/tutorials/intro-r2dii-match/rsconnect/documents/intro-r2dii-match.Rmd/shinyapps.io/2dii/’
   Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
     storing paths of more than 100 bytes is not portable:
     ‘r2dii.banks/inst/tutorials/intro-r2dii-match/rsconnect/documents/intro-r2dii-match.Rmd/shinyapps.io/2dii/intro-r2dii-match.dcf’

── Checking ────────────────────────── r2dii.banks ──
Setting env vars:
● _R_CHECK_CRAN_INCOMING_USE_ASPELL_: TRUE
● _R_CHECK_CRAN_INCOMING_REMOTE_    : FALSE
● _R_CHECK_CRAN_INCOMING_           : FALSE
● _R_CHECK_FORCE_SUGGESTS_          : FALSE
● NOT_CRAN                          : true
── R CMD check ─────────────────────────────────────────────────────────────────
─  using log directory ‘/home/mauro/git/r2dii.banks.Rcheck’
─  using R version 4.0.2 (2020-06-22)
─  using platform: x86_64-pc-linux-gnu (64-bit)
─  using session charset: UTF-8
─  using options ‘--no-manual --as-cran’
✓  checking for file ‘r2dii.banks/DESCRIPTION’
─  this is package ‘r2dii.banks’ version ‘0.0.1.9000’
─  package encoding: UTF-8
✓  checking package namespace information ...
✓  checking package dependencies (6.5s)
✓  checking if this is a source package
✓  checking if there is a namespace
✓  checking for executable files ...
✓  checking for hidden files and directories
N  checking for portable file names ...
   Found the following non-portable file paths:
     r2dii.banks/inst/tutorials/intro-r2dii-analysis/rsconnect/documents/intro-r2dii-analysis.Rmd/shinyapps.io/2dii/intro-r2dii-analysis.dcf
     r2dii.banks/inst/tutorials/intro-r2dii-data/rsconnect/documents/intro-r2dii-data.Rmd/shinyapps.io/2dii/intro-r2dii-data.dcf
     r2dii.banks/inst/tutorials/intro-r2dii-match/rsconnect/documents/intro-r2dii-match.Rmd/shinyapps.io/2dii/intro-r2dii-match.dcf
     r2dii.banks/inst/tutorials/intro-r2dii-analysis/rsconnect/documents/intro-r2dii-analysis.Rmd/shinyapps.io/2dii
     r2dii.banks/inst/tutorials/intro-r2dii-data/rsconnect/documents/intro-r2dii-data.Rmd/shinyapps.io/2dii
     r2dii.banks/inst/tutorials/intro-r2dii-match/rsconnect/documents/intro-r2dii-match.Rmd/shinyapps.io/2dii

   Tarballs are only required to store paths of up to 100 bytes and cannot
   store those of more than 256 bytes, with restrictions including to 100
   bytes for the final component.
   See section ‘Package structure’ in the ‘Writing R Extensions’ manual.
✓  checking for sufficient/correct file permissions
✓  checking serialization versions
✓  checking whether package ‘r2dii.banks’ can be installed (1.9s)
✓  checking installed package size ...
✓  checking package directory
N  checking for future file timestamps (717ms)
   unable to verify current time
✓  checking DESCRIPTION meta-information ...
✓  checking top-level files
✓  checking for left-over files
✓  checking index information
✓  checking package subdirectories ...
✓  checking R files for non-ASCII characters ...
✓  checking R files for syntax errors ...
✓  checking whether the package can be loaded (411ms)
✓  checking whether the package can be loaded with stated dependencies (427ms)
✓  checking whether the package can be unloaded cleanly (350ms)
✓  checking whether the namespace can be loaded with stated dependencies (343ms)
✓  checking whether the namespace can be unloaded cleanly (384ms)
✓  checking loading without being on the library search path (396ms)
✓  checking dependencies in R code (459ms)
✓  checking S3 generic/method consistency (665ms)
✓  checking replacement functions (377ms)
✓  checking foreign function calls (396ms)
✓  checking R code for possible problems (2s)
✓  checking for missing documentation entries (423ms)
─  checking examples ... NONE
✓  checking for non-standard things in the check directory
✓  checking for detritus in the temp directory

   See
     ‘/home/mauro/git/r2dii.banks.Rcheck/00check.log’
   for details.


── R CMD check results ───────────────────────────── r2dii.banks 0.0.1.9000 ────
Duration: 16.7s

> checking for portable file names ... NOTE
  Found the following non-portable file paths:
    r2dii.banks/inst/tutorials/intro-r2dii-analysis/rsconnect/documents/intro-r2dii-analysis.Rmd/shinyapps.io/2dii/intro-r2dii-analysis.dcf
    r2dii.banks/inst/tutorials/intro-r2dii-data/rsconnect/documents/intro-r2dii-data.Rmd/shinyapps.io/2dii/intro-r2dii-data.dcf
    r2dii.banks/inst/tutorials/intro-r2dii-match/rsconnect/documents/intro-r2dii-match.Rmd/shinyapps.io/2dii/intro-r2dii-match.dcf
    r2dii.banks/inst/tutorials/intro-r2dii-analysis/rsconnect/documents/intro-r2dii-analysis.Rmd/shinyapps.io/2dii
    r2dii.banks/inst/tutorials/intro-r2dii-data/rsconnect/documents/intro-r2dii-data.Rmd/shinyapps.io/2dii
    r2dii.banks/inst/tutorials/intro-r2dii-match/rsconnect/documents/intro-r2dii-match.Rmd/shinyapps.io/2dii

  Tarballs are only required to store paths of up to 100 bytes and cannot
  store those of more than 256 bytes, with restrictions including to 100
  bytes for the final component.
  See section ‘Package structure’ in the ‘Writing R Extensions’ manual.

> checking for future file timestamps ... NOTE
  unable to verify current time

0 errors ✓ | 0 warnings ✓ | 2 notes x

R CMD check succeeded


    welcome <-


`%||%` <- function (x, y){
    if (is_null(x)) {
      y
    } else {
      x
    }
}
