targets::tar_make(
  # specify key outputs needed, let targets manage the workflow
  names = c('fit_diagnostics', 'fit_illustration')
)

# visualize the workflow
targets::tar_visnetwork()
