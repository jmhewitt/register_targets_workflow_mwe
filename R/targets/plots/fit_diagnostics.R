register_target(
  # save basic diagnostic information to disk
  tar_target(
    name = fit_diagnostics,
    command = {
      
      # specify output directory and ensure it exists
      f = file.path('output', 'diagnostics')
      dir.create(path = f, showWarnings = FALSE, recursive = TRUE)
      
      # specify output files
      ofile_summary = file.path(f, paste(tar_name(), '_summary.txt', sep = ''))
      ofile_plots = file.path(f, paste(tar_name(), '_plots.pdf', sep = ''))
      
      # log fit summary to disk
      sink(file = ofile_summary)
      print(summary(fit_model))
      sink()
      
      # log diagnostic plots to disk
      pdf(file = ofile_plots)
      print(plot(fit_model))
      dev.off()
      
      # record output
      list(
        path = c(ofile_summary, ofile_plots),
        timestamp = Sys.time()
      )
    }
  )
)
