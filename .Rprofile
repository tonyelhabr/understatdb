source("renv/activate.R")

base::.First.sys()

path_r_profile <- '~/.Rprofile'
if(file.exists(path_r_profile)) {
  source(path_r_profile)
}
rm('path_r_profile')

if (interactive()) {
  suppressMessages(library(devtools))
  suppressMessages(library(usethis))
  load_all()
}


