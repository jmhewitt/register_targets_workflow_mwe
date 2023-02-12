register_target(
  # fit linear regression model to data
  tar_target(
    name = fit_model,
    command = lm(formula = weight ~ group, data = project_data)
  )
)
