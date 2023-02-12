register_target(
  # plot model fit against data
  tar_target(
    name = fit_illustration,
    command = {
      
      # specify output directory and ensure it exists
      f = file.path('output', 'figures', 'manuscript')
      dir.create(path = f, showWarnings = FALSE, recursive = TRUE)
      
      # specify output files
      ofile = file.path(f, paste(tar_name(), '.png', sep = ''))
      
      # model fit: only group means are estimated since this is an anova model
      df = unique(
        cbind(
          group = fit_model$model$group,
          data.frame(predict(object = fit_model, interval = 'confidence'))
        )
      )
      
      # build plot
      fit_alpha = .6
      fit_col = 'blue'
      fit_aes = aes(x = group, y = fit, ymin = lwr, ymax = upr)
      pl = ggplot(project_data, aes(y = weight, x = group)) + 
        # plot data
        geom_boxplot() + 
        # overlay model fit
        geom_point(
          data = df, 
          mapping = fit_aes,
          col = fit_col,
          alpha = fit_alpha
        ) + 
        geom_errorbar(
          data = df, 
          mapping = fit_aes,
          col = fit_col,
          alpha = fit_alpha,
          lwd = 1
        ) + 
        # formatting
        theme_few()
      
      # save plot
      ggsave(pl, filename = ofile, dpi = 'print')

      # record output
      list(
        path = ofile,
        timestamp = Sys.time()
      )
    }
  )
)
