library(targets)
library(future)

# support parallelization
plan(multisession)

tar_option_set(
  # set packages to load
  packages = c('dplyr', 'ggplot2', 'ggthemes'),
  deployment = 'main'
)

# project target container
target_list = list()

# add a tar_target object to a target container
#
# Parameters:
#   target - object to add to target_container
#   target_container - list() object with all targets
#   env - location in which target_container is defined
register_target = function(
    target, target_container = target_list, env = parent.frame()
) {
  # deparse target_container to a character, if needed
  if(is.character(target_container)) {
    tgt = target_container
  } else {
    tgt = deparse(substitute(target_container))
  }
  # append target to the container; update container
  assign(x = tgt, value = c(get(x = tgt), target), envir = env)
}

## load R files and workflows; must use register_target to populate target_list
lapply(list.files("R", full.names = TRUE, recursive = TRUE, pattern = '\\.R'), 
       source)

# pass on the list of updated targets to workflow manager
target_list
